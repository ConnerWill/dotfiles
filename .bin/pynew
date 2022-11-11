#!/bin/bash
read -p 'App name: ' varname
read -p 'GitHub ID: ' idvar
read -p 'The exact name of the GitHub Repo: ' repovar

mkdir -p .github/workflows
mkdir assets
mkdir $varname
mkdir tests

echo "name: Build, Test, Lint

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: Run Makefile build
      run: make build
  
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: actions/setup-python@v1
      with:
        python-version: '3.8'
    - name: Install Dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    - name: Run Makefile test
      run: make test
    - name: Install Linters
      run: |
        pip install pylint
        pip install bandit
    - name: Run Linters
      run: make lint" > .github/workflows/build-test.yml
echo "# __main__.py

if __name__ == \"__main__\":
    pass" > $varname/__main__.py

touch $varname/__init__.py

touch tests/__init__.py

echo "# conftest.py
import logging
import pytest


LOGGER = logging.getLogger(__name__)

@pytest.fixture(scope='function')
def example_fixture():
    LOGGER.info('Setting Up Example Fixture...')
    yield
    LOGGER.info('Tearing Down Example Fixture...')" > tests/conftest.py

echo "# context.py
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import $varname  # noqa # pylint: disable=unused-import, wrong-import-position" > tests/context.py

echo "def test_app():
    pass" > tests/test_$varname.py

echo "# Windows thumbnail cache files
Thumbs.db
Thumbs.db:encryptable
ehthumbs.db
ehthumbs_vista.db

# Dump file
*.stackdump

# Folder config file
[Dd]esktop.ini

# Recycle Bin used on file shares
\$RECYCLE.BIN/

# Windows Installer files
*.cab
*.msi
*.msix
*.msm
*.msp

# Windows shortcuts
*.lnk

#Linux
*~

# temporary files which can be created if a process still has a handle open of a deleted file
.fuse_hidden*

# KDE directory preferences
.directory

# Linux trash folder which might appear on any partition or disk
.Trash-*

# .nfs files are created when an open file is removed but is still being accessed
.nfs*

# Virtualenv
# http://iamzed.com/2009/05/07/a-primer-on-virtualenv/
.Python
[Bb]in
[Ii]nclude
[Ll]ib
[Ll]ib64
[Ll]ocal
[Ss]cripts
pyvenv.cfg
.venv
pip-selfcheck.json

#VSCode
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json
*.code-workspace

# Local History for Visual Studio Code
.history/

# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*\$py.class

# Distribution / packaging
.Python
env/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Installer logs
pip-log.txt
pip-delete-this-directory.txt

# Unit test / coverage reports
htmlcov/
.tox/
.coverage
.coverage.*
.cache
nosetests.xml
coverage.xml
*,cover
.hypothesis/

# Translations
*.mo
*.pot

# Django stuff:
*.log
local_settings.py

# IPython Notebook
.ipynb_checkpoints

# Confidential
credentials.*

config.env

# certs
*.srl
*.csr
*.key
*.pem" > .gitignore

touch configure_project.sh

echo "FROM python:3.8-slim

WORKDIR /

COPY ./requirements.txt .

RUN pip3 install -r requirements.txt

CMD [\"python3\", \"-m\" \"$varname\"]" > Dockerfile

touch Makefile

echo "[pytest]
addopts = --color=yes --cov=$varname --cov-report=xml --cov-report=term -ra
filterwarnings =
log_cli = 1
log_cli_level = INFO
log_cli_format = %(asctime)s [%(levelname)8s] %(message)s (%(filename)s:%(lineno)s)
log_cli_date_format = %Y-%m-%d %H:%M:%S" > pytest.ini

echo "# $repovar

![GitHub](https://img.shields.io/github/license/$idvar/$repovar) ![GitHub contributors](https://img.shields.io/github/contributors/$idvar/$repovar) ![code size](https://img.shields.io/github/languages/code-size/$idvar/$repovar)

## Prerequisites

Before you begin, ensure you have met the following requirements:

* Python 3.8+

## Installing $varname

If you want to use latest version, install from source. To install $varname from source, follow these steps:

## Using $varname

## Contributors

Thanks to the following people who have contributed to this project:

## Contact
If you want to contact me you can reach me at

## License
This project uses the following license:" > README.md

echo "pylint >= 2.6.0
bandit >= 1.6.2
pytest-cov >= 2.10.0
coverage >= 5.2" > requirements.txt

echo "[pylint]
persistent=yes
load-plugins=
jobs=1
unsafe-load-any-extension=no
extension-pkg-whitelist=

confidence=
disable=
    attribute-defined-outside-init,
    duplicate-code,
    fixme,
    invalid-name,
    missing-docstring,
    protected-access,
    too-few-public-methods,

output-format=text
files-output=no
reports=no
evaluation=10.0 - ((float(5 * error + warning + refactor + convention) / statement) * 10)

logging-modules=logging

notes=FIXME,XXX,TODO

min-similarity-lines=4
ignore-comments=yes
ignore-docstrings=yes
ignore-imports=no

init-import=no
dummy-variables-rgx=_\$|dummy
additional-builtins=
callbacks=cb_,_cb

max-line-length=160
ignore-long-lines=^\s*(# )?<?https?://\S+>?\$
single-line-if-stmt=no
no-space-check=trailing-comma,dict-separator
max-module-lines=2000
indent-string='    '
indent-after-paren=4
expected-line-ending-format=
bad-functions=map,filter,input
good-names=i,j,k,ex,Run,_
bad-names=foo,bar,baz,toto,tutu,tata
name-group=
include-naming-hint=no
function-rgx=[a-z_][a-z0-9_]{2,30}\$
function-name-hint=[a-z_][a-z0-9_]{2,30}\$
variable-rgx=[a-z_][a-z0-9_]{2,30}\$
variable-name-hint=[a-z_][a-z0-9_]{2,30}\$
const-rgx=(([A-Z_][A-Z0-9_]*)|(__.*__))\$
const-name-hint=(([A-Z_][A-Z0-9_]*)|(__.*__))\$
attr-rgx=[a-z_][a-z0-9_]{2,}\$
attr-name-hint=[a-z_][a-z0-9_]{2,}\$
argument-rgx=[a-z_][a-z0-9_]{2,30}\$
argument-name-hint=[a-z_][a-z0-9_]{2,30}\$
class-attribute-rgx=([A-Za-z_][A-Za-z0-9_]{2,30}|(__.*__))\$
class-attribute-name-hint=([A-Za-z_][A-Za-z0-9_]{2,30}|(__.*__))\$
inlinevar-rgx=[A-Za-z_][A-Za-z0-9_]*\$
inlinevar-name-hint=[A-Za-z_][A-Za-z0-9_]*\$
class-rgx=[A-Z_][a-zA-Z0-9]+\$
class-name-hint=[A-Z_][a-zA-Z0-9]+\$
module-rgx=(([a-z_][a-z0-9_]*)|([A-Z][a-zA-Z0-9]+))\$
module-name-hint=(([a-z_][a-z0-9_]*)|([A-Z][a-zA-Z0-9]+))\$
method-rgx=[a-z_][a-z0-9_]{2,}\$
method-name-hint=[a-z_][a-z0-9_]{2,}\$
no-docstring-rgx=__.*__
docstring-min-length=-1
property-classes=abc.abstractproperty

ignore-mixin-members=yes
ignored-modules=
ignored-classes=SQLObject, optparse.Values, thread._local, _thread._local
generated-members=REQUEST,acl_users,aq_parent
contextmanager-decorators=contextlib.contextmanager

spelling-dict=
spelling-ignore-words=
spelling-private-dict-file=
spelling-store-unknown-words=no

max-args=10
ignored-argument-names=_.*
max-locals=25
max-returns=11
max-branches=26
max-statements=100
max-parents=7
max-attributes=11
min-public-methods=2
max-public-methods=25

defining-attr-methods=__init__,__new__,setUp
valid-classmethod-first-arg=cls
valid-metaclass-classmethod-first-arg=mcs
exclude-protected=_asdict,_fields,_replace,_source,_make

deprecated-modules=regsub,TERMIOS,Bastion,rexec
import-graph=
ext-import-graph=
int-import-graph=

overgeneral-exceptions=Exception

ignore = F401,
         E712
    # Put Error/Style codes here e.g. H301

max-complexity = 10

[bandit]
targets: $varname

[coverage:run]
branch = True
omit =
    */__main__.py
    */tests/*
    */venv/*

[coverage:report]
exclude_lines =
    pragma: no cover
    if __name__ == .__main__.:

[coverage:html]
directory = reports" > setup.cfg

echo "MODULE := $varname

BLUE='\033[0;34m'
NC='\033[0m' # No Color

install-requirements:
	pip3 install -r requirements.txt

run:
	@python3 -m \$(MODULE)

test:
	@pytest

lint:
	@echo \"\n\${BLUE}Running Pylint against source and test files...\${NC}\n\"
	@pylint --rcfile=setup.cfg **/*.py
	@echo \"\n\${BLUE}Running Bandit against source files...\${NC}\n\"
	@bandit -r --ini setup.cfg

build:
	@docker build -t \${MODULE}:latest .
	@echo \"\n\${BLUE}Running the app...\${NC}\n\"
	@docker run -t \${MODULE} ls -l

clean:
	rm -rf .pytest_cache .coverage .pytest_cache coverage.xml

.PHONY: clean test

docker-clean:
	@docker system prune -f --filter \"label=name=\$(MODULE)\"" > Makefile
