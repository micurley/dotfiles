function ssh_connect_to_application
  set environments (string split \t --no-empty -- (aws elasticbeanstalk describe-environments --query "Environments[?ApplicationName=='$argv[1]'].EnvironmentName[?contains(@, '$argv[2]') == `true`] | sort(@)" --output text))
  echo "Environments: $environments"
  set -l i 1
  for e in $environments
    echo "$i. $e"
    set -l i (math $i + 1)
  end

  set -l selected_env (read -P "Select an Environment: [1] ")
  if not string length -q -- "$selected_env[1]"
    set selected_env 1
  end

  math "0+$selected_env" >/dev/null 2>&1 # test if $selected_env is a number
  if test $status -ne 0
    echo "Invalid input: $selected_env"
    return 1
  else if test $selected_env -gt (count $environments)
    echo "Invalid input: $selected_env"
    return 1
  else if test $selected_env -lt 1
    echo "Invalid input: $selected_env"
    return 1
  end

  set -l selected_env $environments[$selected_env]

  if not contains $selected_env $environments
    echo "Invalid environment ID: $selected_env"
    return 1
  end

  echo "Connecting to $selected_env"

  set instances (string split \t --no-empty -- (aws elasticbeanstalk describe-environment-resources --environment-name $selected_env --query "EnvironmentResources.Instances[].Id | sort(@)" --output text))
    set -l i 1
    for instance in $instances
      echo "$i. $instance"
      set -l i (math $i + 1)
    end

    set -l selected_index (read -P "Select an instance to SSH into: [1] ")
    if not string length -q -- "$selected_index[1]"
      set selected_index 1
    end

    math "0+$selected_index" >/dev/null 2>&1 # test if $selected_index is a number
    if test $status -ne 0
      echo "Invalid input: $selected_index"
      return 1
    else if test $selected_index -gt (count $instances)
      echo "Invalid input: $selected_index"
      return 1
    else if test $selected_index -lt 1
      echo "Invalid input: $selected_index"
      return 1
    end

    set -l selected_instance $instances[$selected_index]

    if not contains $selected_instance $instances
      echo "Invalid instance ID: $selected_instance"
      return 1
    end

  echo "Connecting to $selected_instance"
  set ip_address (aws ec2 describe-instances --filters Name=instance-id,Values=$selected_instance --query "Reservations[].Instances[].PrivateIpAddress" --output text)

  # Set badge to show the current session name and git branch, if any is set.
  set badge (echo -n "$selected_env\n$selected_instance\n$ip_address" | base64)
  printf "\e]1337;SetBadgeFormat=$badge\a"
  ssh -i "~/Git/aws-keys/pem_keys/us-west-2/dev-vpc-us-west-2.pem" ec2-user@$ip_address -t "tmux -CC new -A -s prism-v2"
end
