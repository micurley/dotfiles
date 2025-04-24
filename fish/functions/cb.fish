function cb --wraps='git checkout -' --description 'alias cb=git checkout -'
  git checkout - $argv
        
end
