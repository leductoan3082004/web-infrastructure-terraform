---
- name: Install Docker and Jenkins on Ubuntu
  hosts: root@165.232.162.142 
  become: yes  # Run tasks with sudo

  tasks:
    - name: Update apt package cache
      apt:
        update_cache: yes

    - name: Install dependencies
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - apt-transport-https
        - ca-certificates
        - curl
        - software-properties-common

    - name: Add Docker GPG key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg

    - name: Add Docker APT repository
      apt_repository:
        repo: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ ansible_distribution_release }} stable

    - name: Install Docker
      apt:
        name: docker-ce
        state: present

    - name: Install Docker Compose
      pip:
        name: docker-compose
        state: present

    - name: Add Jenkins APT repository key
      apt_key:
        url: https://pkg.jenkins.io/debian/jenkins.io.key

    - name: Add Jenkins APT repository
      apt_repository:
        repo: deb http://pkg.jenkins.io/debian-stable binary/

    - name: Install Jenkins
      apt:
        name: jenkins
        state: present

    - name: Start Docker service
      service:
        name: docker
        state: started

    - name: Start Jenkins service
      service:
        name: jenkins
        state: started
