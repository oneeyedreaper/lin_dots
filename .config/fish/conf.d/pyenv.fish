set -x PYENV_SHELL fish
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PYENV_ROOT/shims $PATH

# status is-login; and pyenv init --path | source
# pyenv init - | source

# pipenv
set -x PATH $HOME/.local/bin $PATH
