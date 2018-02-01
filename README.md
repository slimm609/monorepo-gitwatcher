detect changes to certain folders in a monorepo



example for a jenkins job
```
trigger_build="$(./detectGitChanges.sh path/to/folders.watch)"

if [[ "x$trigger_build" == "xfalse" ]]; then
  echo "no changes detected...  exiting."
  exit
fi
```