set -exou pipefail

for arg in $(cat /proc/cmdline); do
    if [ "$arg" = 'fuzz' ]; then
        fuzzer-rs;
    else
        OPT=$(echo "$arg" | cut -d '=' -f 1);
        if [ "$OPT" = "testcase" ]; then
            fuzzer-rs -t $(echo "$arg" | cut -d '=' -f 2);
        fi
    fi
done

/bin/sh
