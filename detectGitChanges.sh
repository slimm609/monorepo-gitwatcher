#!/bin/bash -e
watch_files=$1

oldIFS=$IFS
IFS=$'\r\n' GLOBIGNORE='*' command eval 'IGNORE_FILES=($(cat $watch_files))'
IFS=$oldIFS
trigger_build="false"

detect_changed_folders() {
  folders=`git diff --name-only $GIT_COMMIT $GIT_PREVIOUS_COMMIT | sort -u | uniq`
  export changed_components=$folders
}

run_tests() {
  for component in $changed_components; do
    for file in ${IGNORE_FILES[@]}; do
      if echo $component | grep -q $file; then
        echo "$component has changed"
        echo "triggering build"
        trigger_build="true"
        break 3
      fi
    done
  done
}

detect_changed_folders
run_tests

echo $trigger_build
