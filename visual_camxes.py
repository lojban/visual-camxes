#!/usr/bin/env python

#-*- coding:utf-8 -*-

from flask import Flask, request, redirect, url_for, jsonify
from flaskext.genshi import Genshi, render_response, render_template
import camxes
import lepl

app = Flask(__name__)
genshi = Genshi(app)
genshi.extensions['html'] = 'html5'

import logging
stream_handler = logging.StreamHandler()
stream_handler.setLevel(logging.INFO)
app.logger.addHandler(stream_handler)


@app.route('/')
def index():
    text = request.args.get('text', "coi pilno mi'e camxes")
    try:
        ast = camxes.parse(text)
        grammatical = camxes.isgrammatical(text)
#    except Exception as exception:
#        assert type(exception).__name__ == 'NameError'
#        assert exception.__class__.__name__ == 'NameError'
    except lepl.FullFirstMatchException:
        return redirect(url_for('index'))
    if 'json' in request.args:
        return jsonify(html=render_template('box.html', dict(text=text, ast=ast)),
            grammatical=grammatical)
    return render_response('index.html',
        dict(ast=ast, text=text, grammatical=grammatical))


if __name__ == '__main__':
    app.run(debug=True)
