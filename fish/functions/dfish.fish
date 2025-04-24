# Defined in - @ line 1
function dfish --description 'alias dbash=docker exec -it <container id> /bin/fish'
	docker exec -it $argv fish;
end
