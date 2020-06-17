#!/bin/bash

#set -eoux pipefail
sudo -i
yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd.service

echo "WELCOME TO THE BJSS PLATFORM TEST " >> /var/www/html/index.html

#This is used install the ssm agent on the instances

sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
sudo systemctl start amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent.service

#Install AWSLOGS
sudo yum install awslogs -y
sudo systemctl start awslogsd
sudo systemctl enable  awslogsd.service

#This is used to install the Cloudwatch Agent
sudo yum install wget zip unzip stress -y
sudo yum install polkit* -y
sudo yum install epel-release -y && yum install collectd -y
sudo mkdir /tmp/cw-agent
cd /tmp/cw-agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/linux/amd64/latest/AmazonCloudWatchAgent.zip
unzip AmazonCloudWatchAgent.zip
sudo ./install.sh
rm *
cat >> /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << EOF
{
    "agent": {
       "metrics_collection_interval": 60,
       "region": "eu-west-2",
       "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
       "debug": false,
       "run_as_user": "root"
  },
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/var/log/syslog/ec2.log",
                        "log_group_name": "syslog",
                        "log_stream_name": "{instance_id}"
                    }
                ]
            }
        }
    },
    "metrics": {
            "namespace": "ExtendedMetrics",
            "append_dimensions": {
                    "AutoScalingGroupName": "${aws:AutoScalingGroupName}",
                    "ImageId": "${aws:ImageId}",
                    "InstanceId": "${aws:InstanceId}",
                    "InstanceType": "${aws:InstanceType}"
            }
    },
     "metrics": {
    "metrics_collected": {
      "collectd": {},
      "cpu": {
        "resources": [
          "*"
        ],
        "measurement": [
          {"name": "cpu_usage_idle", "rename": "CPU_USAGE_IDLE", "unit": "Percent"},
          {"name": "cpu_usage_nice", "unit": "Percent"},
          "cpu_usage_guest"
        ],
        "totalcpu": false,
        "metrics_collection_interval": 10,
        "append_dimensions": {
          "test": "test1",
          "date": "2017-10-01"
        }
      },
      "netstat": {
        "measurement": [
          "tcp_established",
          "tcp_syn_sent",
          "tcp_close"
        ],
        "metrics_collection_interval": 60
      },
       "disk": {
        "measurement": [
          "used_percent"
        ],
        "resources": [
          "*"
        ],
        "drop_device": true
      },
      "processes": {
        "measurement": [
          "running",
          "sleeping",
          "dead"
        ]
      }
    },
    "append_dimensions": {
      "ImageId": "${aws:ImageId}",
      "InstanceId": "${aws:InstanceId}",
      "InstanceType": "${aws:InstanceType}",
      "AutoScalingGroupName": "${aws:AutoScalingGroupName}"
    },
    "aggregation_dimensions" : [["AutoScalingGroupName"], ["InstanceId", "InstanceType"],[]]
  }
}
EOF
/opt/aws/amazon-cloudwatch-agent/bin/config-translator \
    --input /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json\
    --output /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.toml

sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
#systemctl start amazon-cloudwatch-agent
#systemctl enable amazon-cloudwatch-agent

#installing of firefox dependencies
wget https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.0.tar.xz
tar xvf gtk+-3.24.3.tar.xz && cd gtk+-3.24.3 && ./configure

#glib
wget https://download.gnome.org/sources/glib/2.60/glib-2.60.0.tar.xz
tar xvf glib-2.60.0.tar.xz && cd glib-2.60.0

#pango
wget https://download.gnome.org/sources/pango/1.42/pango-1.42.0.tar.xz
tar xvf pango-1.42.0.tar.xz && cd pango-1.42.0 && ./configure

#gdk
wget https://download.gnome.org/sources/gdk-pixbuf/2.38/gdk-pixbuf-2.38.0.tar.xz
tar xvf gdk-pixbuf-2.38.0.tar.xz

#atk
wget https://download.gnome.org/sources/atk/2.26/atk-2.26.0.tar.xz
tar xvf atk-2.26.0.tar.xz && cd atk-2.26.0 && ./configure

#gob
wget https://download.gnome.org/sources/gobject-introspection/1.60/gobject-introspection-1.60.2.tar.xz
tar xvf gobject-introspection-1.60.2.tar.xz && cd gobject-introspection-1.60.2 && ./configure


#Enable the epel-repo

sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum-config-manager --enable epel
yum groupinstall "Development Tools"
yum clean all
#installing of firefox dependencies
wget https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.0.tar.xz
tar xvf gtk+-3.24.3.tar.xz && cd gtk+-3.24.3 && ./configure
#glib
wget https://download.gnome.org/sources/glib/2.60/glib-2.60.0.tar.xz
tar xvf glib-2.60.0.tar.xz && cd glib-2.60.0
#pango
wget https://download.gnome.org/sources/pango/1.42/pango-1.42.0.tar.xz
tar xvf pango-1.42.0.tar.xz && cd pango-1.42.0 && ./configure
#gdk
wget https://download.gnome.org/sources/gdk-pixbuf/2.38/gdk-pixbuf-2.38.0.tar.xz
tar xvf gdk-pixbuf-2.38.0.tar.xz
#atk
wget https://download.gnome.org/sources/atk/2.26/atk-2.26.0.tar.xz
tar xvf atk-2.26.0.tar.xz && cd atk-2.26.0 && ./configure
#gob
wget https://download.gnome.org/sources/gobject-introspection/1.60/gobject-introspection-1.60.2.tar.xz
tar xvf gobject-introspection-1.60.2.tar.xz && cd gobject-introspection-1.60.2 && ./configure

#Install Firefox
cd /usr/local
wget http://ftp.mozilla.org/pub/firefox/releases/76.0/linux-x86_64/en-US/firefox-76.0.tar.bz2
tar xvjf firefox-76.0.tar.bz2
sudo ln -s /usr/local/firefox/firefox /usr/bin/firefox
firefox &

#Install chrome driver
cd /tmp/
wget https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver

#Install Google Chrome
curl https://intoli.com/install-google-chrome.sh | bash
mv /usr/bin/google-chrome-stable /usr/bin/google-chrome
google-chrome --no-sandbox
