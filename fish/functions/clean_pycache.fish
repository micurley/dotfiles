function clean_pycache
    # Find all __pycache__ directories and remove them recursively
    find . -type d -name __pycache__ -exec rm -r {} +
    find . -type f -name '*.pyc' -exec rm -f {} +
    echo "All __pycache__ directories and .pyc files have been deleted."
end
