# Cluster


## Node Setup


## Provision Micro-SD Storage

After flashing the latest Raspbian Lite image, create a file called `ssh`, with
no file extension, in the root of the `/boot` partition to trigger SSHD to
startup on boot.


## Workstation


```bash
ssh-copy-id                    \
  -o StrictHostKeyChecking=no  \
  -i ~/.ssh/id_rsa.pub         \
  pi@[HOSTNAME];
```

The default username/password for Raspbian is `pi` and `raspberry`.

```bash
ansible-playbook main.yml
```
