# app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Привіт, світ! Це простий Flask застосунок, розгорнутий на AWS EC2 за допомогою Terraform та Ansible!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
