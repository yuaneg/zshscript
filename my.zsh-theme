# 自定义 Zsh 提示符
# 仅在 Git 目录中显示版本号和提交信息
update_prompt() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        PROMPT="%{$fg[cyan]%}版本号:%{$reset_color%} $(get_version)
%{$fg[cyan]%}提交信息:%{$reset_color%} $(get_commit_message)
%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
    else
    PROMPT="%(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%}"
    PROMPT+=' $(git_prompt_info)'
    fi
}

# 每次提示符显示时执行这个函数
precmd_functions+=(update_prompt)


# Git 提示信息
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# 获取当前版本号
get_version() {
    version=$(git rev-parse HEAD 2>/dev/null)
    echo "$version"
}

# 获取最新的 commit message
get_commit_message() {
    commit_msg=$(git log -1 --pretty=%B 2>/dev/null)
    echo "$commit_msg"
}
