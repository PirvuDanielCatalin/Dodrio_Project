echo "# Pull changes"
git pull origin master
echo " "
echo "# Delete tags"
git tag -l | xargs -n 1 git push --delete origin
git tag | xargs git tag -d
echo " "
echo "# Commit and Push"
cat pom.initial.xml > pom.xml
git add .
git commit -m "Reset to v1.0.0-SNAPSHOT"
git push https://ColaboratorDevOps:DevOpsTeam1@github.com/ColaboratorDevOps/Dodrio_Project.git
echo " "
