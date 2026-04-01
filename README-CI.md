# Github Actions

## Web Service Container
Pulls the httpd official container and exposes my personal portfolio website on port 80.

### Website
The index of the website is an about me page. Across the top of the site is a nav bar with links to Home, Projects, and Resume. The homepage is the aboutme section, projects contains a gallery style set of links to my personal projects, and the resume opens my resume pdf. 

### Dockerfile
Pull from the httpd base image and copy web-content folder to the default directory served by apache.
- [DockerFile](Dockerfile)

### Dockerhub
*Instructions to build and push container to dockerhub (including create PAT && recomended PAT scope*
- Build image: `docker build . -t <tagname>`
- PAT Token:
    - Navigate to dockerhub -> account settings -> Personal Access Tokens
    - Generate a token, in this case reccomended just read and write so you can push and pull the repo.
    - Copy and store the key in a secure location
    - Run `docker login -u <username>`
    - Enter PAT token at prompt
- Push to docker hub: 
    - Build with repo tag: `docker build . -t malliasm/portfolio`
    - Push: `docker push malliasm/portfolio`


*Link to Dockerhub repo*: https://hub.docker.com/repository/docker/malliasm/portfolio/general

## Github Actions 
- Configure GitHub Repository Secrets
- How to create a PAT for authentication:
    - *Note: Dockerhub's UI seems to have updated a bit since the previous section*
        - Go to settings > Personal Access Tokens
        - Select `Generate New Token`
        - Give it a descriptive name: `Github Docker Token and set permissions.
        - We want Github to be able to pull and make edits and push back. So we want Read Write permissions.
        - Navigate to your repo's setting under Security and Quality > Secrets and Variables > Actions > New Repository Secret
        - Make a secret for your username and token
- CI with GitHub Actions
    - Explanation of workflow trigger
    - Explanation of workflow steps
    - Explanation / highlight of values that need updated if used in a different repository
    - **Link** to workflow file: 
- Testing & Validating

## Semantic Versioning

## Project Decription & Diagram
