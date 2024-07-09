#!/bin/bash

# Create PSQL variable used for queries
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Shop ~~~~~\n"

MAIN_MENU() {
  # print input on a new line
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # print list of services
  echo -e "1) Hair Styling\n2) Nail Services\n3) Pedicure"

  # appointment selection
  echo -e "\nSelect a service to schedule.\n"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) echo "You have selected Hair Styling.\n" ;;
    2) echo "You have selected Nail Services.\n" ;;
    3) echo "You have selected Pedicure.\n" ;;
    *) MAIN_MENU "Please select a valid option.\n" ;;
  esac
}

MAIN_MENU