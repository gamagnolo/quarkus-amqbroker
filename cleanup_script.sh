#!/bin/bash
#########################################################################
# Cleanup script for Quarkus-AMQ Broker scenario
#########################################################################
# Author: Francesco Fabi
#########################################################################

# exit when any command fails
set -e

# Bold red
BRed='\033[1;31m'
# No color
NC='\033[0m'

echo -e "${BRed}Removing Producer microservice...${NC}"
kill -9 $(cat temp.file | head -1 | tail -1)

echo -e "${BRed}Removing Processor microservice...${NC}"
kill -9 $(cat temp.file | head -2 | tail -1) 

echo -e "${BRed}Removing AMQ Broker...${NC}"
podman stop $(cat temp.file | head -3 | tail -1)
podman rm $(cat temp.file | head -3 | tail -1)

rm temp.file
