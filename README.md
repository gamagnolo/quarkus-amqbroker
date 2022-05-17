# Quarkus-AMQ Broker interaction via AMQP 1.0
This project allows, automatically and quickly through a Bash script, to run locally two Quarkus applications and an AMQ Broker interacting with each other via the AMQP 1.0 protocol.

## Table of contents
* [Architecture](#architecture)
* [Technologies and Prerequisites](#technologies-and-prerequisites)
* [Get it running](#get-it-running)
* [Reference](#reference)

## Architecture
There are two Quarkus applications communicating with a Red Hat AMQ Broker (based on Artemis).
The first application, the Producer, sends a quote request to an AMQP queue and consumes messages from the quote queue.
The second application, the Processor, receives the quote request and sends a quote back.
The Producer will let the user request some quotes over an HTTP endpoint. For each quote request, a random identifier is generated and returned to the user, to put the quote request on pending. At the same time the generated request id is sent over the quote-requests queue.
The Processor, in turn, will read from the quote-requests queue put a random price to the quote, and send it to a queue named quotes.
Lastly, the Producer will read the quotes and send them to the browser using server-sent events. The user will therefore see the quote price updated from pending to the received price in real-time.

![Architecture](https://github.com/gamagnolo/quarkus-amqbroker/blob/main/architecture.png?raw=true)
	
## Technologies and Prerequisites
The two Quarkus (version 2.9.0.Final) applications are executed as standalone jars.
The AMQ Broker(version 7.8-31.1652306076) is pulled from registry.redhat.io and executed as container through Podman.
Quarkus applications interact with AMQ Broker via AMQP 1.0 protocol through SmallRye Reactive Messaging dependency.

Prerequisites needed:

* JDK 11+ installed with JAVA_HOME configured appropriately
* Apache Maven 3.8.1+
* Podman
* Credential for registry.redhat.io

## Get it running
To run this project, follow this steps:
1. clone this repo locally
2. launch the startup_script.sh
3. connect to the AMQ Broker web console (http://localhost:8161) and to the (Quarkus) Producer application (http://localhost:8080/quotes.html)
4. produce messages and observe both the web application and the AMQ Broker console
5. terminate and cleanup all by launching the cleanup_script.sh

## Reference
[Quarkus AMQP guide](https://quarkus.io/guides/amqp)
