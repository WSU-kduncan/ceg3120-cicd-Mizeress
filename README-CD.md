# Continuous Deployment

## Part 1 - Script Setup
### EC2 Instance Details:
- Amazon Linux AMI
- t2.medium
- 30 GB Volume
- Security Group:
    - Inbound:
        - SSH From Home
        - SSH From WSU
        - ICMP From Home
        - ICMP From WSU
        - HTTP 80 from anywhere
        - HTTP 8080 from anywhere
    - Justification:
        - Web server, we need to allow http
        - SSH and ICMP for my own interaction and testing
        - TODO Allow whatever request WebHooks need to come through


### Docker Setup
    - Install: `sudo dnf install docker`
    - Start Service: `sudo systemctl start docker.service`
    - Non Root Managing: `sudo usermod -aG docker ec2-user`
    - Test: `docker run hello-world`


### Testing on EC2 Instance
- `docker pull malliasm/portfolio:latest`
- `docker run -d --name portfolio -p 80:80 malliasm/portfolio:latest`
    - `-d` flag causes the container to run detatched. `-it` gives you an interactive terminal. Since this is automated, prod version should use `-d` flag. 
- `http://<ip>` Should serve the site.


### Scripting Container Application Refresh
Description
- Take arguments for image to pull and the name of the locally running contianer. Pull the image, stop and remove the current container, run the new container. 

Testing
- Pull an initial container, run it, and give it a name.
    - `docker pull malliasm/portfolio:latest`
    - `docker run -d --name portfolio -p 80:80 malliasm/portfolio:latest`
- Visit the site and ensure it is serving properly and looks as expected
- Call the script on another version of the container
    - `sudo DockerSwap -i malliasm/portfolio:1.0 -c portfolio`
- Check that the served content has updated to match the new version
- Verify that the old container is no longer present
    - `docker ps -a`

Link to Bash Script: [DockerSwap](deployment/DockerSwap.sh)


