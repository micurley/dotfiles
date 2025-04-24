# Defined via `source`
function ds --wraps=docker\ ps\ -a\"
    docker ps -a --format "table {{.Image}}\t{{.CreatedAt}}\t{{.Status}}\t{{.ID}}\t{{.Names}}\t{{.Ports}}" $argv
end
