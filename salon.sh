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

  # if not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[1-3]+$ ]]
  then
    MAIN_MENU "That is not a valid number."
  else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    echo -e "\nYou have selected a$SERVICE_NAME appointment.\nPlease enter your phone number:\n"
    read CUSTOMER_PHONE

    PHONE_NUMBER=$($PSQL "SELECT phone FROM customers where phone = '$CUSTOMER_PHONE'")

    # if phone number not found
    if [[ -z $PHONE_NUMBER ]]
    then
      echo -e "That phone number was not found, please enter your name.\n\n"
      read CUSTOMER_NAME

      # insert name and phone number into the customers table
      INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
      echo -e "\nYour info has been stored. You will be returned to the menu, please enter the same info again."

      # get customer_name
      NAME=$($PSQL "SELECT name FROM customers WHERE name = '$CUSTOMER_NAME'")
      echo $NAME

      MAIN_MENU
    else
      echo -e "\nPlease select a time for your appointment."
      read SERVICE_TIME

      # get customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

      # insert appointment information
      INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES('$CUSTOMER_ID', '$SERVICE_ID_SELECTED', '$SERVICE_TIME')")
      
      # end message
      echo -e "I have put you down for a$SERVICE_NAME at $SERVICE_TIME,$NAME."
    fi
  fi
}

MAIN_MENU