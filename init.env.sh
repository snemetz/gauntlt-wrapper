
# Setup go env
gvm use go1.3
# Setup Python env
export WORKON_HOME=$HOME/.virtualpythonenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_SCRIPT=/usr/bin/virtualenvwrapper.sh
source /usr/bin/virtualenvwrapper_lazy.sh
workon gauntlt
# Setup Ruby env
rvm use 1.9.3 --default
export SSLYZE_PATH=/gauntlt/tools/sslyze-0_9-linux64/sslyze.py
export DIRB_WORDLISTS=/gauntlt/tools/dirb221/wordlists/
export PATH=$PATH:/gauntlt/tools/arachni-1.0-0.5.1/bin/

