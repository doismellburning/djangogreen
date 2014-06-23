PORT=9999
WORKERS=2
COMMAND_PREAMBLE=.env/bin/gunicorn --pythonpath ./djangogreen --bind localhost:${PORT} --workers ${WORKERS}
WSGI=djangogreen.wsgi:application

.PHONY: bootstrap
bootstrap:
	virtualenv .env
	.env/bin/pip install -r requirements.txt

.PHONY: sync_serve
sync_serve:
	${COMMAND_PREAMBLE} ${WSGI}

.PHONY: async_serve
async_serve:
	${COMMAND_PREAMBLE} --worker-class gevent ${WSGI}

.PHONY: load
load:
	ab -n 10 -c 5 http://localhost:${PORT}/
