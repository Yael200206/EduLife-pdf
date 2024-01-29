from flask import session, render_template, redirect, url_for
from functools import wraps


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        user = dict(session).get('profile', None)
        if user:
            #print("---------usuario encontrado")
            return f(*args, **kwargs)
        #print("----------usuario no encontrado, rediriguendo a login")
        return redirect(url_for("carga"))
    return decorated_function