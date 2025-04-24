# Defined in - @ line 1
function cleanDocker --description alias\ cleanDocker=docker\ volume\ rm\ \(docker\ volume\ ls\ -qf\ dangling=true\)\;docker\ rmi\ \(docker\ images\ --filter\ \'dangling=true\'\ -q\)\;
	docker rm (docker stop (docker ps -qa)) 2>/dev/null;
	docker volume rm (docker volume ls -qf dangling=true) 2>/dev/null;
	docker rmi (docker images --filter 'dangling=true' -q) 2>/dev/null; 
end
