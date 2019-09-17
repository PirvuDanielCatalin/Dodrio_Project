git pull origin master

git tag -l | xargs -n 1 git push --delete origin
git tag | xargs git tag -d

cat pom.initial.xml > pom.xml
git add .
git commit -m "Reset to v1.0.0-SNAPSHOT"
git push https://ColaboratorDevOps:DevOpsTeam1@github.com/ColaboratorDevOps/DoduoProject.git

git pull origin master
