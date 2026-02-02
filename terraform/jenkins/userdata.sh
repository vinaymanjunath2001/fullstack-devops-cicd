#!/bin/bash
set -e

#################################
# System update
#################################
yum update -y

#################################
# Install Docker
#################################
yum install -y docker
systemctl enable docker
systemctl start docker

#################################
# Allow ec2-user to run docker
#################################
usermod -aG docker ec2-user

#################################
# Create Docker volumes
#################################
docker volume create jenkins_home
docker volume create sonarqube_data
docker volume create sonarqube_extensions

#################################
# Run Jenkins in Docker
#################################
docker run -d \
  --name jenkins \
  --restart always \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts

#################################
# Run SonarQube in Docker
#################################
docker run -d \
  --name sonarqube \
  --restart always \
  -p 9000:9000 \
  -v sonarqube_data:/opt/sonarqube/data \
  -v sonarqube_extensions:/opt/sonarqube/extensions \
  sonarqube:lts

#################################
# Install Trivy on host
#################################
rpm -ivh https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.50.1_Linux-64bit.rpm

#################################
# Info
#################################
echo "Jenkins running on port 8080"
echo "SonarQube running on port 9000"
