# Experiment 4: Application Containerization Using Docker

## Aim

To create a static HTML/CSS web application, containerize it using
Docker and Apache Tomcat, run it in a container, access it through a web
browser, and transfer the Docker image through Docker Hub.

## Requirements

-   Windows 10/11
-   Docker Desktop installed and running
-   PowerShell, Command Prompt, or Docker Desktop terminal
-   VS Code or Notepad
-   Web browser
-   Docker Hub account

------------------------------------------------------------------------

## Step 1: Create the Project Folder

Open PowerShell or Command Prompt and execute:

``` powershell
mkdir C:\tomcat-static-app
```

This creates the main project folder.

## Step 2: Create the `webapp` Folder

Move into the project folder and create a folder named `webapp`:

``` powershell
cd C:\tomcat-static-app
mkdir webapp
```

The `webapp` folder will contain the HTML and CSS files.

## Step 3: Create `index.html`

Inside `C:\tomcat-static-app\webapp`, create a file named `index.html`
and add:

``` html
<!DOCTYPE html>
<html>
<head>
    <title>Docker Tomcat Application</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Welcome to Docker!</h1>
    <h2>Apache Tomcat Static Web Application</h2>
    <p>This webpage is running inside an Apache Tomcat Docker container.</p>
</body>
</html>
```

## Step 4: Create `style.css`

In the same `webapp` folder, create `style.css` and add:

``` css
body {
    font-family: Arial, sans-serif;
    text-align: center;
    margin-top: 100px;
}

h1 {
    color: blue;
}

h2 {
    color: green;
}

p {
    font-size: 18px;
}
```

## Step 5: Create the Dockerfile

In the main project folder `C:\tomcat-static-app` (not inside `webapp`),
create a file named exactly `Dockerfile`, with no `.txt` extension.

Add:

``` dockerfile
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/ROOT/*

COPY webapp/ /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
```

**Dockerfile instructions:** - `FROM` selects the Apache Tomcat 10.1
image with Java 17. - `RUN` removes the default ROOT web application
files. - `COPY` copies the local `webapp` files into Tomcat's ROOT
application directory. - `EXPOSE` documents that Tomcat listens on
container port `8080`. - `CMD` starts the Tomcat server when the
container starts.

## Step 6: Check the Project Structure

Run this command from `C:\tomcat-static-app`:

``` powershell
dir
```

The folder structure should be:

``` text
C:\tomcat-static-app
│
├── Dockerfile
└── webapp
    ├── index.html
    └── style.css
```

## Step 7: Build the Docker Image

Make sure the terminal is in the main project folder:

``` powershell
cd C:\tomcat-static-app
```

Build the image:

``` bash
docker build -t tomcat-static-app .
```

The dot (`.`) specifies the current folder as the Docker build context.
Wait for the build to complete.

Check that the image was created:

``` bash
docker images
```

Look for `tomcat-static-app` in the image list.

## Step 8: Run the Docker Container

Create and start a container:

``` bash
docker run -d -p 8083:8080 --name tomcat-app4 tomcat-static-app
```

Meaning: - `-d` runs the container in the background. - `-p 8083:8080`
maps host port `8083` to container port `8080`. - `--name tomcat-app4`
gives the container the name `tomcat-app4`. - `tomcat-static-app` is the
image used to create the container.

## Step 9: Test the Web Application

Open Chrome or Edge and visit:

``` text
http://localhost:8083
```

The page should display: - **Welcome to Docker!** - **Apache Tomcat
Static Web Application** - The paragraph stating that the webpage is
running inside an Apache Tomcat Docker container.

## Step 10: Inspect the Running Container and Logs

List running containers:

``` bash
docker ps
```

View the container logs:

``` bash
docker logs tomcat-app4
```

`docker ps` displays running containers and their port mappings.
`docker logs` displays Tomcat startup and runtime messages.

## Step 11: Stop and Start the Container

To stop the container:

``` bash
docker stop tomcat-app4
```

To start the same container again:

``` bash
docker start tomcat-app4
```

These commands stop and restart the existing container. They do not
rebuild the image.

## Step 12: Tag the Image for Docker Hub

Use the Docker Hub username shown in the practical notes:

``` bash
docker tag tomcat-static-app:latest dradityacr/tomcat-static-app:1.0
```

This adds a Docker Hub-compatible name and tag to the local image.

## Step 13: Log In to Docker Hub

Run:

``` bash
docker login
```

Enter your Docker Hub username and password or access token when
prompted.

## Step 14: Push the Image to Docker Hub

Run:

``` bash
docker push dradityacr/tomcat-static-app:1.0
```

This uploads the tagged image to the corresponding Docker Hub
repository.

## Step 15: Pull the Image on Another Computer

On the second computer: 1. Install Docker Desktop and make sure it is
running. 2. Open a terminal. 3. Log in if the repository is private:

``` bash
docker login
```

4.  Pull the image:

``` bash
docker pull rashmi2122/tomcat-static-app:1.0
```

5.  Confirm that the image is available:

``` bash
docker images
```

## Step 16: Run the Pulled Image on the Second Computer

Run:

``` bash
docker run -d -p 8083:8080 --name tomcat-app4 rashmi2122/tomcat-static-app:1.0
```

Open the browser on the second computer and visit:

``` text
http://localhost:8083
```

The same web application should be displayed.

------------------------------------------------------------------------

## Complete Command List

Run these commands in order, changing the Docker Hub username before
tagging, pushing, and pulling:

``` powershell
mkdir C:\tomcat-static-app
cd C:\tomcat-static-app
mkdir webapp
```

Create `webapp\index.html`, `webapp\style.css`, and the `Dockerfile` as
shown above. Then run:

``` bash
docker build -t tomcat-static-app .
docker images
docker run -d -p 8083:8080 --name tomcat-app4 tomcat-static-app
docker ps
docker logs tomcat-app4
docker stop tomcat-app4
docker start tomcat-app4
docker tag tomcat-static-app:latest dradityacr/tomcat-static-app:1.0
docker login
docker push dradityacr/tomcat-static-app:1.0
```

On the second computer:

``` bash
docker login
docker pull rashmi2122/tomcat-static-app:1.0
docker images
docker run -d -p 8083:8080 --name tomcat-app4 rashmi2122/tomcat-static-app:1.0
```

## Common Errors and Solutions

  -----------------------------------------------------------------------
  Error                               What to check
  ----------------------------------- -----------------------------------
  `docker` command not found          Install Docker Desktop, restart the
                                      terminal, and try again.

  Cannot connect to Docker daemon     Start Docker Desktop and wait until
                                      its engine is running.

  Port is already allocated           Use another free host port, for
                                      example `-p 8084:8080`, and browse
                                      to `http://localhost:8084`.

  Dockerfile not found                Move to `C:\tomcat-static-app` and
                                      confirm the file is named
                                      `Dockerfile`, not `Dockerfile.txt`.

  Container exits                     Run `docker ps -a` and
                                      `docker logs tomcat-app4`.

  Push denied                         Check that you are logged in and
                                      that the image tag starts with your
                                      Docker Hub username.

  Pull access denied                  Check the repository name, tag,
                                      visibility, and access permissions.
  -----------------------------------------------------------------------

## Result

The static HTML/CSS application was containerized using Docker and
Apache Tomcat. A Docker image was built, a container was started, and
the application was accessed through `http://localhost:8083`. The image
was tagged and pushed to Docker Hub, then pulled and run on another
computer.

## Important Notes

-   Use the same Docker Hub username and repository name consistently
    for `docker tag`, `docker push`, and `docker pull`. The username in
    the command must be your own account or an account whose repository
    you can access.
-   If `tomcat-app4` already exists, Docker will not create another
    container with that same name. Remove the old container first if you
    intend to recreate it:

``` bash
docker stop tomcat-app4
docker rm tomcat-app4
```

-   If port `8083` is already in use, choose a different host port such
    as `8084`; keep the container port as `8080`.
