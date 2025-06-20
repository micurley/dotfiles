function connect_to_task
    set region us-east-1
    if test (count $argv) -gt 0
        set env $argv[1]
    else
        set env dev
    end

    if test (count $argv) -gt 1
        set cmd $argv[2]
    else
        set cmd /bin/bash
    end

    set -g envs dev development dev2 development prod production stage stage
    set -g clusters dev dev-ecs-cluster dev2 conduit-dev prod production-ecs-cluster stage staging-ecs-cluster

    for i in (seq 1 2 (count $clusters))
        set -l c_key $clusters[$i]
        set -l c_value $clusters[(math $i + 1)]
        set -l e_value $envs[(math $i + 1)]

        set -l first_letter (echo $c_key | string sub -l 1)
        set -g clusters $clusters $first_letter $c_value
        set -g envs $envs $first_letter $e_value
    end

    for i in (seq 1 2 (count $clusters))
        set -l j (math $i + 1)
        if test $clusters[$i] = $env
            set cluster $clusters[$j]
        end
        if test $envs[$i] = $env
            set profile $envs[$j]
        end
    end

    if test -z $cluster
        echo "Environment not found"
        return 1
    end

    set services (aws ecs list-services --profile "$profile" --region "$region" --cluster "$cluster" --query "serviceArns[]" | jq -r 'sort[]')
    echo "ECS Services:"
    set -l i 1
    for s in $services
        set service_name (echo $s | string split "/" | tail -n1)
        echo "$i. $service_name in $region"
        set i (math $i + 1)
    end

    read -P "Select a Service: " selected_task
    if test -z "$selected_task"
        set selected_task 1
    end

    set selected_task (math "0 + $selected_task")
    if test $selected_task -lt 1 -o $selected_task -gt (count $services)
        echo "Invalid service selection"
        return 1
    end

    set selected_service $services[$selected_task]
    set service_name (echo $selected_service | string split "/" | tail -n1)

    set task_arns (
        aws ecs list-tasks \
            --profile "$profile" \
            --region "$region" \
            --cluster $cluster \
            --service-name $service_name \
            --query "taskArns[]" \
            --output json | jq -r '.[]'
    )

    if test (count $task_arns) -eq 0
        echo "No tasks found for service $service_name"
        return 1
    else if test (count $task_arns) -eq 1
        set task_id $task_arns[1]
    else
        echo "Multiple tasks found:"
        for i in (seq (count $task_arns))
            echo "$i. $task_arns[$i]"
        end
        read -P "Select a Task: " task_choice
        if test -z "$task_choice"
            set task_choice 1
        end
        set task_choice (math "0 + $task_choice")
        if test $task_choice -lt 1 -o $task_choice -gt (count $task_arns)
            echo "Invalid task selection"
            return 1
        end
        set task_id $task_arns[$task_choice]
    end

    set container_name (
        aws ecs describe-tasks --profile "$profile" --region "$region" --cluster $cluster --tasks $task_id --query "tasks[0].containers[].name" --output text |
        string replace -ra '\s+' '\n' | grep -v '^ecs-service-connect-' | head -n 1
    )

    echo "Connecting to:"
    echo " - Container: $container_name"
    echo " - Service:   $service_name"
    echo " - Task ID:   $task_id"

    aws ecs execute-command \
        --profile "$profile" \
        --region "$region" \
        --cluster $cluster \
        --task $task_id \
        --container $container_name \
        --interactive \
        --command $cmd
end
