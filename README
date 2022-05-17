mvn -f amqp-quickstart-processor clean package
mvn -f amqp-quickstart-producer clean package
java -jar amqp-quickstart-producer/target/quarkus-app/quarkus-run.jar
java -jar amqp-quickstart-processor/target/quarkus-app/quarkus-run.jar
podman login
podman pull registry.redhat.io/amq7/amq-broker:7.8-31.1652306076
podman run --name amqbroker7.8 -e AMQ_USER=admin -e AMQ_PASSWORD=admin -p8161:8161 -p5672:5672 registry.redhat.io/amq7/amq-broker:7.8-31.1652306076
accedo a quotes.html (localhost:8080/quotes.html)
accedo a broker console (localhost:8161)