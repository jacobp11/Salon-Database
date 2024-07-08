#!/bin/bash

# Create PSQL variable used for queries
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon Shop ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo -e "Would you like to schedule or cancel an appointment?\n"
  echo -e "1) Schedule an appointment\n2) Cancel an appointment\n3) Exit"
  read MAIN_MENU_SELECTION

  case $MAIN_MENU_SELECTION in
    1) APPOINTMENT_CREATION_MENU ;;
    2) APPOINTMENT_CANCELLATION_MENU ;;
    3) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

APPOINTMENT_CREATION_MENU() {
  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo -e "\nHere is a list of available services:\n"
  echo $AVAILABLE_SERVICES | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID $NAME"
  done

  # appointment selection
  echo -e "\nSelect a service to schedule.\n"
  read SERVICE_ID_SELECTED

  # if not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[1-3]+$ ]]
  then
    APPOINTMENT_CREATION_MENU "That is not a valid number."
  else
    echo success
  fi
}

APPOINTMENT_CANCELLATION_MENU() {
  echo ...
}

EXIT() {
  echo -e "\nThank you and goodbye."
}

MAIN_MENU