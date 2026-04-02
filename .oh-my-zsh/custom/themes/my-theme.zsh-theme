# Tokyo Night Bira - based on bira theme with Tokyo Night color palette

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# Tokyo Night colors via 256-color escapes
local tn_blue="%{$FG[075]%}"       # #7aa2f7 - accent blue
local tn_purple="%{$FG[141]%}"     # #bb9af7 - purple
local tn_cyan="%{$FG[117]%}"       # #7dcfff - cyan
local tn_green="%{$FG[149]%}"      # #9ece6a - green
local tn_orange="%{$FG[209]%}"     # #ff9e64 - orange
local tn_red="%{$FG[210]%}"        # #ff9e9e - warn red
local tn_muted="%{$FG[060]%}"      # #565f89 - muted fg

local user_host="%B${tn_purple}%n${tn_muted}@${tn_blue}%m%{$reset_color%} "
local user_symbol='%(!.#.$)'
local current_dir="%B${tn_cyan}%~ %{$reset_color%}"
local conda_prompt='$(conda_prompt_info)'

# Detailed git status function
function tn_git_prompt() {
  local ref
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null) || return 0

  local git_status=""
  local status_output
  status_output=$(git status --porcelain --no-untracked-files 2>/dev/null)

  # Staged changes (green ✚)
  if echo "$status_output" | grep -qE '^[MADRC]'; then
    git_status+=" ${tn_green}✚%{$reset_color%}"
  fi

  # Unstaged modifications (orange ✱)
  if echo "$status_output" | grep -qE '^.[MD]'; then
    git_status+=" ${tn_orange}✱%{$reset_color%}"
  fi



  # Ahead / behind remote
  local ahead behind
  ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
  behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)

  if [[ "$ahead" -gt 0 && "$behind" -gt 0 ]]; then
    git_status+=" ${tn_orange}⇅%{$reset_color%}"
  elif [[ "$ahead" -gt 0 ]]; then
    git_status+=" ${tn_cyan}↑${ahead}%{$reset_color%}"
  elif [[ "$behind" -gt 0 ]]; then
    git_status+=" ${tn_red}↓${behind}%{$reset_color%}"
  fi

  # Clean working tree (green ✓)
  if [[ -z "$status_output" && "$ahead" -le 0 && "$behind" -le 0 ]]; then
    git_status=" ${tn_green}✓%{$reset_color%}"
  fi

  echo "${tn_purple}‹${ref}${git_status}${tn_purple}› %{$reset_color%}"
}

local vcs_branch='$(tn_git_prompt)'
local rvm_ruby='$(ruby_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
    local kube_prompt='$(kube_ps1)'
else
    local kube_prompt=''
fi

ZSH_THEME_RVM_PROMPT_OPTIONS="i v g"

PROMPT="╭─${conda_prompt}${user_host}${current_dir}${rvm_ruby}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"