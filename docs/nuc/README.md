# NUC


## Setup


### Local

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub patrick@HOSTNAME
```


### Remote

```bash
su -

apt-get -y install sudo
echo "patrick ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/patrick

apt-get -y install python
```


### Ansible

```bash
ansible-playbook main.yml
```
