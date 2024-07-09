#!/bin/bash

# Create PSQL variable used for queries
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Shop ~~~~~\n"

MAIN_MENU() {
  
  # print list of services
  echo -e "1) Hair Styling\n2) Nail Services\n3) Pedicure"

  # appointment selection
  echo -e "\nSelect a service to schedule.\n"
  read SERVICE_ID_SELECTED
}

MAIN_MENU