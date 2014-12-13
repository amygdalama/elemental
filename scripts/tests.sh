#!/bin/bash

# Usage:

# $ ./tests.sh 01
# runs all .tst scripts in the directory for chapter 1

# $ MODIFIED_ONLY=true ./tests.sh
# runs .tst scripts for all modified .hdl files

ROOT_DIR=$(git rev-parse --show-toplevel)

if [ $MODIFIED_ONLY ]
then
    HDL_TESTS=$(grep -f <(git diff --name-only --staged |
                          grep .hdl |
                          sed s/.hdl/.tst/g)
                        <(find $ROOT_DIR -name "*.tst"))
else
    HDL_TESTS=$(find $ROOT_DIR/projects/$1 -name "*.tst")
fi

NUM_HDL_TESTS=$(echo $HDL_TESTS | wc -w)
FAILURES=0

i=0
for f in $HDL_TESTS
do
    ((i++))
    echo "Running test" $f "[1m[33m($i/$NUM_HDL_TESTS)[0m"
    $ROOT_DIR/tools/HardwareSimulator.sh $f
    if [ $? = 0 ]
    then
        echo -e "[1m[32mOK[0m"
    else
        ((FAILURES++))
        echo -e "[1m[31mFAIL[0m"
    fi
done

echo "[1m-------- RESULTS --------[0m"
echo "Ran $NUM_HDL_TESTS test(s)"

if [ $FAILURES = 0 ]
then
    echo -e "[1m[32mOK[0m"
    exit 0
else
    echo -e "[1m[31m$FAILURES failure(s)[0m"
    exit 1
fi

