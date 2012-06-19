#!/usr/bin/env python

import time
import sys
import os
import json
from flask import Flask, Request, Response
application = app = Flask('wsgi')

@app.route('/')
def welcome():
    return 'Hello, World. Flask!'

@app.route('/env')
def env():
    return os.environ.get("VCAP_SERVICES", "{}")

if __name__ == '__main__':
    app.run(debug=True)
