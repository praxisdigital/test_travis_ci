#!/usr/bin/bash

# Search for PHP syntax errors.
find -L . -name '*.php' -print0 | xargs -0 -n 1 -P 4 php -l
# Run PHPCS.
# If the custom ruleset is named `.phpcs.xml`, `phpcs.xml`, `.phpcs.xml.dist` or `phpcs.xml.dist`
# and, like the travis script, is in the root of the project, you can leave
# out the `--standard=` part of the command.
if [[ "$SNIFF" == "1" ]]; then
    RESULT=`$PHPCS_DIR/bin/phpcs . --standard=./custom-ruleset.xml`;
    echo $RESULT "\n";
    if [ "$RESULT" == 2 ]; then
        exit 0;
    else
        exit 1;
    fi
fi
