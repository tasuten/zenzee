setopt prompt_subst

PROMPT_NORMAL='❯'
PROMPT_ROOT='⌗'

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


function __git_inside_repo () {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]];then
    return 0
  else
    return 1
  fi
}


function __prompt_path () {
  print -P "$DARKGRAY%~$RESET"
}

function __prompt_git () {
  if ! __git_inside_repo; then
    return
  fi

  local branch
  branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"

  local st bst
  st="$(git status --porcelain --branch 2> /dev/null)"
  bst="$(echo "$st" | head -n1 )"


  local remote_status
  if echo "$bst" | grep -v '^## .*\.\.\.origin' >/dev/null 2>&1; then
    # local only branch
    remote_status=' ⨱'
  elif echo "$bst" | grep '^## .*diverged' >/dev/null 2>&1; then
    remote_status=' ⑂'
  elif echo "$bst" | grep '^## .*behind' >/dev/null 2>&1; then
    remote_status=' ⇣'
  elif echo "$bst" | grep '^## .*ahead' >/dev/null 2>&1; then
    remote_status=' ⇡'
  else
    remote_status=''
  fi

  local branch_color # is_dirty?
  if echo "$st" | grep -v '^##' >/dev/null 2>&1; then
    branch_color=$RED
  else
    branch_color=$GREEN
  fi

  echo -n " $branch_color$branch$RESET$remote_status"
}

function precmd () {
  print -P "\n$(__prompt_path)$(__prompt_git)$RESET"
}

PROMPT='$(__prompt_main) ' # left


# vim:set filetype=zsh:

