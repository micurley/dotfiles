# Convert a .env file to json format
function convert_env_to_json
    set -l json "{"
    for line in (cat $argv[1])
        set -l key (echo $line | cut -d '=' -f 1)
        set -l value (echo $line | cut -d '=' -f 2-)
        set json "$json\"$key\":\"$value\","
    end
    # Remove the trailing comma and close the JSON object
    set json (string trim --right --chars=',' $json)
    set json "$json}"
    echo $json
end
