# CI/CD Docker Web Service
This project contains two subcomponents:
- CI: Contains the Continuous Integration Pipeline utilizing github actions to build a docker image whenever a tag is pushed in the form of `v*.*.*`. Pushes three tags to docker - `<maj>.<min>`, `<maj>`, and `latest`.
    - [README-CI.md](README-CI.md)
- CD: Contains the Continous Deployment Pipeling. On push to Docker, a docker webhook triggers and hits an endpoint handled by Adnanh's webhooks. If the request is valid, it calls a script to redeploy the image from the latest tag. 
    - [README-CD.md](README-CD.md)