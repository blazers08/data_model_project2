# -*- coding: utf-8 -*-
from datetime import datetime
from flask import Blueprint, render_template, jsonify, redirect, url_for, request, g, session
from re import escape
from project_name.views.misc import items_pagebar


mod = Blueprint('player', __name__)


@mod.route('/')
@mod.route('/list', methods=['GET', 'POST'])
@mod.route('/list/<int:page>/<int:items>', methods=['GET', 'POST'])
def list(page=0, items=10):
    """簡單的player列表
    查出依條件查出 符合條件的資料
    可能有 LIMIT <from>,<how many>
    可能有 SORY BY <column> ASC/DESC
    然後 assign 給 html
    有一些經過標準計算取得的數值要 assign 給清單控制分頁用
    """

    sql1 = "SELECT COUNT(*) as total FROM player"
    # 先取得符合條件的 record 一共有多少筆
    total = 100

    sort_condition = ""
    if 'sort' in request.args and 'asc' in request.args:  # 檢查是否同時提供排序的目標欄位及排序方法
        sort_condition = " ORDER BY {0} ".format(request.args.get('sort'))
        if request.args.get('asc') == '0':  # 表示不要asc, 即desc
            sort_condition += " DESC"
        else:  # 表示要asc
            sort_condition += " ASC"

    sql2 = "SELECT * FROM player" + sort_condition
    skip = page * items
    if skip >= total:
        skip = 0
    sql2 += " LIMIT {0},{1}".format(skip, items)

    # 執行 sql2 取得資料 (多筆)
    players = []

    misc = items_pagebar(total, page, items)  # 計算pagebar需要之參數

    return render_template('player/list.html', players=players, misc=misc, action='list')