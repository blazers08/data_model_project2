# -*- coding: utf-8 -*-
import re
from hashlib import sha1
from flask import Flask, session, g, render_template, request, redirect, url_for, flash, abort
from flask_openid import OpenID
from flask_debugtoolbar import DebugToolbarExtension
from jinja2 import evalcontextfilter, Markup, escape
from project_name.extension import mysql


app = Flask(__name__)
app.config.from_object('websiteconfig')  # 從 websiteconfig.py 讀取設定
app.config['TEMPLATES_AUTO_RELOAD'] = True  # 每次 request 刷新 html
oid = OpenID(app, '/tmp/flask_openid')  # session與登入檢查用
mysql.init_app(app)
DebugToolbarExtension(app)
_paragraph_re = re.compile(r'(?:\r\n|\r|\n){2,}')  # for nl2br


@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404


@app.before_request
def load_current_user():
    """
    除了 特定(login) page 或 靜態檔案 以外的操作都須登入
    set current user to flask.g
    :return: None
    """
    # print(request.path)
    if request.path[:8] == '/static/' or request.path == url_for('login'):
        # 靜態檔案存取, need not check if login or not.
        pass
    elif 'user_id' not in session:  # 使用者沒有登入的情況, 導回登入頁
        # need to login now, redirect to login page
        return redirect(url_for('login'))
    else:
        # already login, get user by session['user_id']
        g.user = session['user_id']
        g.user_name = session['user_name']


@app.route('/')
def show_entries():
    """導入頁
    :return: None
    """
    if 'user_id' in session:
        return render_template('dashboard.html')
    else:
        flash('not a user')
        return redirect(url_for('login'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    """登入執行, 或顯示登入頁
    """
    if request.method == 'POST':
        print(request.form)
        email = request.form['email']
        sha1_pwd = sha1(request.form['password']).hexdigest()
        sql = "SELECT * FROM user WHERE email=%s AND password=%s"
        conn = mysql.get_db()
        with conn.cursor() as cursor:
            cursor.execute(sql, (email, sha1_pwd))
            row = cursor.fetchone()
        # 用 email 查 database, 取得該使用者的 id 與 password (如果有作登入系統的話)
        if row[3] != sha1_pwd:
            flash('password does not match!')
            return redirect(url_for('login'))
        session['user_id'] = str(row[0])  # set member id to session, objectId is not json serializable
        session['user_name'] = row[2]  # user_name from DB
        flash('You have logged in.')
        return redirect(url_for('show_entries'))
    else:
        return render_template('login.html')


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('user_name', None)
    flash('You have logged out.')
    return render_template('login.html')


@app.template_filter('strftime')
def _jinja2_filter_datetime(date, fmt=None):
    if fmt:
        return date.strftime(fmt)
    else:
        return date.strftime('%Y-%m-%d %H:%M:%S')


@app.template_filter()
@evalcontextfilter
def nl2br(eval_ctx, value):
    result = u'\n\n'.join(u'<p>%s</p>' % p.replace('\n', '<br>\n') \
        for p in _paragraph_re.split(escape(value)))
    if eval_ctx.autoescape:
        result = Markup(result)
    return result


from project_name.views import player, team, game, field
app.register_blueprint(player.mod, url_prefix='/player')
app.register_blueprint(team.mod, url_prefix='/team')
app.register_blueprint(game.mod, url_prefix='/game')
app.register_blueprint(field.mod, url_prefix='/field')


if __name__ == '__main__':
  app.run()
