# -*- coding: utf-8 -*-
from datetime import datetime
from flask import Blueprint, render_template, jsonify, redirect, url_for, request, g, session
from re import escape
from project_name.views.misc import items_pagebar
from project_name.extension import mysql

mod = Blueprint('ball', __name__)


@mod.route('/create/<play_id>', methods=['GET', 'POST'])
def create(play_id):
    """新增一筆ball資料
    """
    if request.method == 'POST':
        conn = mysql.get_db()
        sql = u"INSERT INTO `ball` (`play_id`, `ball_order`, `kind`, `speed`, `result`) VALUES (%s, %s, %s, %s, %s)"
        print(request.form.to_dict())
        post = request.form.to_dict()
        print(post)
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (play_id,
            					post['ball_order'],
                                post['kind'],
                                post['speed'],
                                post['result'])
                           )
            conn.commit()
        return redirect(url_for('play.view', play_id=play_id))
    else:
        return render_template('ball/create.html', play_id=play_id)


@mod.route('/update/<play_id>/<ball_order>', methods=['GET', 'POST'])
def update(play_id, ball_order):
    """修改一筆ball資料
    若有post則修改後更新db
    無post則查出ball並顯示修改頁
    """
    conn = mysql.get_db()
    if request.method == 'POST':
        # 依 play_id 進行 update
        sql = u"UPDATE ball SET `kind`=%s, `speed`=%s, `result`=%s WHERE `play_id`=%s and `ball_order`=%s"
        print(request.form.to_dict())
        post = request.form.to_dict()
        status = 'status' in request.form
        with conn.cursor() as cursor:
            conn.begin()
            cursor.execute(sql, (post['kind'],
                                post['speed'],
                                post['result'],                      
                                play_id,
                                ball_order)
                           )
            conn.commit()
        return redirect(url_for('play.view', play_id=play_id, ball_order=ball_order))
    else:
        # 查出單筆, assign給頁面進行修改
        sql = u"SELECT * FROM ball WHERE `play_id`={0} and `ball_order`={1}".format(play_id, ball_order)
        with conn.cursor() as cursor:
            cursor.execute(sql)
            ball = cursor.fetchone()
        return render_template('ball/update.html', ball=ball)


@mod.route('/delete/<play_id>/<ball_order>', methods=['GET', 'POST'])
def delete(play_id, ball_order):
    """刪除某筆play資料後,回到列表頁
    """
    conn = mysql.get_db()
    sql = u"DELETE FROM ball WHERE `play_id`={0} and `ball_order`={1}".format(play_id, ball_order)
    with conn.cursor() as cursor:
        conn.begin()
        cursor.execute(sql)
        conn.commit()
    return redirect(url_for('play.simple_list'))