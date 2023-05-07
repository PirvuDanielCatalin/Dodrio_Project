# Welcome to Dodrio!

## Vagrant & Virtual Box

Pentru rularea proiectului sunt necesare instalate pe masina locala urmatoarele: 
1. **[Oracle Virtual Box](https://www.virtualbox.org/wiki/Downloads)**
2. **[Vagrant](https://www.vagrantup.com)**
3. **[Git](https://git-scm.com/downloads)**


## Plan

Primul pas este sa avem **repository-ul** clonat local, iar pentru asta vom rula comanda
```
git clone https://github.com/PirvuDanielCatalin/Dodrio_Project_Docs.git
```
Dupa care trebuie sa ne situam in interiorul directorului proiectului cu ajutorul comenzii
```
cd Dodrio_Project_Docs
```
Ultimul pas reprezinta rularea intregului script. Pt asta rulam comanda
```
vagrant up
```

## Masinile virtuale

Nume Masina         | IP            | Hostname            | Config Name
--------------------| ------------- | ------------------- | -------
VM1.Proiect.Sprint1 | 192.168.56.61 | vm1.proiect.sprint1 | VM1
VM2.Proiect.Sprint1 | 192.168.56.62 | vm2.proiect.sprint1 | VM2
VM3.Proiect.Sprint1 | 192.168.56.63 | vm3.proiect.sprint1 | VM3

## Utilitatea masinilor virtuale

Nume Masina 	    | Utilitate
--------------------| -------------
VM1.Proiect.Sprint1 | Ansible Control Node
VM2.Proiect.Sprint1 | Jenkins Master
VM3.Proiect.Sprint1 | Docker, Private Registry, Nexus


## Conectare la masina virtuala

Pentru a va conecta pe o masina, fiind pe Windows, rulati comanda:
> ```
> vagrant ssh 'nume_masina'
> ```
Pentru a va conecta pe o masina, fiind pe oricare din cele trei masini, rulati comanda:
> ``` 
> ssh vagrant@hostname_masina
> ```
sau
> ``` 
> ssh 'config_name' 
> ```
  
## Ansible Playbooks

Nume playbook	                | Utilitate
------------------------------- | ----------
PingPlaybook			        | Verifica daca ne putem conecta prin SSH la cele 3 masini
DockerPlaybook			        | Instaleaza dependintele si serviciul de Docker, Creeaza un Private Registry si Creeaza serviciul de Nexus
JenkinsPlaybook			        | Instaleaza dependintele si serviciul de Jenkins
CreateJenkinsJobsPlaybook.yml	| Creeaza job-urile de Jenkins pe baza fisierelor XML din directorul jenkins_jobs
BuildJenkinsJobsPlaybook.yml	| Da comanda de build tuturor job-urilor create de playbook-ul anterior
TomcatPlaybook.yml		        | Creeaza un container cu serviciul de Tomcat pt a hosta aplicatia
  
## Pentru a rula playbook-urile folosind Ansible

- Primul pas este de a ne situa pe masina VM1, iar pentru asta:
	1. rulam comanda ``` vagrant ssh VM1.Proiect.Sprint1 ```, daca executam de pe Windows
	2. rulam comanda ``` ssh VM1 ```, daca executam de pe oricare masina in afara masinii VM1

- Apoi ne conectam ca **root** prin comanda ``` su ```, parola este aceeasi ca a userului vagrant si anume **vagrant**.

- Ne mutam in folderul **ansible_playground** din directorul home al userului root.
Comanda este``` cd ~/ansible_playground ```

- Executam un playbook cu ajutorul comenzii ``` ansible-playbook 'NumePlaybook.yml' ```
