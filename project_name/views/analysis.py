# -*- coding: utf-8 -*-
from collections import defaultdict
from flask import Blueprint, render_template, jsonify, redirect, url_for, request, g, session
from re import escape
from project_name.views.misc import items_pagebar
from project_name.extension import mysql

mod = Blueprint('analysis', __name__)


@mod.route('/pitcher', methods=['GET', 'POST'])
def picther_analysis(page=0, items=10):
    """
    顯示 html, 查出所有 pitcher, 並加入 select 中, 後續用 ajax 取得 dashboard 的資料(json)
    """
    conn = mysql.get_db()
    sql = u"SELECT * FROM player WHERE player_position='P'"
    players = []
    with conn.cursor() as cursor:
        cursor.execute(sql)
        players = cursor.fetchall()
    print(players)
    # return render_template('analysis/pitcher.html', players=players, action='simple_list')
    return jsonify(players)


@mod.route('/pitcher_recent/<player_id>')
def pitcher_recent(player_id):
    """
    SELECT DISTINCT kind FROM `ball`
    得 4FB, CRV, SLD, 2FB, CUT, CHG
    SELECT DISTINCT result FROM `ball`
    得 f_ball, S, K, B, out, HR, 1h, BB
    查詢此 pitcher 的最近 18 局表現, 以 json 格式回傳建立圖表
    :param player_id: 目標 pitcher 的 player_id
    :return:
    """

    kind = ['4FB', 'CRV', 'SLD', '2FB', 'CUT', 'CHG']

    conn = mysql.get_db()

    temp_create = u"CREATE TEMPORARY TABLE `valid_inning`(`match_id` INT, `inning` INT, `m_date` DATE)"
    with conn.cursor() as cursor:
        cursor.execute(temp_create)

    # INSERT INTO TEMP TABLE
    match_ids = set()
    sql = u"""INSERT INTO `valid_inning`(`match_id`,`inning`, `m_date`) SELECT P.match_id, P.inning, M.m_date
    FROM `play` AS P
    JOIN `match` AS M ON P.match_id = M.match_id
    WHERE P.pitcher_id={0}
    GROUP BY match_id, inning
    ORDER BY m_date DESC, inning DESC
    LIMIT 18""".format(player_id)
    with conn.cursor() as cursor:
        cursor.execute(sql)

    # 從 TEMP TABLE開始小計
    # 後續手動 join 小計表 (再產生 temp table也怪怪的)
    result_map = {}
    sql1 = u"""SELECT P.match_id, P.inning, kind, count(*) as total FROM `valid_inning` AS V
    JOIN `play` AS P ON P.match_id=V.match_id AND P.inning=V.inning
    JOIN `ball` AS B ON P.play_id=B.play_id
    WHERE P.pitcher_id={1}
    GROUP BY P.match_id, P.inning, kind
    ORDER BY match_id DESC, inning DESC
    """.format(u",".join(match_ids), player_id)
    print(sql1)
    with conn.cursor() as cursor:
        cursor.execute(sql1)
        for row in cursor:
            if row[0] not in result_map:
                result_map[row[0]] = {}
            if row[1] not in result_map[row[0]]:
                result_map[row[0]][row[1]] = [0]*6
            result_map[row[0]][row[1]][kind.index(row[2])] = row[3]
    print(result_map)
    # return jsonify(result_map)
    data = [['match-inning', '4FB', 'CRV', 'SLD', '2FB', 'CUT', 'CHG', {'role': 'annotation'}]]
    for match_id in result_map:
        for inning in result_map[match_id]:
            row = ['match:{0}-inning:{1}'.format(match_id, inning)] + result_map[match_id][inning] + ['']
            data.append(row)

    return jsonify(data)
