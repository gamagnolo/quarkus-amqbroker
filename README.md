# Quarkus/AMQ Broker interaction via AMQP 1.0
This project allows, automatically and quickly through a Bash script, to run locally two Quarkus applications and an AMQ Broker interacting with each other via the AMQP 1.0 protocol.

## Table of contents
* [Architecture](#architecture)
* [Technologies and Prerequisites](#technologies-and-prerequisites)
* [Launch](#launch)
* [Reference](#reference)

## Architecture
This project is simple Lorem ipsum dolor generator.
![Architecture](https://github.com/gamagnolo/quarkus-amqbroker/blob/main/architecture.png?raw=true)
	
## Technologies and Prerequisites
Project is created with
SmallRye Reactive Messaging to interact with AMQP 1.0.
	
## Launch
To run this project, follow this steps:
1. clone this repo locally
2. launch the startup_script.sh
3. connect to the AMQ Broker web console (http://localhost:8161) and to the (Quarkus) Producer application (http://localhost:8080/quotes.html)
4. produce messages and observe both the web application and the AMQ Broker console
5. terminate and cleanup all by launching the cleanup_script.sh

## Reference
[Quarkus AMQP guide](https://quarkus.io/guides/amqp)
