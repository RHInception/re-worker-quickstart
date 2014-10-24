#!/bin/bash
set -u


Worker_Name_Camel="TestWorker1"
worker_name_lower=`echo ${Worker_Name_Camel} | tr '[[A-Z]]' '[[a-z]]'`
long_description="Scaffolding for a new worker Scaffolding for a new worker Scaffolding for a new worker Scaffolding for a new worker"
short_description="Scaffolding for a new worker"
author_name="Some Person"
author_email="some.person@example.com"
build_date=`date "+%a %b %e %Y"`

mkdir -p contrib/rpm/ replugin/${worker_name_lower}worker

touch replugin/__init__.py
touch requirements.txt

sed -e "s/{{worker_name}}/${worker_name_lower}/" \
    -e "s/{{worker_short_description}}/${short_description}/" templates/README.md > README.md

sed -e "s/{{worker_name}}/${worker_name_lower}/" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/" templates/test_worker.py > test/test_${worker_name_lower}.py

sed -e "s/{{worker_name}}/${worker_name_lower}/" templates/Makefile > Makefile

sed -e "s/{{worker_name}}/${worker_name_lower}/" \
    -e "s/{{worker_short_description}}/${short_description}/" templates/setup.py > setup.py

sed -e "s/{{worker_short_description}}/${short_description}/" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/" templates/worker-init.py > replugin/${worker_name_lower}worker/__init__.py

sed -e "s/{{worker_name}}/${worker_name_lower}/" templates/gitignore > .gitignore

sed -e "s/{{author_email}}/${author_email}/" \
    -e "s/{{author_name}}/${author_name}/" \
    -e "s/{{date}}/${build_date}/" \
    -e "s/{{worker_long_description}}/${long_description}/" \
    -e "s/{{worker_name}}/${worker_name_lower}/" \
    -e "s/{{Worker_Name}}/${Worker_Name_Camel}/" templates/re-worker-quickstart.spec > contrib/rpm/re-worker-${worker_name_lower}.spec
