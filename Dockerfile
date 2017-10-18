FROM solita/ubuntu-systemd

RUN apt-get update && apt-get install -y openssh-server python sudo cron
RUN mkdir /var/run/sshd

# Disable password for sudoers
RUN sed "s@%sudo\s*ALL=(ALL:ALL)\s*ALL@%sudo   ALL=(ALL:ALL) NOPASSWD: ALL@g" -i /etc/sudoers

# Setup user
RUN useradd --create-home --shell /bin/bash --groups sudo ubuntu
RUN echo "AllowUsers ubuntu" >> /etc/ssh/sshd_config

# Copy public key to container
COPY id_rsa.pub /home/ubuntu/.ssh/authorized_keys
