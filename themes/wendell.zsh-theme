# Based on alanpeabody

local user='%{$fg_bold[magenta]%}%n%{$reset_color%}'
local pwd='%{$fg_bold[blue]%}%~%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}x"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}o"

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"

# The return code of the last statement
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
# Prints branch name, a space, and then x or o for a dirty or clean repo
local git_info='$(git_prompt_info)'

# from holman/dotfiles/zsh/prompt.zsh
# Prints a list of unpushed commits
unpushed () {
  [ "0"$(git rev-list --left-only --count master...@{upstream} 2>/dev/null) -eq 0 ]
  # two other ways of doing this:
  #git cherry -v @{upstream} 2>/dev/null
  #git status -sb  2>/dev/null | grep -q '##.*ahead.*' 2>/dev/null
  
  # those go with the test ``#if [[ $(unpushed) == "" ]]; then` in `need_push`
}

# from holman/dotfiles/zsh/prompt.zsh
need_push () {
  if unpushed; then
    # we have no changes to push
    echo " "
  else
    # Add a yellow ✚ if we have changes to push
    echo "%{$fg_bold[yellow]%}✚%{$reset_color%}"
  fi
}

local push_status='$(need_push)'

PROMPT="${user} ${pwd}$ "
RPROMPT="${return_code} ${git_info}${push_status}"
