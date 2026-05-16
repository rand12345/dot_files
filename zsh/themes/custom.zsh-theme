# Custom ZSH Theme with Hostname
# Alternative to the inline prompt in zshrc
# To use: Set ZSH_THEME="custom" in your .zshrc.local

# Username and hostname in cyan
local user_host='%{$fg[cyan]%}[%n@%m]%{$reset_color%}'

# Current directory in blue
local current_dir='%{$fg[blue]%}%~%{$reset_color%}'

# Git status
local git_info='$(git_prompt_info)'

# Prompt character (green arrow)
local prompt_char='%{$fg[green]%}➜%{$reset_color%}'

# Assemble the prompt
PROMPT="${user_host} ${current_dir} ${git_info}
${prompt_char} "

# Right prompt with time (optional)
# RPROMPT='%{$fg[yellow]%}%T%{$reset_color%}'

# Git prompt styling
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
