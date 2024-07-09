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

  # save service_id for later
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")

  # print selection to screen
  case $SERVICE_ID_SELECTED in
    1) echo -e "You have selected Hair Styling.\n" ;;
    2) echo -e "You have selected Nail Services.\n" ;;
    3) echo -e "You have selected Pedicure.\n" ;;
    *) MAIN_MENU "Please select a valid option.\n" ;;
  esac

  # request phone number
  echo -e "Please enter your phone number."
  read CUSTOMER_PHONE

  # check for phone number
  PHONE_NUMBER=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  echo $PHONE_NUMBER

  # if phone number does not exist
  if [[ -z $PHONE_NUMBER ]]
  then
    # request name
    echo -e "Please enter your name.\n"
    read CUSTOMER_NAME

    # insert customer name and phone number
    CUSTOMER_INSERT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

}

MAIN_MENU