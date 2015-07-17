from flask.ext.wtf import Form
from wtforms import SubmitField, TextAreaField
from wtforms.validators import Required
mes = 'This Field is Required.'


class CharCounter_form(Form):
    text = TextAreaField('Insert a text:', validators=[Required(message=mes)])

    submit = SubmitField('Count!')
