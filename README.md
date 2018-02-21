detect changes to certain folders in a monorepo



example for a jenkins job
```
trigger_build="$(./detectGitChanges.sh path/to/folders.watch)"

if [[ "x$trigger_build" == "xfalse" ]]; then
  echo "no changes detected...  exiting."
  exit
fi
```

example of a pipeline job
```
stage('example job') {
            when {
                expression {
                    return "true" == sh(returnStdout: true, script: './tools/detectGitChanges.sh path/to/folders.watch | tail -n 1').trim()
                }
            }
            steps {
                build job: 'job-to-run', wait: true
                script {
                     env.CHANGES = "true"
                }
            }
        }
```
