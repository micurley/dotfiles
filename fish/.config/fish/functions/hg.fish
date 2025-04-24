# Defined in - @ line 1
function hg --description 'alias hg=history |grep'
	history |grep $argv;
end
