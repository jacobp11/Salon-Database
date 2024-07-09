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

  # save service_id and service name for later
  SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")

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

  # if phone number does not exist
  if [[ -z $PHONE_NUMBER ]]
  then
    # request name
    echo -e "Please enter your name.\n"
    read CUSTOMER_NAME

    # insert customer name and phone number
    CUSTOMER_INSERT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi

  # request service time
  echo -e "Please enter a time for your appointment.\n"
  read SERVICE_TIME

  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  
  # insert appointment
  APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID', '$SERVICE_TIME')")

  # get customer name
  NAME=$($PSQL "SELECT name FROM customers WHERE customer_id = '$CUSTOMER_ID'")
  
  # end message
  echo -e "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $NAME." | sed 's/  / /g'
}

MAIN_MENU