#!/bin/bash
yum install -y python-virtualenv

virtualenv ansibledodrioproject
source /home/vagrant/ansibledodrioproject/bin/activate

pip install ansible
ansible --version

cp -Rn /shared_folder/ansible_playground ~/ansible_playground/
chmod 600 ~/ansible_playground/ansible.cfg
chmod 600 ~/ansible_playground/inventory

ansible-galaxy install -r ~/ansible_playground/requirements.yml

# cp --force /shared_folder/ansible_playground/Templates/basic-security.groovy.j2 ~/.ansible/roles/geerlingguy.jenkins/templates/
# chmod 644 ~/.ansible/roles/geerlingguy.jenkins/templates/basic-security.groovy.j2

cp --force /shared_folder/ansible_playground/Variables/main.yml ~/.ansible/roles/geerlingguy.jenkins/defaults/
dos2unix ~/.ansible/roles/geerlingguy.jenkins/defaults/main.yml
chmod 644 ~/.ansible/roles/geerlingguy.jenkins/defaults/main.yml

# sed -i -e 's/jenkins_hostname: localhost/jenkins_hostname: vm2.proiect.sprint1/'  ~/.ansible/roles/geerlingguy.jenkins/defaults/main.yml
# sed -i -e 's/jenkins_http_port: 8080/jenkins_http_port: 8888/'  ~/.ansible/roles/geerlingguy.jenkins/defaults/main.yml
# sed -i -e 's/jenkins_plugins: []/jenkins_plugins: ["git", "matrix-auth", "workflow-aggregator", "credentials-binding", "ws-cleanup", "ssh-slaves", "cloudbees-folder"]/'  ~/.ansible/roles/geerlingguy.jenkins/defaults/main.yml

cd ~/ansible_playground/
find . -type f -print0 | xargs -0 dos2unix

echo "---------------------------------------------------"

ansible-playbook PingPlaybook.yml

echo "---------------------------------------------------"

ansible-galaxy init Dependencies
cp --force /shared_folder/ansible_playground/Roles/Dependencies/tasks/main.yml ~/ansible_playground/Dependencies/tasks/

ansible-galaxy init MainInstall
cp --force /shared_folder/ansible_playground/Roles/MainInstall/tasks/main.yml ~/ansible_playground/MainInstall/tasks/

ansible-galaxy init ServiceUser
cp --force /shared_folder/ansible_playground/Roles/ServiceUser/tasks/main.yml ~/ansible_playground/ServiceUser/tasks/

ansible-galaxy init PrivateRegistry
cp --force /shared_folder/ansible_playground/Roles/PrivateRegistry/tasks/main.yml ~/ansible_playground/PrivateRegistry/tasks/

ansible-galaxy init Nexus
cp --force /shared_folder/ansible_playground/Roles/Nexus/tasks/main.yml ~/ansible_playground/Nexus/tasks/

ansible-playbook DockerPlaybook.yml

echo "---------------------------------------------------"

ansible-galaxy init JenkinsDependencies
cp --force /shared_folder/ansible_playground/Roles/JenkinsDependencies/tasks/main.yml ~/ansible_playground/JenkinsDependencies/tasks/

ansible-playbook JenkinsPlaybook.yml

echo "---------------------------------------------------"

ansible-galaxy init CreateJobs
cp --force /shared_folder/ansible_playground/Roles/CreateJobs/tasks/main.yml ~/ansible_playground/CreateJobs/tasks/

ansible-playbook CreateJenkinsJobsPlaybook.yml

echo "---------------------------------------------------"

ansible-galaxy init BuildJobs
cp --force /shared_folder/ansible_playground/Roles/BuildJobs/tasks/main.yml ~/ansible_playground/BuildJobs/tasks/

ansible-playbook BuildJenkinsJobsPlaybook.yml

echo "---------------------------------------------------"

ansible-galaxy init Tomcat
cp --force /shared_folder/ansible_playground/Roles/Tomcat/tasks/main.yml ~/ansible_playground/Tomcat/tasks/
cp --force /shared_folder/ansible_playground/Roles/Tomcat/Dockerfile ~/ansible_playground/Tomcat/

ansible-playbook TomcatPlaybook.yml

echo "---------------------------------------------------"
