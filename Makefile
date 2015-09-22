# Copyright 2015 Alburnum Ltd. This software is licensed under
# the GNU Affero General Public License version 3 (see LICENSE).

PYTHON := python

# ---

develop: bin/python setup.py
	bin/python setup.py develop

dist: bin/python setup.py
	bin/python setup.py egg_info -r sdist

test: bin/tox
	@bin/tox

clean:
	$(RM) -r bin build dist include lib local TAGS tags
	find . -name '*.py[co]' -print0 | xargs -r0 $(RM) -r
	find . -name '__pycache__' -print0 | xargs -r0 $(RM) -r
	find . -name '*.egg' -print0 | xargs -r0 $(RM) -r
	find . -name '*.egg-info' -print0 | xargs -r0 $(RM) -r
	find . -name '*~' -print0 | xargs -r0 $(RM)
	$(RM) -r .eggs .tox

# ---

bin/tox: bin/pip
	bin/pip install --quiet --ignore-installed tox

bin/python bin/pip:
	virtualenv --python=$(PYTHON) --quiet $(CURDIR)

# ---

.PHONY: develop dist test clean