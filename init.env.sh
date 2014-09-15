
# Setup go env
gvm use go1.3
# Setup Python env
export WORKON_HOME=$HOME/.virtualpythonenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh
workon
# Setup Ruby env
rvm use 1.9.3 --default

