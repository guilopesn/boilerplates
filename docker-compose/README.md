<h1 align="center">Docker Compose Manifests</h1>

<p align="center">
    A useful collection of docker compose manifests
</p>

## Manifests

1. PostgreSQL
   1.1. [Standalone](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/postgresql)
   1.2. [Cluster](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/postgresql-cluster)
2. RabbitMQ
   2.1. [Standalone](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/rabbitmq)
   2.2. [Cluster](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/rabbitmq-cluster)
3. Redis
   3.1. [Standalone](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/redis)
   3.2. [Cluster](https://github.com/guilopesn/boilerplates/blob/master/docker-compose/redis-cluster)

## How to use

```bash
    cd ${MANIFEST}

    docker compose up -d
```
