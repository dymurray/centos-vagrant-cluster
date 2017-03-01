#!/bin/sh --login

yum -y install epel-release

yum -y install deltarpm wget git net-tools bind-utils bridge-utils gcc docker vim ansible

groupadd docker
gpasswd -a vagrant docker

sed -i "s/OPTIONS='--selinux-enabled/OPTIONS='--selinux-enabled --insecure-registry 172.30.0.0\/16/g" /etc/sysconfig/docker  
sed -i "s/DOCKER_NETWORK_OPTIONS=/DOCKER_NETWORK_OPTIONS='--bip=172.16.0.1\/16'/g" /etc/sysconfig/docker-network
ifdown eth1
ifup eth1
systemctl enable docker; systemctl start docker


wget https://github.com/openshift/origin/releases/download/v1.5.0-alpha.3/openshift-origin-client-tools-v1.5.0-alpha.3-cf7e336-linux-64bit.tar.gz -O /tmp/oc.tar.gz

tar -xzf /tmp/oc.tar.gz -C /tmp
mv /tmp/openshift-origin-client-tools-v1.5.0-alpha.3-cf7e336-linux-64bit/oc /usr/local/bin/

/usr/local/bin/oc cluster up
