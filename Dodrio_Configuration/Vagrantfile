Vagrant.configure("2") do |config|

  config.vm.define "VM3.Proiect.Sprint1" do |subconfig|
  
    subconfig.vm.box = "generic/centos7"
  
    subconfig.vm.network "private_network", ip: "192.168.56.63"
    
    subconfig.vm.network "forwarded_port", guest: 80, host: 9983   # HTTP
    subconfig.vm.network "forwarded_port", guest: 5000, host: 5000 # Private Registry
    subconfig.vm.network "forwarded_port", guest: 8080, host: 8888 # Tomcat
    subconfig.vm.network "forwarded_port", guest: 8081, host: 8081 # Nexus
  
    subconfig.vm.synced_folder ".", "/shared_folder", type: "virtualbox"
  
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "VM3.Proiect.Sprint1"
      vb.memory = "2048"
      vb.cpus = "1"
      #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    subconfig.vm.provision "shell", inline: <<-SHELL
    echo "---------------------------------------------------"
    echo " -- VM3 -- "
    echo "---------------------------------------------------"
    bash /shared_folder/general-config.sh
    bash /shared_folder/ssh-config.sh
    bash /shared_folder/vm3-config.sh
    SHELL
  end
  
  config.vm.define "VM2.Proiect.Sprint1" do |subconfig|
  
    subconfig.vm.box = "generic/centos7"
  
    subconfig.vm.network "private_network", ip: "192.168.56.62"
    
    subconfig.vm.network "forwarded_port", guest: 80, host: 9982   # HTTP
    subconfig.vm.network "forwarded_port", guest: 8080, host: 8080 # Jenkins
  
    subconfig.vm.synced_folder ".", "/shared_folder", type: "virtualbox"
  
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "VM2.Proiect.Sprint1"
      vb.memory = "2048"
      vb.cpus = "1"
      #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    subconfig.vm.provision "shell", inline: <<-SHELL
    echo "---------------------------------------------------"
    echo " -- VM2 -- "
    echo "---------------------------------------------------"
    bash /shared_folder/general-config.sh
    bash /shared_folder/ssh-config.sh
    bash /shared_folder/vm2-config.sh
    SHELL
  end

  config.vm.define "VM1.Proiect.Sprint1" do |subconfig|
  
    subconfig.vm.box = "generic/centos7"
  
    subconfig.vm.network "private_network", ip: "192.168.56.61"
    
    subconfig.vm.network "forwarded_port", guest: 80, host: 9981 # HTTP
  
    subconfig.vm.synced_folder ".", "/shared_folder", type: "virtualbox"
  
    subconfig.vm.provider "virtualbox" do |vb|
      vb.name = "VM1.Proiect.Sprint1"
      vb.memory = "512"
      vb.cpus = "1"
      #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    subconfig.vm.provision "shell", inline: <<-SHELL
    echo "---------------------------------------------------"
    echo " -- VM1 -- "
    echo "---------------------------------------------------"
    bash /shared_folder/general-config.sh
    bash /shared_folder/ssh-config.sh
    bash /shared_folder/ansible-config.sh
    bash /shared_folder/vm1-config.sh
    SHELL
  end
end