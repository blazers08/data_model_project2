# -*- coding: utf-8 -*-
from datetime import datetime
from flask import Blueprint, render_template, jsonify, redirect, url_for, request, g, session
from re import escape
from project_name.views.misc import items_pagebar
from project_name.extension import mysql


mod = Blueprint('play', __name__)


@mod.route('/')
@mod.route('/simple_list', methods=['GET', 'POST'])
@mod.route('/simple_list/<int:page>/<int:items>', methods=['GET', 'POST'])
def simple_list(page=0, items=10):
    """簡單的game列表
    查出依條件查出 符合條件的資料
    可能有 LIMIT <from>,<how many>
    可能有 SORY BY <column> ASC/DESC
    然後 assign 給 html
    有一些經過標準計算取得的數值要 assign 給清單控制分頁用
    """
    conn = mysql.get_db()


    sql1 = u"SELECT COUNT(*) as total FROM play"
    # 先取得符合條件的 record 一共有多少筆
    with conn.cursor() as cursor:
        cursor.execute(sql1)
        row = cursor.fetchone()
        total = row[0]
    print(total)

    sort_condition = ""
    if 'sort' in request.args and 'asc' in request.args:  # 檢查是否同時提供排序的目標欄位及排序方法
        sort_condition = " ORDER BY {0} ".format(request.args.get('sort'))
        if request.args.get('asc') == '0':  # 表示不要asc, 即desc
            sort_condition += " DESC"
        else:  # 表示要asc
            sort_condition += " ASC"
    else:
        sort_condition = "ORDER BY play_id ASC"

    sql2 = "SELECT play_id, t1.player_name as pitcher_name, t2.player_name as batter_name, match_id, inning, half FROM play p INNER JOIN player t1 ON t1.player_id = p.pitcher_id INNER JOIN player t2 ON t2.player_id = p.batter_id " + sort_condition
    skip = page * items
    if skip >= total:
        skip = 0
    sql2 += " LIMIT {0},{1}".format(skip, items)
    print(sql2)

    # 執行 sql2 取得資料 (多筆)
    plays = []
    with conn.cursor() as cursor:
        cursor.execute(sql2)
        plays = cursor.fetchall()      
    print(plays)

    misc = items_pagebar(total, page, items, 'play_id')  # 計算pagebar需要之參數

    return render_template('play/list.html', plays=plays, misc=misc, action='simple_list')


@mod.route('/search', methods=['GET', 'POST'])
@mod.route('/search/<int:page>/<int:items>', methods=['GET', 'POST'])
def search(page=0, items=10):
    """加入搜尋條件的play列表
    """
    conn = mysql.get_db()
    query_condition = u""
    if request.method == 'POST' and request.form['s_key'] and request.form['s_value']:
        query_condition = u" WHERE {0} LIKE '%{1}%'".format(request.form['s_key'], request.form['s_value'])
        session['s_key'] = request.form['s_key']
        session['s_value'] = request.form['s_value']
    elif 's_key' in session and 's_value' in session:
        query_condition = u" WHERE {0} LIKE '%{1}%'".format(session['s_key'], session['s_value'])

    if len(query_condition) != 0:
        sql1 = u"SELECT COUNT(*) as total FROM play" + query_condition
        with conn.cursor() as cursor:
            cursor.execute(sql1)
            row = cursor.fetchone()
            total = row[0]
        print(total)

        sort_condition = u""
        if 'sort' in request.args and 'asc' in request.args:
            sort_condition = u" ORDER BY {0} ".format(request.args.get('sort'))
            if request.args.get('asc') == '0':
                sort_condition += u" DESC"
            else:
                sort_condition += u" ASC"
        else:
            sort_condition = "ORDER BY play_id ASC"
                
        sql2 = u"SELECT play_id, t1.player_name as pitcher_name, t2.player_name as batter_name, match_id, inning, half FROM play p INNER JOIN player t1 ON t1.player_id = p.pitcher_id INNER JOIN player t2 ON t2.player_id = p.batter_id " + query_condition + sort_condition
        skip = page * items
        if skip >= total:
            skip = 0
        sql2 += u" LIMIT {0},{1}".format(skip, items)
        
        # 執行 sql2 取得資料 (多筆)
        plays = []
        with conn.cursor() as cursor:
            cursor.execute(sql2)
            plays = cursor.fetchall()
        print(plays)

        misc = items_pagebar(total, page, items)  # 計算pagebar需要之參數
        misc['s_key'] = session['s_key'] or u''
        misc['s_value'] = session['s_value'] or u''
        return render_template('play/list.html', plays=plays, misc=misc, action='search')
    else:
        return redirect(url_for('play.simple_list'))


@mod.route('/view/<play_id>')
def view(play_id):
    """顯示某筆play的頁面與細節
    """
    # 查出單筆, assign給頁面
    conn = mysql.get_db()
    sql = u"SELECT play_id, t1.player_name as pitcher_name, t2.player_name as batter_name, match_id, inning, half FROM play p INNER JOIN player t1 ON t1.player_id = p.pitcher_id INNER JOIN player t2 ON t2.player_id = p.batter_id WHERE p.play_id = %s"
    with conn.cursor() as cursor:
        cursor.execute(sql, play_id)
        play = cursor.fetchone()

    sql = u"SELECT ball.play_id, `ball_order`, `kind`, `speed`, `result` FROM play, ball WHERE ball.play_id=%s and play.play_id=ball.play_id "
    with conn.cursor() as cursor:
        cursor.execute(sql, play_id)
        balls = cursor.fetchall()
    return render_template('play/view.html', play=play, balls=balls)


@mod.route('/create', methods=['GET', 'POST'])
def create():
    """新增一筆play資料
    """
    if request.method == 'POST':
        conn = mysql.get_db()
        # 實際寫入一筆 t1.player_name as pitcher_name, t2.player_name as batter_name,
        sql = u"INSERT INTO `play` (`pitcher_id`, `batter_id`, `match_id`, `inning`, `half`) VALUES (%s, %s, %s, %s, %s)"
        print(request.form.to_dict())
        post = request.form.to_dict()
        print(post)
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (post['pitcher_id'],
                                post['batter_id'],
                                post['match_id'],
                                post['inning'],
                                post['half'])
                           )
            play_id = cursor.lastrowid
            conn.commit()
        return redirect(url_for('play.view', play_id=play_id))
    else:
        return render_template('play/create.html')


@mod.route('/update/<play_id>', methods=['GET', 'POST'])
def update(play_id):
    """修改一筆play資料
    若有post則修改後更新db
    無post則查出player並顯示修改頁
    """
    conn = mysql.get_db()
    if request.method == 'POST':
        # 依 play_id 進行 update
        sql = u"UPDATE play SET `pitcher_id`=%s, `batter_id`=%s, `match_id`=%s, `inning`=%s, `half`=%s WHERE `play_id`=%s"
        print(request.form.to_dict())
        post = request.form.to_dict()
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (post['pitcher_id'],
                                post['batter_id'],
                                post['match_id'],
                                post['inning'],
                                post['half'],                      
                                play_id)
                           )
            conn.commit()
        return redirect(url_for('play.view', play_id=play_id))
    else:
        # 查出單筆, assign給頁面進行修改
        sql = u"SELECT * FROM play WHERE play_id=%s"
        with conn.cursor() as cursor:
            cursor.execute(sql, play_id)
            play = cursor.fetchone()
        return render_template('play/update.html', play=play)


@mod.route('/delete/<play_id>', methods=['GET', 'POST'])
def delete(play_id):
    """刪除某筆play資料後,回到列表頁
    """
    conn = mysql.get_db()
    sql = u"DELETE FROM play WHERE `play_id`=%s"
    with conn.cursor() as cursor:
        conn.begin()
        cursor.execute(sql, play_id)
        conn.commit()
    return redirect(url_for('play.simple_list'))