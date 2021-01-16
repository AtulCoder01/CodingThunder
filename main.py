# import Flask class from flask module
from flask import Flask, render_template, request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
import json
from flask_mail import Mail
from datetime import datetime
import os
from werkzeug.utils import secure_filename
import math
# $ pip3 install PyMySQL
import pymysql
pymysql.install_as_MySQLdb()

# local_server = True
with open("config.json","r") as c:
    params = json.load(c)["params"]

local_server = params['local_server']
# define app
app = Flask(__name__)
# app.secret_key = 'the random string'
app.secret_key = '\xea\xbf-\xef\xd9V/\xf5\xadOt\xe2\xcc\xfb\xe22R\x8e/O\x87T7T'

app.config['UPLOAD_FOLDER'] = params['upload_location']
# for sending mail
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)

# app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/codingthunder'
if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    phone_num = db.Column(db.String(13), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),  nullable=True)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    tag_line = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12),  nullable=True)
    img_file = db.Column(db.String(20),  nullable=True)

# when a user go to / end point then run hello() function.
@app.route("/")
def home():
    # flash('Subscribe Now', "success")
    # flash('Subcribe kr lo harry bhai ko', "danger")
    posts = Posts.query.filter_by().all()

    last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    # [0:params['no_of_posts']]
    posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+int(params['no_of_posts'])]
    # Pagination Logic
    # First
    if page == 1:
        prev = '#'
        next = "/?page="+ str(page+1)
    elif page == last:
        prev = "/?page=" + str(page - 1)
        next = '#'
    else:
        prev = "/?page=" + str(page - 1)
        next = "/?page=" + str(page + 1)
    # First
    # prev = #
    # last = page+1
    # Middle
    # prev = page-1
    # next = page+1
    # Last
    # prev = page-1
    # next = #

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)

@app.route("/about")
def about():
    return render_template('about.html', params=params)

@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    if request.method == 'POST':
        '''Add entry to the database'''
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        # print(name, email, phone, message)
        date = datetime.now()
        entry = Contacts(name=name, email=email, phone_num=phone, msg=message, date=date)
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New Message from ' + name,
                          sender=email,
                          recipients=[params["gmail-user"]],
                          body = message + "\n" + phone
                          )
        flash("Thanks for submitting your details. We will get back to you soon", "success")
    return render_template('contact.html', params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()    # first() - if two same slug exits then fetch only one

    return render_template('post.html', params=params, post=post)\

@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        userpass = request.form.get('pass')
        if username == params['admin_user'] and userpass == params['admin_password']:
            # set the session variable
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
        else:
            return render_template('login.html', params=params)
    else:
        return render_template('login.html', params=params)

@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno == '0':
                post = Posts(title=box_title, slug=slug, content=content, tag_line=tline, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()
                flash("Your Post Added Successfully","success")
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.tag_line = tline
                post.content = content
                post.img_file = img_file
                post.date = date
                db.session.commit()
                flash(f"Your Post (SNo={sno}) Updated Successfully", "success")
                return redirect('/edit/' + sno)

        post = Posts.query.filter_by(sno=sno).first()
        return render_template('edit.html', params=params, post=post, sno=sno)

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    # First check user logged in or npt
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            flash("File Uplopaded Successfully","success")
            return redirect("/dashboard")

@app.route("/logout", methods=['GET', 'POST'])
def logout():
    session.pop('user')
    flash("Logged Out Successfully", "success")
    return redirect('/dashboard')

@app.route("/delete/<string:sno>", methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        flash(f"Your Post (SNo={sno}) Deleted Successfully", "success")
    return redirect('/dashboard')

# for run server
app.run(debug=True)
# debug=True  - auto reload if you do any changes