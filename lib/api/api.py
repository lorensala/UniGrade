""" from flask import Flask

app = Flask(__name__)

@app.route('/') """

def hello_word():
    print ('Hello Word')


if __name__ == "__main__":
    hello_word()

