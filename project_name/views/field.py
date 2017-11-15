# -*- coding: utf-8 -*-
from datetime import datetime
from flask import Blueprint, render_template, jsonify, redirect, url_for, request, g, session
from re import escape
from project_name.views.misc import items_pagebar
from project_name.extension import mysql


mod = Blueprint('field', __name__)


@mod.route('/')
@mod.route('/simple_list', methods=['GET', 'POST'])
@mod.route('/simple_list/<int:page>/<int:items>', methods=['GET', 'POST'])
def simple_list(page=0, items=10):
    """簡單的field列表
    查出依條件查出 符合條件的資料
    可能有 LIMIT <from>,<how many>
    可能有 SORY BY <column> ASC/DESC
    然後 assign 給 html
    有一些經過標準計算取得的數值要 assign 給清單控制分頁用
    """
    conn = mysql.get_db()

    # 先取得符合條件的 record 一共有多少筆
    sql1 = u"SELECT COUNT(*) as total FROM field"
    with conn.cursor() as cursor:
        cursor.execute(sql1)
        row = cursor.fetchone()
        total = row[0]
    print(total)

    sort_condition = u""
    if 'sort' in request.args and 'asc' in request.args:  # 檢查是否同時提供排序的目標欄位及排序方法
        sort_condition = u" ORDER BY {0} ".format(request.args.get('sort'))
        if request.args.get('asc') == '0':  # 表示不要asc, 即desc
            sort_condition += u" DESC"
        else:  # 表示要asc
            sort_condition += u" ASC"

    sql2 = u"SELECT * FROM field" + sort_condition
    skip = page * items
    if skip >= total:
        skip = 0
    sql2 += u" LIMIT {0},{1}".format(skip, items)
    print(sql2)

    # 執行 sql2 取得資料 (多筆)
    fields = []
    with conn.cursor() as cursor:
        cursor.execute(sql2)
        fields = cursor.fetchall()
    print(fields)

    misc = items_pagebar(total, page, items)  # 計算pagebar需要之參數

    return render_template('field/list.html', fields=fields, misc=misc, action='simple_list')


@mod.route('/search', methods=['GET', 'POST'])
@mod.route('/search/<int:page>/<int:items>', methods=['GET', 'POST'])
def search(page=0, items=10):
    """加入搜尋條件的field列表
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
        sql1 = u"SELECT COUNT(*) as total FROM field" + query_condition
        with conn.cursor() as cursor:
            cursor.execute(sql1)
            row = cursor.fetchone()
            total = row[0]
        print(total)

        sort_condition = u""
        if 'sort' in request.args and 'asc' in request.args:  # 檢查是否同時提供排序的目標欄位及排序方法
            sort_condition = u" ORDER BY {0} ".format(request.args.get('sort'))
            if request.args.get('asc') == '0':  # 表示不要asc, 即desc
                sort_condition += u" DESC"
            else:  # 表示要asc
                sort_condition += u" ASC"

        sql2 = u"SELECT * FROM field" + query_condition + sort_condition
        skip = page * items
        if skip >= total:
            skip = 0
        sql2 += u" LIMIT {0},{1}".format(skip, items)

        # 執行 sql2 取得資料 (多筆)
        fields = []
        with conn.cursor() as cursor:
            cursor.execute(sql2)
            fields = cursor.fetchall()
        print(fields)

        misc = items_pagebar(total, page, items)  # 計算pagebar需要之參數
        misc['s_key'] = session['s_key'] or u''
        misc['s_value'] = session['s_value'] or u''
        return render_template('field/list.html', fields=fields, misc=misc, action='search')
    else:
        return redirect(url_for('field.simple_list'))


@mod.route('/view/<field_id>')
def view(field_id):
    """顯示某筆field的頁面與細節
    """
    # 查出單筆, assign給頁面
    conn = mysql.get_db()
    sql = u"SELECT * FROM field WHERE field_id=%s"
    with conn.cursor() as cursor:
        cursor.execute(sql, field_id)
        field = cursor.fetchone()
    return render_template('field/view.html', field=field)


@mod.route('/create', methods=['GET', 'POST'])
def create():
    """新增一筆field資料
    """
    if request.method == 'POST':
        conn = mysql.get_db()
        # 實際寫入一筆
        sql = u"INSERT INTO `field` (`name`, `address`, `status`) VALUES (%s, %s, %s)"
        print(request.form.to_dict())
        post = request.form.to_dict()
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (post['name'],
                                 post['address'],
                                 status)
                           )
            field_id = cursor.lastrowid
            conn.commit()
        return redirect(url_for('field.view', field_id=field_id))
    else:
        return render_template('field/create.html')


@mod.route('/update/<field_id>', methods=['GET', 'POST'])
def update(field_id):
    """修改一筆field資料
    若有post則修改後更新db
    無post則查出field並顯示修改頁
    """
    conn = mysql.get_db()
    if request.method == 'POST':
        # 依 field_id 進行 update
        sql = u"UPDATE field SET `name`=%s, `address`=%s, `modified`=%s, `status`=%s WHERE `field_id`=%s"
        print(request.form.to_dict())
        post = request.form.to_dict()
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (post['name'],
                                 post['address'],
                                 datetime.now(),
                                 status,
                                 field_id)
                           )
            conn.commit()
        return redirect(url_for('field.view', field_id=field_id))
    else:
        # 查出單筆, assign給頁面進行修改
        sql = u"SELECT * FROM field WHERE field_id=%s"
        with conn.cursor() as cursor:
            cursor.execute(sql, field_id)
            field = cursor.fetchone()
        return render_template('field/update.html', field=field)


@mod.route('/delete/<field_id>', methods=['GET', 'POST'])
def delete(field_id):
    """刪除某筆field資料後,回到列表頁,或著只是將status改為False
    """
    conn = mysql.get_db()
    sql = u"DELETE FROM field WHERE `field_id`=%s"
    with conn.cursor() as cursor:
        conn.begin()
        cursor.execute(sql, field_id)
        conn.commit()
    return redirect(url_for('field.simple_list'))