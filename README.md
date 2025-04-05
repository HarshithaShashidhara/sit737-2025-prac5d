Task: Building and Running a Docker Image on Google Cloud's Artifact Registry

Objective:
Building a Docker image locally, pushing it to the Google Cloud Artifact Registry, and successfully executing it while resolving any problems that arise are the objectives of this work. 

Installing and authenticating the Google Cloud SDK is a prerequisite. 
Docker has been set up and installed. 
A Google Cloud project that has the required authorizations to utilize Docker, Artifact Registry, and Google Cloud services. 
An image-building Dockerfile. 

Step 1: Authenticate to Google Cloud
1. Start by making sure your Google Cloud account is verified.
   Open the terminal and run:
     gcloud auth login
   A browser window will open when you type in the gcloud auth login. Use your Google Cloud account to log in.
2. Check the active account and project:
   gcloud auth list
   gcloud config get-value project
Step 2: Establish a repository for the Artifact Registry:
Create a Docker repository in Google Cloud's Artifact Registry by navigating to your project directory.
   gcloud artifacts repositories create my-docker-repo      --repository-format=docker      --location=australia-southeast1      --description="Docker repo for SIT737 project"
2. Authenticate Docker to Google Cloud Artifact Registry:
   Make sure Docker is set up to use your Google Cloud login information.
   gcloud auth configure-docker australia-southeast1-docker.pkg.dev
 Step 3: Build the Docker Image
1. Navigate to the project directory where the 'Dockerfile' is placed. 
   docker build -t myapp2:v1 .
 Step 4: Tag and Push the Image to Artifact Registry
1. Tag the image for Artifact Registry. 
   docker tag myapp2:v1 australia-southeast1-docker.pkg.dev/sit737-25t1-shashidhar-2bd7de4/my-docker-repo/myapp2:v1
2. Push the image to Artifact Registry: 
   docker push australia-southeast1-docker.pkg.dev/sit737-25t1-shashidhar-2bd7de4/my-docker-repo/myapp2:v1

Step 5: Run the Docker Image Locally
1. Run the  image as a container by below command:
 docker run -d -p 8080:8080 --name myapp2-container australia-southeast1-docker.pkg.dev/sit737-25t1-shashidhar-2bd7de4/my-docker-repo/myapp2:v1

2. Ensure the container is running by running below command: 
   docker ps

Step 6: Access the Application
To check if the program is functioning correctly, open a web browser and navigate to 'http://localhost:3000'.
Issue Encountered:

1. failed to authorize: failed to fetch oauth token` error: This error occurred because Docker was unable to obtain the necessary authentication tokens for pushing the image. To fix it, make sure you have correctly authenticated Docker using `gcloud auth configure-docker` and that your Google Cloud account has enough permissions, including `roles/storage.objectAdmin`.

 2. `tag does not exist` error: This problem occurred because the Docker image tag was not set correctly before pushing the image. To fix it, make sure the tag is defined as indicated in the `docker tag` command.

 3.Conflict. The container name "/myapp2-container" is already in use: This error occurred because the container name `myapp2-container` was already in use.
 Solution: Stop and remove the existing container before starting a new one using:
     docker stop myapp2-container
     docker rm myapp2-container
4.Authentication Issues
Make that the `gcloud auth configure-docker` command was executed correctly if the push fails because of authorization problems.Make sure your Google Cloud project account has the required rights (`roles/storage.objectAdmin`). 

Push Errors: When pushing an image to the Artifact Registry, make sure the image tag and repository name are right. Verify again that the repository is present in the appropriate project and location. 

In conclusion 
You should be able to create a Docker image locally, push it to the Google Cloud Artifact Registry, and use it as a container by following these steps. Container name conflicts, Docker settings, and authentication were the main problems encountered during this process. By checking the permissions, making sure the tags are correct, and managing container conflicts, they may be readily fixed
