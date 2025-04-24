# Defined via `source`
function dls --wraps='docker logs --follow --since 5m' --description 'alias dls=docker logs --follow --since 5m'
    # Always put quotation marks
    if set -q argv[2]
        docker compose logs --follow --no-log-prefix --since "$argv[1]"m "$argv[2]"
    else
        echo $argv
        docker compose logs --follow --no-log-prefix "$argv"
    end
end
