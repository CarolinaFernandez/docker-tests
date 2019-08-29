# Docker-compose: health checks and dependencies

This folder contains examples on how to apply the `healthcheck` directive to determine when the application running in a container is deemed to be healthy. It also provides examples on how to to introduce dependencies in the startup order with `depends_on` and its combination with the `command` directive, which can be set to wait for a specific status before starting the logic into the dependant container.

All of the above runs on Docker compose, version 3.

## Introduction

To picture the idea behind this example, two containers are defined:

* **api**: the service that runs the API which provides tokens
* **ui**: the user interface, depending on the tokens provided by the API

### Premises

For the health checks, it can be assumed that each container should be marked as "healthy" when its service is ready to use.
As per the dependency, a service can only get started is the previous service is ready: here, the UI needs a token and thus it will wait until the API is serving the tokens.

*Note*: artificial delays are introduced both to delay the start of the API application and to extend the lifetime of the UI service.

### Structure

There are two docker-compose files:

* **docker-compose.yml**: Compose file with simple commands
* **docker-compose.scripts.yml**: Compose file wrapping the commands above into scripts (which are exposed to the container as "volumes")

The structure in the file system should be as follows:

```
.
├── compose_deploy.sh
├── compose_undeploy.sh
├── docker-compose.scripts.yml
├── docker-compose.yml
├── files
│   ├── docker
│   │   ├── api
│   │   │   └── Dockerfile
│   │   └── ui
│   │       └── Dockerfile
│   └── src
│       ├── api
│       │   ├── api.py
│       │   └── __init__.py
│       └── ui
│           └── ui.sh
├── README
├── test_compose.sh
└── wait-for-rest.sh
```

## Deployment

Based on the two available Compose files, there are two ways to deploy the stack of containers:

```
# Option A
./test_compose.sh docker-compose.yml
# Option B
./test_compose.sh docker-compose.scripts.yml
```

# Testing

Once any of the commands defined above are executed, after few seconds you will see the following containers:

```
$ docker ps -a

CONTAINER ID        IMAGE                          COMMAND                  CREATED              STATUS                        PORTS
            NAMES
191755d6021e        test_compose_healthcheck_ui    "/bin/sh -c '(/bin/b…"   About a minute ago   Up About a minute (healthy)
            ui
43b770287acd        test_compose_healthcheck_api   "/usr/bin/dumb-init …"   About a minute ago   Up About a minute (healthy)   127.0.0.1:5000-
>5000/tcp   api
```

Once the "ui" container is marked as healthy, you can get inside it and look for the file storing the retrieved token:

```
$ docker exec -it ui /bin/sh
/ # cat tokenfile
Token retrieved: 69940029-2a0e-4b18-93c4-3e736c71e362
```
