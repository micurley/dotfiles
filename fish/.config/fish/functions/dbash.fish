# Defined in - @ line 1
function dbash --description 'alias dbash=docker exec -it <container id> /bin/bash'
	docker exec -it $argv /bin/bash;
end
