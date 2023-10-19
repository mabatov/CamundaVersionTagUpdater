#!/bin/bash

prev_version=$(awk -F '[<>]' '/<prev.release>/{print $3; exit}' pom.xml)
current_version=$(awk -F '[<>]' '/<version>/{print $3; exit}' pom.xml)

# Get the changed .bpmn files
changed_files=$(git diff --name-only --diff-filter=AMR origin/release/$prev_version | grep -E '\.groovy|\.bpmn')

# Loop through each changed file
for item in $changed_files
do
    if [[ $item == *".groovy" ]]
    then
        bpmn_dir=$(echo $item | sed 's/\/groovy.*//') # Get the directory containing the .bpmn file
        bpmn_file=$(find $bpmn_dir -name '*.bpmn') # Find the .bpmn file in the directory
        version_tag="camunda:versionTag=\"$current_version\"" # New version tag to be replaced in the .bpmn file
        sed -i "" "s/camunda:versionTag=\"[^\"]*\"/$version_tag/g" $bpmn_file
        echo "Updated version tag in $bpmn_file"
    elif [[ $item == *".bpmn" ]]
    then
        version_tag="camunda:versionTag=\"$current_version\"" # New version tag to be replaced in the .bpmn file
        sed -i "" "s/camunda:versionTag=\"[^\"]*\"/$version_tag/g" $item
        echo "Updated version tag in $item"
    fi
done
