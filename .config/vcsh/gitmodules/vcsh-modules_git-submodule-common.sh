# args: [OWN_OPTIONS] [--] [GIT_ARGUMENTS]
#  OWN_OPTIONS:
#   --capture-stdout : output variable: g_gitcmd_out_stdout
f_vcsh_gitmodules_run_git()
{
    unset \
        g_gitcmd_out_stdout \
        \
        l_vcsh_gitmodules_run_git_captstdout_flag \
        # end
    l_vcsh_gitmodules_run_git_rc=0

    if [ ${l_vcsh_gitmodules_run_git_rc} -eq 0 ] ; then
        while [ $# -gt 0 ]
        do
            l_vcsh_gitmodules_run_git_arg="$1"
            case "${l_vcsh_gitmodules_run_git_arg}" in
                --capture-stdout )
                    l_vcsh_gitmodules_run_git_captstdout_flag=x ;;
                -- )
                    shift
                    break ;;
                * )
                    break ;;
            esac
            shift
        done
    fi

    if [ ${l_vcsh_gitmodules_run_git_rc} -eq 0 ] ; then
        # for now, we run 'git', and not support any variable-based overrides.
        l_vcsh_gitmodules_run_git_gitcmd='git'
    fi

    if [ ${l_vcsh_gitmodules_run_git_rc} -eq 0 ] ; then
        if [ -n "${l_vcsh_gitmodules_run_git_captstdout_flag}" ] ; then
            g_gitcmd_out_stdout=`"${l_vcsh_gitmodules_run_git_gitcmd}" "$@"` \
                || {
                    l_vcsh_gitmodules_run_git_rc=$?
                    unset g_gitcmd_out_stdout
                }
        else
            # no redirections: caller will do that, if it wants.
            "${l_vcsh_gitmodules_run_git_gitcmd}" "$@" \
                || l_vcsh_gitmodules_run_git_rc=$?
        fi
    fi

    unset \
        l_vcsh_gitmodules_run_git_arg \
        l_vcsh_gitmodules_run_git_captstdout_flag \
        l_vcsh_gitmodules_run_git_gitcmd \
        # end
    return ${l_vcsh_gitmodules_run_git_rc}
}

# vim600: set filetype=sh fileformat=unix softtabstop=4:
# vim: set expandtab smarttab:
# vi: set autoindent shiftwidth=4:
