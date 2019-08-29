from flask import Flask
app = Flask(__name__)
from werkzeug import serving
import time
import uuid

@app.route("/token", methods=["GET"])
def get_token():
    return str(uuid.uuid4())

time.sleep(30)
serving.run_simple("0.0.0.0", 5000, app)
