# app.py
from flask import Flask,send_from_directory
import os

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Привіт, світ! Це простий Flask застосунок, розгорнутий на AWS EC2 за допомогою Terraform та Ansible!'
@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'favicon.ico', mimetype='image/vnd.microsoft.icon')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
