#!/bin/sh

# Modify /etc/yum.repos.d/epel.repo. Under the section marked [epel], change enabled=0 to enabled=1.

sudo yum install erlang --enablerepo=epel || true

wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.1.1/rabbitmq-server-3.1.1-1.noarch.rpm || true

sudo rpm -Uvh rabbitmq-server-3.1.1-1.noarch.rpm || true

# Enable managament plugin
sudo rabbitmq-plugins enable rabbitmq_management || true