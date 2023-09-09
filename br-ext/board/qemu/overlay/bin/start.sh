set -exou pipefail

MODE=dsl

for arg in $(cat /proc/cmdline); do
    if [ "$arg" = 'fuzz' ]; then
        fuzzer-rs -m$MODE;
    elif [ "$arg" = 'host_fuzz' ]; then
        fuzzer-rs --host_fuzzer -m$MODE
    elif [ "$arg" = "fuzz_no_reverts" ]; then
        fuzzer-rs -n -m$MODE
    elif [ "$arg" = "tcgen" ]; then
        fuzzer-rs -g
    elif [ "$arg" = "exit" ]; then
        fuzzer-rs -e
    else
        OPT=$(echo "$arg" | cut -d '=' -f 1);
        if [ "$OPT" = "testcase" ]; then
            fuzzer-rs -t $(echo "$arg" | cut -d '=' -f 2) -m$MODE
        elif [ "$OPT" = "mode" ]; then
            MODE=$(echo "$arg" | cut -d '=' -f 2)
        fi
    fi
done

/bin/sh
