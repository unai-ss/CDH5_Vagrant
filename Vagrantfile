#
VAGRANTFILE_API_VERSION = "2"

# define hostname
NAME = "ol7-vagrant"

unless Vagrant.has_plugin?("vagrant-reload")
  puts 'Installing vagrant-reload Plugin...'
  system('vagrant plugin install vagrant-reload')
end

unless Vagrant.has_plugin?("vagrant-proxyconf")
  puts 'Installing vagrant-proxyconf Plugin...'
  system('vagrant plugin install vagrant-proxyconf')
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define "CDH5" do |app|
    app.vm.box = "CentosBox/Centos-7-v7.4-Minimal-CLI"
    app.vm.box_version = "17.11.24"
    app.vm.define "CDH5"
    app.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: "192.168.1.208"
    app.vm.network "private_network", ip: "172.16.1.3"
#    app.vm.synced_folder "./",  "/tmp/sync"
    app.vm.box_url = "\n"
    app.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "CDH5"]
      v.customize ["modifyvm", :id, "--usb", "on"]
      v.customize ["modifyvm", :id, "--usbehci", "off"]
      v.customize ["modifyvm", :id, "--macaddress1", "auto"]
    end

    app.vm.box_check_update = false

    # add proxy configuration from host env - optional
    if Vagrant.has_plugin?("vagrant-proxyconf")
      puts "getting Proxy Configuration from Host..."
      if ENV["http_proxy"]
        puts "http_proxy: " + ENV["http_proxy"]
        app.proxy.http     = ENV["http_proxy"]
      end
      if ENV["https_proxy"]
        puts "https_proxy: " + ENV["https_proxy"]
        app.proxy.https    = ENV["https_proxy"]
      end
      if ENV["no_proxy"]
        app.proxy.no_proxy = ENV["no_proxy"]
      end
    end

    # VM hostname
    app.vm.hostname = "CDH5"

    # Oracle port forwarding
    # config.vm.network "forwarded_port", guest: 22, host: 2220

    # Provision everything on the first run
    app.vm.provision "shell", path: "scripts/java_1_8.sh"
    app.vm.provision "shell", path: "scripts/CDH5_repo.sh"
    app.vm.provision "shell", path: "scripts/system_essentials.sh"
    app.vm.provision "shell", path: "scripts/dnsmasq.sh"
    app.vm.provision "shell", path: "scripts/chrony_server.sh"
    app.vm.provision "shell", inline: "sudo yum install cloudera-manager-daemons cloudera-manager-server -y"
    app.vm.provision "shell", path: "scripts/CDH_MariaDB.sh"
##    app.vm.provision "shell", inline: "sudo systemctl start cloudera-scm-server"
    # Running the script when MySQL or MariaDB is co-located with the Cloudera Manager Server
##    app.vm.provision "shell", inline: "sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql scm scm"
    # Running the script when MySQL or MariaDB is installed on another host
#    app.vm.provision "shell", inline: "sudo /usr/share/cmf/schema/scm_prepare_database.sh mysql -h db01.example.com --scm-host cm01.example.com scm scm"
#    app.vm.provision :reload
    app.vm.provision "shell", inline: "echo 'INSTALLER CDH Manager: Installation complete, try http://<server_host>:7180'"
  end
end
