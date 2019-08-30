# Minecraft


## Setup


### Workstation

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub patrick@HOSTNAME
```


### Local

```bash
su -

apt-get -y install sudo
echo "patrick ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/patrick

apt-get -y install python
```


### Workstation

```bash
ansible-playbook main.yml
```
