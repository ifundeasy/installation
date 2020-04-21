# Jitsi Meet Installation

#### Host setup
```bash
sudo su
vi /etc/hosts
# type 127.0.0.1 localhost ubuntuvm.com
```

#### Firewall
```bash
ufw allow ssh
ufw allow http
ufw allow https
ufw allow in 10000:20000/udp
ufw enable
```

#### Reboot (optional)
```bash
apt-get update -y
apt-get upgrade -y
shutdown -r now
```

#### Java setup
```bash
sudo su
java -version

# if no java
apt-get install -y openjdk-8-jre-headless
echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | tee -a /etc/profile
source /etc/profile
java -version
```

#### Nginx setup
```bash
apt-get install -y nginx
systemctl start nginx.service
systemctl enable nginx.service
```

#### Jitsi setup 
```bash
wget -qO - https://download.jitsi.org/jitsi-key.gpg.key | sudo apt-key add -
sudo sh -c "echo 'deb https://download.jitsi.org stable/' > /etc/apt/sources.list.d/jitsi-stable.list"

apt-get update -y
apt-get install apt-transport-https
apt-get install -y jitsi-meet

# type ubuntuvm.com
# choose "Generate a new self-signed certificate (You will later get a chance to obtain a Let's Encrypt certificate)" if you won’t paid SSL cert
# choose "I want to use my own certificate" if you already have paid/free cert

# if you choose "Generate a new self-signed certificate (You will later get a chance to obtain a Let's Encrypt certificate)"
sudo /usr/share/jitsi-meet/scripts/install-letsencrypt-cert.sh
# type admin@ubuntuvm.com
```

## Testing
Browse https://ubuntuvm.com 
Browse https://IP_ADDRESS
Remember for using HTTPS protocol

## Services of systemctl
jicofo
jitsi-videobridge2
prosody
jigasi
ufw