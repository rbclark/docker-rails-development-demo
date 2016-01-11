# Docker Rails Development Demo

This is a simple proof-of-concept showing an easy way to perform rails development locally using docker. This image is not pushed to DockerHub since it would not be useful, as you need to put the Dockerfile in a local directory on your machine in order to fully reap the benefits.

By using this Dockerfile, you are provided with a 2 way sync (provided by docker volumes) which allows you to make changes to your project in a directory on your local system and have them show up in your docker container. 

This container should **not** be used in production, as its sole purpose is making it easier to get up and running for development.

**Everything below here assumes that you have already installed Docker in the correct method for your system.**

## Building the image

In order to build the image for your rails application, you will need to run

    docker build -t yourname/reponame .

For example in my case the command I ran was 

    docker build -t rbclark/rails-dev .
    
This creates a new Docker image on your system which contains all of the current version of your gems used by the project.

## Running the image

At this point you have an image built with your gems in it. You can now quickly spin up a development environment by running

    docker run -d -v "your source directory here":/src/docker-rails-test-app -p 3000:3000 yourname/reponame
    
Where your source directory is the location that you ran docker build from. In my case I always run the command from the directory containing my source code and use the pwd command to get my current working directory, like so

    docker run -d -v `pwd`:/src/docker-rails-test-app -p 3000:3000 rbclark/rails-dev
    
## Running commands

Lets say you would like to still be able to run the rails commands in order to still have access to conveniences like rails generate. Fortunately this is still possible! Simply run

    docker ps
    
To get the CONTAINER ID or NAME, and then run 

    docker exec NAME rails (rest of desired command here)
    
For example

    docker exec high_hypatia rails generate controller welcome index
    
The same can be done for bundle or any other command you wish to run on the Docker container.

## Updating gems

You can add and remove gems as needed by modifying the Gemfile, however after you have done so, it is suggested that you rebuild your Docker image using the steps above. This is because the gems are built into the container and you will otherwise run into an issue where you have to bundle install each time you create a new development container.
