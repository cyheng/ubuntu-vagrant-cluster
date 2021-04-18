# -*- mode: ruby -*-
# vi: set ft=ruby :

#
$clusters_script = <<-SCRIPT
#!/bin/bash

# at /home/vagrant
#---hosts---
cat >> /etc/hosts <<EOF

192.168.56.101  node1
192.168.56.102  node2
192.168.56.103  node3

EOF
#---ssh_config-----
cat >> /etc/ssh/ssh_config <<EOF

StrictHostKeyChecking no

UserKnownHostsFile /dev/null

EOF

#install pssh
tar xf pssh-2.3.1.tar.gz
cd ./pssh-2.3.1/
sudo python setup.py install
cd ..
chmod +x *.sh
rm -f *.gz
#---ssh---
mv /home/vagrant/sshd_config /etc/ssh/sshd_config
/etc/init.d/ssh restart

#apt source backup and replace to tsinghua ubuntu 16.04 source
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
touch tsinghua.list
sudo cat >> tsinghua.list  <<EOF
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse
EOF
sudo mv tsinghua.list /etc/apt/sources.list
sudo apt-get update

#install except,use for ssh login without password
sudo apt-get install tcl tk expect -y

SCRIPT


Vagrant.configure("2") do |config|
		# if Vagrant.has_plugin?("vagrant-proxyconf")
		# config.proxy.http     = "https://192.168.0.2:7890/"
		# config.proxy.https    = "https://192.168.0.2:7890/"
		# config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
		# end
		(1..3).each do |i|
		config.vm.define "node#{i}" do |node|
	
		# 设置虚拟机的Box
		node.vm.box = "ubuntu/trusty64"
		# 设置虚拟机的主机名
		node.vm.hostname="node#{i}"
		# 设置虚拟机的IP
		node.vm.network "private_network", ip: "192.168.56.#{100+i}"

		# 设置主机与虚拟机的共享目录
		#node.vm.synced_folder "~/Desktop/share", "/home/vagrant/share"
		# 复制相应的依赖文件
		config.vm.provision "file", source: "./sshd_config", destination: "/home/vagrant/sshd_config"
		config.vm.provision "file", source: "./host_ip.txt", destination: "/home/vagrant/host_ip.txt"
		config.vm.provision "file", source: "./ip.txt", destination: "/home/vagrant/ip.txt"
		config.vm.provision "file", source: "./pssh-2.3.1.tar.gz", destination: "/home/vagrant/pssh-2.3.1.tar.gz"
		config.vm.provision "file", source: "./ssh_ip.sh", destination: "/home/vagrant/ssh_ip.sh"
 

		# VirtaulBox相关配置
		node.vm.provider "virualbox" do |v|
			# 设置虚拟机的名称
			v.name = "node#{i}"
			# 设置虚拟机的内存大小  
			v.memory = 1024
			# 设置虚拟机的CPU个数
			v.cpus = 1
		end
		node.vm.provision "shell", inline: $clusters_script # 使用shell脚本进行软件安装和配置
		end
	end
end
