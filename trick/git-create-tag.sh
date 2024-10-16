#!/bin/bash 

# Function to check for errors and exit if any are found
check_error() {
    if [ $? -ne 0 ]; then
        echo "Error occurred! Exiting..."
        exit 1
    fi
}

# Function to confirm actions with yes/no or y/n input
confirm() {
    while true; do
        read -p "$1 (y/n or yes/no): " input
        case $input in
            [yY] | [yY][eE][sS] )
                return 0
                ;;
            [nN] | [nN][oO] )
                return 1
                ;;
            * )
                echo "Please answer with 'y/n' or 'yes/no'."
                ;;
        esac
    done
}

# Fetch the latest tags from the server
echo "Fetching latest tags from server..."
git fetch --tags
check_error

# Get the latest tag
latest_tag=$(git tag --sort=-v:refname | head -n 1)

# Check if there are no tags
if [ -z "$latest_tag" ]; then
    echo "No tags found."
    if confirm "Do you want to create an initial tag (v0.0.1)?"; then
        read -p "Enter the tag (default is v0.0.1): " initial_tag
        initial_tag=${initial_tag:-v0.0.1}
        git tag $initial_tag
        git push origin $initial_tag
        check_error
        echo "Initial tag $initial_tag created and pushed."
        latest_tag=$initial_tag
    else
        echo "No tags created. Exiting."
        exit 0
    fi
fi

echo "Latest tag is: $latest_tag"

# Function to increment version
increment_version() {
    IFS='.' read -r major minor patch <<< "${latest_tag#v}"

    case $1 in
        major)
            ((major++))
            minor=0
            patch=0
            ;;
        minor)
            ((minor++))
            patch=0
            ;;
        patch)
            ((patch++))
            ;;
        *)
            echo "Invalid version type!"
            exit 1
            ;;
    esac

    new_tag="v${major}.${minor}.${patch}"
    echo "New tag will be: $new_tag"
}

# Ask the user for the version increment type: minor, major, or patch
read -p "Would you like to increment the tag as 'minor', 'major', or 'patch'? " version_type
increment_version $version_type

# Confirm the new tag creation
if confirm "Do you want to create a new tag: $new_tag?"; then
    git tag $new_tag
    check_error
    echo "New tag $new_tag created locally."
else
    echo "Tag creation canceled."
    exit 0
fi

# Ask if the user wants to push the tag to the remote
if confirm "Do you want to push the new tag to the remote?"; then
    git push origin $new_tag
    check_error
    echo "Tag $new_tag pushed to remote."
else
    echo "Tag was not pushed."
fi

