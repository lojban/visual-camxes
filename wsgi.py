from werkzeug.testapp import test_app
from werkzeug.wsgi import DispatcherMiddleware

from visual_camxes import app as camxes

app = DispatcherMiddleware(test_app, {
    '/camxes': camxes,
})
