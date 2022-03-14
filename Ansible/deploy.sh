#!/bin/bash
ansible-playbook -i hosts 01-initial-setup.yaml
ansible-playbook -i hosts 02-configure-nfs.yaml
ansible-playbook -i hosts 03-configure-k8-common.yaml
ansible-playbook -i hosts 04-configure-k8-master.yaml