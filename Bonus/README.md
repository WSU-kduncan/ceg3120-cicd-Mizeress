# Load Balancer CD

## Project Overview
Load balance between three Web Server instances. Enable continuous deployment through Github Actions, Docker Webhook, & Ananh's Webhook. 

## Diagram
![ProjectDiagram](/Bonus/LB-CD_Diagram.draw.io.png)

## Setup Notes: 
- Add PK to proxy for web servers as Key.pem in `/home/ec2-user/.ssh`
- Run the following to add the webservers to known hosts. Without this update scripts will fail:  
    ```
    ssh-keyscan webserv1 >> ~/.ssh/known_hosts
    ssh-keyscan webserv2 >> ~/.ssh/known_hosts
    ssh-keyscan webserv3 >> ~/.ssh/known_hosts
    ```
- Send webhook to proxy URL
- In real world solution should use different keys for servers so proxy PK key isn't on proxy

## Cloud Formation
### Resources
- Internet: Internet Gateway, NAT Gateway, EIP for each, & Route Tables + Routes
- Public Subnet, Private Subnet
- Instances:
    - Proxy (public)
    - 3 Web Servers (private)
- Proxy Security Group, Web Server Security Group

### Security

Public: 
- SSH within VPC
- SSH from WSU + Home
- HTTP From VPC
- HTTP from anywhere
- ICMP Within VPC
- ICMP from Home
- Webhook

Private:
- SSH in VPC
- HTTP within VPC

### Instances
Proxy Server:
- Amazon Linux, t2.micro
- Startup Script:
    - Install HaProxy
    - Update `/etc/hosts` with webserver aliases
    - Get HaProxy config
    - Get SSH Config
    - Start proxying
    - Download & Setup webhook
    - Get Update Servers Script
    - Get `hooks.json` configuration
    - Get `webhook.service` file
    - Start listening

Web Servers
- AMI: Amazon Linux, t2.micro
- Startup Script: 
    - Install and start Docker
    - Pull and start the website image
    - Get the `DockerSwap` script
    - Enable nonsudo control of Docker

