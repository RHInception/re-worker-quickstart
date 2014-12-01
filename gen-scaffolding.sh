#!/bin/bash
set -u

######################################################################
#
# CUSTOMIZE THE FOLLOWING VARIABLES TO YOUR PREFERENCE
#
######################################################################

######################################################################
# This is your worker's name in CamelCase.
#
# DO NOT INCLUDE THE WORD "Worker" IN THIS VARIABLE NAME!!!
#
# DO NOT INCLUDE THE WORD "Worker" IN THIS VARIABLE NAME!!!
#
# DO NOT INCLUDE THE WORD "Worker" IN THIS VARIABLE NAME!!!
Worker_Name_Camel="MyCoolThing"

######################################################################
# This is your worker's long description. It's used in the rpm spec file
#
# DO NOT INCLUDE NEW-LINE CHARACTERS IN THIS VARIABLE
#
# After you run this script you should word-wrap the %description
# field in the generated spec file.
long_description="Scaffolding for a new worker Scaffolding for a new worker Scaffolding for a new worker Scaffolding for a new worker"

######################################################################
short_description="Scaffolding for a new worker"

######################################################################
# Your name
author_name="Some Person"

######################################################################
# Your email address
author_email="some.person@example.com"

######################################################################
#
# END CUSTOMIZATION
#
######################################################################



######################################################################
# Do not touch any variables after this point unless you know what
# you're doing
worker_name_lower=`echo ${Worker_Name_Camel} | tr '[[A-Z]]' '[[a-z]]'`
build_date=`date "+%a %b %e %Y"`
mkdir -p contrib/rpm/ replugin/${worker_name_lower}worker
touch replugin/__init__.py
touch requirements.txt

sed -e "s/{{worker_name}}/${worker_name_lower}/g" \
    -e "s/{{worker_short_description}}/${short_description}/" templates/README.md > README.md

sed -e "s/{{worker_name}}/${worker_name_lower}/g" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/g" templates/test_worker.py > test/test_${worker_name_lower}.py

sed -e "s/{{worker_name}}/${worker_name_lower}/g" templates/Makefile > Makefile

sed -e "s/{{worker_name}}/${worker_name_lower}/g" \
    -e "s/{{worker_short_description}}/${short_description}/" templates/setup.py > setup.py

sed -e "s/{{worker_short_description}}/${short_description}/" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/g" templates/worker-init.py > replugin/${worker_name_lower}worker/__init__.py

sed -e "s/{{worker_name}}/${worker_name_lower}/g" templates/gitignore > .gitignore

sed -e "s/{{author_email}}/${author_email}/" \
    -e "s/{{author_name}}/${author_name}/" \
    -e "s/{{date}}/${build_date}/" \
    -e "s/{{worker_long_description}}/${long_description}/" \
    -e "s/{{worker_name}}/${worker_name_lower}/" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/" templates/re-worker-quickstart.spec > contrib/rpm/re-worker-${worker_name_lower}.spec

echo "${author_name} <${author_email}>" > AUTHORS
