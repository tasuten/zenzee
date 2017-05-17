setopt prompt_subst

PROMPT_NORMAL='❯'
PROMPT_ROOT='❯❯❯❯'

GREEN="%{\e[38;5;2m%}"
RED="%{\e[38;5;1m%}"
DARKGRAY="%{\e[38;5;8m%}"
RESET="%{\e[0m%}"

function __prompt_status_code () {
  echo -n "%(0?.$GREEN.$RED)"
}

function __prompt_user () {
  echo -n "%(!.$PROMPT_ROOT.$PROMPT_NORMAL)"
}

function __prompt_main () {
  echo -n "$(__prompt_status_code)$(__prompt_user)$RESET"
}


function __prompt_path () {

}

function __prompt_git () {

}

function __prompt_right () {
  echo -n "$(__prompt_path)$(__prompt_git)$RESET"
}

PROMPT='$(__prompt_main) ' # left
RPROMPT='$(__prompt_right)' # right


# vim:set filetype=zsh:

