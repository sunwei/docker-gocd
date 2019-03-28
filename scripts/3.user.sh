#!/bin/bash
set -e

(
    (
        nice -n +5 /pre-conf.sh \
        && echo "> Setup done!" \
    )
) &disown