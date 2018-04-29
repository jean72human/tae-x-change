from flask import request, url_for
from flask_api import FlaskAPI, status, exceptions
from flask.ext.api.decorators import set_renderers
from flask.ext.api.renderers import JSONRenderer
from flask import Blueprint

from dbConnector import connect, login, register



theme = Blueprint(
    'flask-api', __name__,
    url_prefix='/flask-api',
    template_folder='templates', static_folder='static'
)

app = FlaskAPI(__name__)
app.blueprints['flask-api'] = theme



@app.route("/login", methods=['GET','POST',])
def login_route():
    conn = connect()
    if request.method == 'POST':
        answer = login(conn, request.data.get('user_email'), request.data.get('password'))
        conn.close()
        return answer
    conn.close()
    return {'message':'post your credentials'}

@app.route("/register", methods=['POST','GET'])
def register_route():
    conn = connect()
    if request.method == 'POST':
        answer = register(conn, request.data.get('email'), request.data.get('password'), request.data.get('phone_number'))
        conn.close
        return answer
    return {'message':'Enter the info to register'}

@app.route("/",methods=['GET'])
def home():
    return {
        '127.0.0.1:5000/login':'login',
        '127.0.0.1:5000/register':'register'
    }

if __name__ == "__main__":
    app.run(debug=True)
        