{ git, grep, sed, fish, any-nix-shell }:
''
# Setup a wrapper around nix-shell to open fish instead of bash
${any-nix-shell}/bin/any-nix-shell fish | ${sed}/bin/sed -re 's?\<fish\>?${fish}/bin/fish?g' | source

function fish_prompt
  set last_status $status

  set color_cwd (set_color normal; set_color magenta)
  set color_cwd_root (set_color normal; set_color red)
  set color_result_bad (set_color normal; set_color -o red)
  set color_rest (set_color normal)

  set result_bad $color_result_bad!
  set result_good ' '

  if test $last_status = 0
    set result $result_good
  else
    set result $result_bad
  end

  set dir
  if test (id -u) = 0
    set dir $color_cwd_root(prompt_pwd)
  else
    set dir $color_cwd(prompt_pwd)
  end

  echo (set_color normal)$result$dir$color_rest(set_color normal)' '
end

function fish_right_prompt
  set color_jobs_stopped (set_color normal; set_color green)
  set color_jobs_running (set_color normal; set_color yellow)
  set color_vcs_unchanged (set_color normal; set_color -o yellow)
  set color_vcs_staged (set_color normal; set_color -o green)
  set color_vcs_unstaged (set_color normal; set_color -o red)
  set color_vcs_untracked (set_color normal; set_color -o green)

  set nix_shell (${any-nix-shell}/bin/nix-shell-info)
  set nix_shell " $nix_shell"
  set -e ANY_NIX_SHELL_EXIT_STATUS

  set vcs ""
  set vcs_status (${git}/bin/git status 2>/dev/null)
  if test -n "$vcs_status"
    set -l branch (echo $vcs_status[1] | ${grep}/bin/egrep 'On branch (.*)' | ${sed}/bin/sed -re 's/On branch (.*)/\1/')

    set -l branch_color $color_vcs_unchanged
    if echo "$vcs_status" | ${grep}/bin/grep 'Changes to be committed:' >/dev/null
      set branch_color $color_vcs_staged
    end
    if echo "$vcs_status" | ${grep}/bin/grep 'Changes not staged for commit:' >/dev/null
      set branch_color $color_vcs_unstaged
    end

    set -l untracked_files ""
    if echo "$vcs_status" | ${grep}/bin/grep 'Untracked files:' >/dev/null
      set untracked_files $color_vcs_untracked'*'
    end

    set vcs ' '$untracked_files$branch_color$branch
  end

  set stopped_jobs (jobs | grep stopped | wc -l)
  set running_jobs (jobs | grep running | wc -l)

  set jobs ""
  if test $stopped_jobs -gt 0
    set jobs $jobs' '$color_jobs_stopped'*'$stopped_jobs
  end
  if test $running_jobs -gt 0
    set jobs $jobs' '$color_jobs_running'&'$running_jobs
  end

  echo (set_color normal)$jobs$vcs$nix_shell(set_color normal)
end
''
