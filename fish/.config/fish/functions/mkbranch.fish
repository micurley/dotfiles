function mkbranch
    if test (count $argv) -lt 2
        echo "Usage: mkbranch <ticket number> <description>"
        return 1
    end

    set ticket $argv[1]
    set desc $argv[2..-1] # grab everything after the ticket number

    # Join all parts of the description with hyphens and slugify
    set slug (string join " " $desc | string lower | string replace -r '[^a-z0-9]+' '-' | string trim -c '-')

    set branch "chk-$ticket-$slug"

    git cob $branch
    echo "✔ Created branch: $branch"
end
