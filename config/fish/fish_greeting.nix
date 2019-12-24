{ bsdgames }:
''
function fish_greeting
    ${bsdgames}/bin/fortune -s
    echo
end

set -p PATH ~/bin
''
