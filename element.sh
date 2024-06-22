PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]];then 
    echo "Please provide an element as an argument."
  else 
  #get element id
  if [[ $1 == [0-9] ]];then
    ELEMENT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")  
  elif [[ ${#1}>=3 ]];then 
    ELEMENT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")  
  else
    ELEMENT_ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")  
  fi 
  #check if element_id is in db 
  if [[ -z $ELEMENT_ID ]];then 
    echo "I could not find that element in the database."
  else  
    #get properties 
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ELEMENT_ID")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ELEMENT_ID")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ELEMENT_ID")
    TYPE=$($PSQL "SELECT type FROM public.types WHERE type_id = $TYPE_ID")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELEMENT_ID")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$ELEMENT_ID'")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$ELEMENT_ID'")
    echo "The element with atomic number $ELEMENT_ID is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi 