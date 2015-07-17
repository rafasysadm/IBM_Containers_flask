from flask import Flask, render_template, flash

from forms_test import CharCounter_form

from flask.ext.bootstrap import Bootstrap

from os import getenv, urandom


app = Flask(__name__)

app.secret_key = urandom(240)

#port = int(getenv('VCAP_APP_PORT', 8080))

bootstrap = Bootstrap(app)

app.debug = True

def randnumber():
    n = randint(0, 3)
    return n


@app.route('/', methods=['GET', 'POST'])

def index():
    form = CharCounter_form()
    if form.validate_on_submit():
        charcount = len(str(form.text.data).replace(" ", ""))
        form.text.data = ''
        flash("Characters count: %s" % charcount, 'success')
        return render_template('index.html', form=form)
        
    return render_template('index.html', form=form)   


if __name__ == '__main__':
    #app.run('0.0.0.0', debug=False, port=8080, ssl_context='adhoc')
    app.run(host='0.0.0.0', port=9080)