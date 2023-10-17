#!/bin/bash

# Replace version placeholders in .bpmn files

# Define the placeholder and replacement version
PLACEHOLDER='\${versionTag}'
VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout -f pom.xml)

# Loop through the changed .bpmn files in the current commit
#git diff --name-only --diff-filter=ACMRTUXB HEAD | grep '\.bpmn' | while read -r file; do
#    sed -i 'testMNV' "s|$PLACEHOLDER|$VERSION|g" "$file"
#done