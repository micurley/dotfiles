function connect_to_task
    set region us-east-1
    if test (count $argv) -gt 0
        set env $argv[1] # The first argument is the environment (e.g., "dev")
    else
        set env dev # Use default value
    end

    if test (count $argv) -gt 1
        set cmd $argv[2] # The second argument is the command  to use (e.g., "/bin/bash")
    else
        set cmd /bin/bash # Use default value
    end

    # Define a dictionary-like key-value pair structure for environment and cluster
    set -g envs dev development dev2 development prod production stage stage
    set -g clusters dev dev-ecs-cluster dev2 conduit-dev prod production-ecs-cluster stage staging-ecs-cluster


    # Search for the environment in the clusters dictionary
    for i in (seq 1 2 (count $clusters))
        set -l c_key $clusters[$i]
        set -l c_value $clusters[(math $i + 1)]
        set -l e_value $envs[(math $i + 1)]

        # Also add an entry for the first letter of the environment
        set -l first_letter (echo $c_key | string sub -l 1)
        set -g clusters $clusters $first_letter $c_value
        set -g envs $envs $first_letter $e_value
    end

    # Search for the environment in the clusters dictionary
    for i in (seq 1 2 (count $clusters))
        set -l j (math $i + 1)
        if test $clusters[$i] = $env
            set cluster $clusters[$j]
        end
        if test $envs[$i] = $env
            set profile $envs[$j]
        end
    end

    # exit if we didn't find it
    if test -z $cluster
        echo "Environment not found"
        return
    end

    set services (aws ecs list-services --profile "$profile" --region "$region" --cluster "$cluster" --query "serviceArns[]" | jq -r 'sort[]')
    echo "ECS Services: "
    set -l i 1
    for s in $services
        # Extract the service name from the ARN (everything after the last "/")
        set service_name (echo $s | string split "/" | tail -n1)

        echo "$i. $service_name in $region"
        set -l i (math $i + 1)
    end

    set -l selected_task (read -P "Select a Service: ")
    if not string length -q -- "$selected_task[1]"
        set selected_task 1
    end

    math "0+$selected_task" >/dev/null 2>&1 # test if $selected_task is a number
    if test $status -ne 0
        echo "Invalid input: $selected_task"
        return 1
    else if test $selected_task -gt (count $services)
        echo "Invalid input: $selected_task"
        return 1
    else if test $selected_task -lt 1
        echo "Invalid input: $selected_task"
        return 1
    end

    set -l selected_task $services[$selected_task]

    if not contains $selected_task $services
        echo "Invalid service: $selected_task"
        return 1
    end

    # List tasks for the service
    set task_id (aws ecs list-tasks --profile "$profile" --region "$region" --cluster $cluster --service-name $selected_task --query "taskArns[]" --output text | string split "\n")

    # Describe the task to get container name
    set container_name (aws ecs describe-tasks --profile "$profile" --region "$region" --cluster $cluster --tasks $task_id --query "tasks[0].containers[].name" --output text | string replace -ra '\s+' '\n' | grep -v '^ecs-service-connect-' | head -n 1)

    echo "Connecting to:"
    echo " - Container $container_name"
    echo " - Task: $selected_task"
    echo " - Task ID: $task_id"

    aws ecs execute-command \
        --profile "$profile" \
        --region "$region" \
        --cluster $cluster \
        --task $task_id \
        --container $container_name \
        --interactive \
        --command $cmd
end
