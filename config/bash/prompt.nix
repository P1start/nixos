{ git, grep, sed }:
''
JOBS_STOPPED="$1"
JOBS_RUNNING="$2"

COLOR_JOBS_STOPPED="\[\e[0;32m\]"
COLOR_JOBS_RUNNING="\[\e[0;33m\]"
COLOR_DIR="\[\e[0;35m\]"
COLOR_DIR_ROOT="\[\e[0;31m\]"
COLOR_VCS_UNCHANGED="\[\e[0;1;33m\]"
COLOR_VCS_STAGED="\[\e[0;1;32m\]"
COLOR_VCS_UNSTAGED="\[\e[0;1;31m\]"
COLOR_VCS_UNTRACKED="\[\e[0;1;32m\]"
COLOR_RESULT_BAD="\[\e[0;1;31m\]"
COLOR_REST="\[\e[0m\]"

RESULT_BAD="$COLOR_RESULT_BAD!"
RESULT_GOOD=" "

VCS=
VCS_STATUS="$(${git}/bin/git status 2>/dev/null)"
if [ -n "$VCS_STATUS" ]; then
  BRANCH="$(echo "$VCS_STATUS" | ${grep}/bin/egrep 'On branch (.*)' | ${sed}/bin/sed -re 's/On branch (.*)/\1/')"

  BRANCH_COLOR="$COLOR_VCS_UNCHANGED"
  if echo "$VCS_STATUS" | ${grep}/bin/grep 'Changes to be committed:' >/dev/null; then
    BRANCH_COLOR="$COLOR_VCS_STAGED"
  fi
  if echo "$VCS_STATUS" | ${grep}/bin/grep 'Changes not staged for commit:' >/dev/null; then
    BRANCH_COLOR="$COLOR_VCS_UNSTAGED"
  fi

  UNTRACKED_FILES=
  if echo "$VCS_STATUS" | ${grep}/bin/grep 'Untracked files:' >/dev/null; then
    UNTRACKED_FILES="$COLOR_VCS_UNTRACKED*"
  fi

  VCS="$BRANCH_COLOR$BRANCH$UNTRACKED_FILES "
fi

JOBS=
if [ "$JOBS_STOPPED" -gt 0 ]; then
  JOBS="$COLOR_JOBS_STOPPED*$JOBS_STOPPED "
fi
if [ "$JOBS_RUNNING" -gt 0 ]; then
  JOBS+="$COLOR_JOBS_RUNNING&$JOBS_RUNNING "
fi

if [ "$UID" = 0 ]; then
    DIR="$COLOR_DIR_ROOT\w"
else
    DIR="$COLOR_DIR\w"
fi

echo "\`if [ \$? != 0 ]; then echo \"$RESULT_BAD\"; else echo \"$RESULT_GOOD\"; fi\`$RESULT$JOBS$VCS$DIR$COLOR_REST "
''
