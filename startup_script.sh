#!/bin/bash
#########################################################################
# Startup script for Quarkus-AMQ Broker scenario
#########################################################################
# Author: Francesco Fabi
#########################################################################

# exit when any command fails
set -e

# Bold red
BRed='\033[1;31m'
# No color
NC='\033[0m'

#Producer PID
pidProducer=''
#Processor PID
pidProcessor=''
#AMQ Broker container ID
existingAmqBrokerContainerID=''

# Podman login
echo -e "${BRed}Insert registry.redhat.io credentials${NC}"
podman login registry.redhat.io
# Pull AMQ-Broker image
echo -e "${BRed}Pulling AMQ-Broker image${NC}"
podman pull registry.redhat.io/amq7/amq-broker:7.8-31.1652306076
# Start AMQ Broker container
echo -e "${BRed}Starting AMQ-Broker container${NC}"
existingAmqBrokerContainerID=$(podman ps -aq -f name=amqbroker7.8)
if [ -z "$existingAmqBrokerContainerID" ]
then
      echo "No previous AMQ Broker container existing. Creating new container..."
      existingAmqBrokerContainerID=$(podman run -d --name amqbroker7.8 -e AMQ_USER=admin -e AMQ_PASSWORD=admin -p8161:8161 -p5672:5672 registry.redhat.io/amq7/amq-broker:7.8-31.1652306076)
else
      echo "Restarting existing container with id $existingAmqBrokerContainerID..."
      podman restart "$existingAmqBrokerContainerID"
fi
# Build producer
echo -e "${BRed}Building Quarkus producer app${NC}"
mvn -f amqp-quickstart-producer clean package
# Build processor
echo -e "${BRed}Building Quarkus processor app${NC}"
mvn -f amqp-quickstart-processor clean package
# Start producer
echo -e "${BRed}Starting Quarkus producer app${NC}"
java -jar amqp-quickstart-producer/target/quarkus-app/quarkus-run.jar &
pidProducer=$!
echo "started Producer with pid: ${pidProducer}"
# Start processor
echo -e "${BRed}Starting Quarkus processor app${NC}"
java -jar amqp-quickstart-processor/target/quarkus-app/quarkus-run.jar &
pidProcessor=$!
echo "started Processor with pid: ${pidProcessor}"

echo -e "${BRed}AMQ BROKER web console: http://localhost:8161${NC}"
echo -e "${BRed}Quotes app frontend: http://localhost:8080/quotes.html${NC}"

printf "$pidProducer\n" > temp.file
printf "$pidProcessor\n" >> temp.file
printf "$existingAmqBrokerContainerID\n" >> temp.file
