#!/bin/bash
ansible-playbook -i hosts initial-setup.yaml
ansible-playbook -i hosts configure-nfs.yaml
