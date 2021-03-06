#!/usr/bin/make
.PHONY: buildout cleanall test instance

bin/pip:
	if [ -f /usr/bin/virtualenv-2.7 ] ; then virtualenv-2.7 .;else virtualenv -p python2.7 .;fi
	touch $@

bin/buildout: bin/pip
	./bin/pip install -r requirements.txt
	touch $@

buildout.cfg:
	ln -s dev.cfg buildout.cfg
	touch $@

buildout: bin/buildout buildout.cfg
	./bin/buildout -t 7

test: buildout
	./bin/test

run: buildout
	./bin/instance fg

docker-build:
	docker-compose build --no-cache

cleanall:
	rm -rf bin develop-eggs downloads include lib parts .installed.cfg .mr.developer.cfg bootstrap.py parts/omelette
