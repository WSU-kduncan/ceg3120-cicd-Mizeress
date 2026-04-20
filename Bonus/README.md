# Load Balancer CD

## Project Overview
Load balance between three Web Server instances. Enable continuous deployment through Github Actions, Docker Webhook, & Adnanh's Webhook. 

## Diagram
![ProjectDiagram](/Bonus/LB-CD_Diagram.drawio.png)

## Setup Notes: 
- Add PK to proxy for web servers as Key.pem in `/home/ec2-user/.ssh`
- Run the following to add the webservers to known hosts. Without this update scripts will fail:  
    ```
    ssh-keyscan webserv1 >> ~/.ssh/known_hosts
    ssh-keyscan webserv2 >> ~/.ssh/known_hosts
    ssh-keyscan webserv3 >> ~/.ssh/known_hosts
    ```
- Send webhook to proxy URL

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

### Pipeline Explanation
The project functions as follows:
- A Git Tag is pushed to github with the format `v.*.*.*`
- A github action builds the web content from the repo and pushes three tags to dockerhub, maj, maj.min, and latest.
- Docker triggers a webhook and sends to proxy instance
- Webhook recieves webhook and verifies the payload
- Webhook calls updateServers
- updateServers uses SSH on the three instances to trigger the DockerSwap command to run
- WebServers pull the new latest image from docker, delete the website process, and starts a new process.
