#!/bin/bash 
yum update
yum install -y docker
systemctl start docker
systemctl enable docker