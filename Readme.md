# Create truffle learning

** first create github script! create a new repository on the command line

```shell

echo "# TruffleLearning" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/bigdot123456/TruffleLearning.git
git push -u origin master
```
** second use truffle command to migrate contract

```shell
truffle init
truffle compile
truffle migrate
```
