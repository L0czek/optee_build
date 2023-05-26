set -exou pipefail

for arg in $(cat /proc/cmdline); do
    if [ "$arg" = 'fuzz' ]; then
        fuzzer-rs;
    elif [ "$arg" = 'host_fuzz' ]; then
        fuzzer-rs --host_fuzzer
    elif [ "$arg" = "fuzz_no_reverts" ]; then
        fuzzer-rs -n
    else
        OPT=$(echo "$arg" | cut -d '=' -f 1);
        if [ "$OPT" = "testcase" ]; then
            fuzzer-rs -t $(echo "$arg" | cut -d '=' -f 2);
        fi
    fi
done

/bin/sh
