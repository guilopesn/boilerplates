#!/bin/bash

set -em

chmod 400 /var/lib/rabbitmq/.erlang.cookie

HOSTNAME=`env hostname`

echo "Starting RabbitMQ Server For host: " $HOSTNAME

if [ -z "$RABBITMQ_CLUSTER_MASTER_HOST" ]; then
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server&
    
    sleep 5
    
    rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit\@$HOSTNAME.pid
else
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server&
    
    sleep 5
    
    rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit\@$HOSTNAME.pid
    
    rabbitmqctl stop_app

    rabbitmqctl join_cluster rabbit@$RABBITMQ_CLUSTER_MASTER_HOST
    
    rabbitmqctl start_app
fi

fg