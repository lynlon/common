#!/bin/sh
LANG=C

if [ ! -f *.spec ]; then
    echo "Cannot find spec file"
    exit 2
fi

if [ -f ./get_sources.sh ] && [ -f ./download ]; then
    cp ../common/get_sources.sh .
    sh ./get_sources.sh
    rm -f ./get_sources.sh
elif [ -x /usr/bin/spectool ]; then
    RUNSPECTOOL="no"
    for i in `spectool -l -S *.spec | awk -F"[ /]" '{ print $NF }'`; do
        if [ ! -f $i ]; then
             echo NO $i found;
             RUNSPECTOOL="yes"
             break;
        fi
    done

    if [ "$RUNSPECTOOL" == "yes" ]; then
        /usr/bin/spectool -g *.spec
    else
        echo "All sources found"
    fi
else
    echo "Cannot download source. No get_source.sh nor spectool found."
    exit 1
fi
