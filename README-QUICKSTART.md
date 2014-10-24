# How to Use The Quickstarter

1. Clone this repo from GitHub:

    $ git clone git@github.com:RHInception/re-worker-quickstart.git

1. Edit ``gen-scaffolding.sh`` and customize the variables at the top
   between the two large comment blocks

1. Run ``gen-scaffolding.sh``

# Cleaning Up

Once you're satisfied with the results you'll want to remove the
original quickstart files and original repository information:

    $ rm -fR templates .git/

With those files out of the way, you can create a new git repository
and associate it with your upstream GitHub repository (assuming you
have already gone ahead and created the new github repo):

    $ git init .
    $ git add .
    $ git commit -am "First commit"
    $ git remote add -f origin git@github.com:NameOrGroup/repository-name.git
    $ git push origin -u master:master

# Customizing

With the basics set up, you can begin customizing the results. Things
to remember:

* Update your ``requirements.txt`` file with any additional libraries
  required by Python
* Update the ``contrib/rpm/re-worker-name.spec`` file with any
  additional package requirements
* Word-wrap the ``%description`` in ``contrib/rpm/re-worker-name.spec``
* Start writing code and unit tests!

