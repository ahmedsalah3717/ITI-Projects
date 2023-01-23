#!/bin/bash
############################# DBMS SELECTION #############################
#Where DO YOU Want To Create Your DBMS Folder
echo "Do you want to create a new DBMS folder, enter yes then!"
echo "Do you want to enter a previously created DBMS, enter go then!"
read answer
if [[ $answer == yes ]];then
 
 echo "What do you want to call the DBMS ?
 Note: Care that the DBMS will be created in the home directory! "
 #entering DBMS name
 read DBMSname 
 cd $HOME
 #making the name unique to fall into any naming errors
 dbmsname="$DBMSname-$(date +%T)"
 #giving dir permissions to avoid any errors in accessing , Also if there is any error while creating the folder the error is saved in a folder 
mkdir -m 755 $HOME/$dbmsname 2>> error-$(date +%F).txt

 #locate to the created folder location for further actions 
 cd $HOME/$dbmsname

 #creating the database and giving the user a message confirming the creation 
echo "creating database $dbmsname just a sec.. "
sleep 2
echo "Loading...... BEEP BOOP 🤖"
 sleep 4
 clear
 echo  "yay! $dbmsname was created! "
 sleep 2
 echo "Welcome To DBMS 😃 "
 sleep 2

#If Answer = go then connect to a previously created DBMS
elif [[ $answer == go ]];then
clear
ls -F $HOME | grep "/$"
read -p "enter the DMBS name you want to access: " dbms_location
cd $HOME/$dbms_location
clear
echo "Welcome Back to $dbms_location!!"

 #if the user enters any other input the program quits 
else 
echo "wrong choice pal!"
 exit
fi
  

############################# DDL Operations Menu #############################
 #Operations like create, List, Connect, Drop.
 #Here we will create a menu for the user to choose from the DDl operations the user have to enter options from 1 to 4 to choose from the options given
function CRUDMENU {
   echo " Welcome to the CRUD MENU (Create, Read, Upadte, Delete) "
    echo " Enter an option from 1 to 4 to chose an operation!"
   # echo " If you want to exit chose 5!"
      #we give the user 3 seconds to read the previous messages

  sleep 3
      #Menu cases
  echo "1. Create Database"
  echo "--------------------------------"
  echo "2. List Databases"
  echo "--------------------------------"
  echo "3. Connect To Databases"
  echo "--------------------------------"
  echo "4. Drop Database"
  echo "--------------------------------"
   echo "5. Exit"
  echo "--------------------------------"

  echo  "Choose Action? "
  read menuchoice
  case $menuchoice in
      #when the user enters a number from 1:4 there will be a function matching every digit
    1)  createDatabase ;;
    2)  ls -d */ ; sleep 3 ; CRUDMENU ;;
    3)  connect ;;
    4)  dropping ;;
    5) exit ;;
    *) echo " Wrong Choice " ; CRUDMENU;
  esac
}

#Database Creation
function createDatabase {
      #navigating to the right location
   if [[ $answer == yes ]];then
   cd $HOME/$dbmsname
   elif [[ $answer == go ]];then
cd $HOME/$dbms_location
fi
    #showing the user the content of the folder he's in so he can be assured to continue his actions
  echo "Hey, These are the databases inside! Are you sure you want to proceed?"
  ls -d */
  echo  "Enter Database Name you want to add: "
  read database_name_creation

      #choosing a unique name for the database 
  mkdir "$database_name_creation-$(date +%F)" 2>> error-$(date +%F).txt
 #if the return of the $? is 0 then that means that the command ran successfully with no errors 
 #However if there are any errors while creating the database the error will be redirected to the error-(day created).txt file
  if [[ $? == 0 ]]
  then
    echo "DataBase was Created!"
    ls -d */
  else
    echo "error creating the database. Check the error file!"
  fi
  CRUDMENU
}

 #Dropping a Database function
function dropping {
     #the answer the user entered at the start of the progaram is yes
    echo "These are the databases located in this DBMS choose the one you want to drop!"
  if [[ $answer == yes ]];then
   cd $HOME/$dbmsname/
   ls -d */
   #the answer the user entered at the start of the progaram is go
   elif [[ $answer == go ]];then
   cd $HOME/$dbms_location/
   ls -d */

   fi

  #entering the database name you want to drop or delete
  echo "Enter the Database name you want to drop: "
  read dropdb_name
  rm -r $dropdb_name 2>> error-$(date +%F).txt
  if [[ $? == 0 ]]; then
    echo "Data base was dropped Successfully!"
  else
    echo "You entered a wrong database name! Try Again!"
  fi
  CRUDMENU
}
 #Connecting to an already created database and applying DML operations by choosing an operation from a table 
function connect {
  #answer == yes creating DMBS case
  if [[ $answer == yes ]];then
   cd $HOME/$dbmsname/
   ls -d */
  #answer == go accessing DMBS case

   elif [[ $answer == go ]];then
   cd $HOME/$dbms_location/
   ls -d */
   fi
    #the user will enter the name of data base he wants to access then we will cd to the directory given by user
    echo "Enter The Database Name You Want To Connect To : "
    #get the name of database you want to cd to by user
  read dbName_connect
  cd $dbName_connect
  #if the command was excuted
  if [[ $? == 0 ]]; then
    echo "Database $dbName_connect was Successfully Selected"
    DMLMENU
  else
    echo "Database $dbName_connect wasn't found"
    CRUDMENU
  fi
}

###### DML Operations menu 
function DMLMENU {
  echo  "Chose your DML operation from table below!"
  echo "1.Create Table"
  echo "--------------------------------"
  echo "2.List Tables"
  echo "--------------------------------"
  echo "3. Drop Table"
  echo "--------------------------------"
  echo "4.Insert into Table"
  echo "--------------------------------"
  echo "5.Select From Table"
  echo "--------------------------------"
  echo "6.Delete From Table"
  echo "--------------------------------"
  echo "7.Update Table"
  echo "--------------------------------"
  echo "8. Back To Main Menu"
  echo "--------------------------------"
  echo "9. Exit"
  echo "--------------------------------"
  read DMLch
  case $DMLch in
    1)  createTable ;;
    2)  echo "These are the list of tables inside!" ; ls  ; sleep 3 ; DMLMENU ;;
    3)  dropTable;;
    4)  insert;;
    5)  selectMenu ;;
    6)  deleteFromTable;;
    7)  updateTable;;
    8) clear; cd $HOME 2>> error-$(date +%F).txt ; CRUDMENU ;;
    9) exit ;;
    *) echo " Wrong Choice " ; DMLMENU;
  esac

}
#case number 1 : Creating a Table in the chosen database
function createTable {
  echo -e "Enter Table Name you want to add!"
  read table_name

  #checking if there is already table with the same name
  if [[ -f $table_name ]]; then
    echo "This table already exists in the database! Please try another name"
    DMLMENU
  fi

  #creating a table but asking the user of the number of columns he wants to add first 
  echo -e " Enter the number of columns in the table! "
  read columns_number
  rseperator="\n"
  counter=1
  seperator="|"
  primary_key=""
  #Metadata like this field|type|key
  labels_types_keys="Field"$seperator"Type"$seperator"key"
  #entering columns as long as the counter is less than the column number
  while [ $counter -le $columns_number ]
  do
    echo  "Specify name for column number: $counter:"
    read column_name
  #entering column name for meta data file
    echo  "choose the type of column $column_name: "
    select type in "integer" "str"
    do
      case $type in
        integer ) Column_Type="integer";break;;
        str ) Column_Type="str";break;;
        * ) echo "Wrong Choice" ;;
      esac
    done
    #adding a primary key
    if [[ $primary_key == "" ]]; then
      echo -e "Do you want to make this a primary key ? "
      select type in "yes" "no"
      do
        case $type in
          yes ) primary_key="PK";
          labels_types_keys+=$rseperator$column_name$seperator$Column_Type$seperator$primary_key;
          break;;
          no )
          labels_types_keys+=$rseperator$column_name$seperator$Column_Type$seperator""
          break;;
          * ) echo "Wrong Choice" ;;
        esac
      done
    else
    #meta data
      labels_types_keys+=$rseperator$column_name$seperator$Column_Type$seperator""
    fi
    if [[ $counter == $columns_number ]]; then
      real_data=$real_data$column_name
    else
      real_data=$real_data$column_name$seperator
    fi
    ((counter++))
  done
  touch .$table_name
  echo -e $labels_types_keys  >> .$table_name
  touch $table_name
  echo -e $real_data >> $table_name
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    DMLMENU
  else
    echo "Error Creating Table $table_name"
    DMLMENU
  fi
}

#3.Dropping a table function 
function dropTable {
    # the user will enter the name of the table he wants to drop 
    echo "These are the tables inside!"
    ls  | grep -v ".txt$"
  echo  "Enter Table Name you want to drop: "
  read table_operation
 #removing actual data along with the meta data
  rm $table_operation .$table_operation 2>> error-$(date +%F).txt
  if [[ $? == 0 ]]
  then
    echo "Table Dropped Successfully"
  else
    echo "Error Dropping Table $table_operation"
  fi
  DMLMENU
}

#4.Insert into Table function
function insert {
  ls  | grep -v ".txt$"
  #choosing table name to insert to
  echo -e "Enter table name you want to insert values to : "
  read table_name
  #checking if the table does exist in the database
  if ! [[ -f $table_name ]]; then
    echo " $table_name doesn't exist try another name "
    DMLMENU
  fi
  columns_number=`awk 'END{print NR}' .$table_name`
  seperator="|"
  rseperator="\n"
  for (( i = 2; i <= $columns_number; i++ )); do
  #printing column values using awk line by line
  #fieldname
    column_name=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$table_name)
  #fieldtype
    Column_Type=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$table_name)
      #key
    colKey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$table_name)
    #data will be inserted
    echo -e "$column_name ($Column_Type) = \c"
    read data

    # Validate Input
    if [[ $Column_Type == "integer" ]]; then
      while ! [[ $data =~ ^[0-9]*$ ]]; do
        echo -e "invalid DataType !!"
        echo -e "$column_name ($Column_Type) = \c"
        read data
      done
    fi

    if [[ $colKey == "PK" ]]; then
      while [[ true ]]; do
      #making sure that the atrribute of the primary is unique and not 
        if [[ $data =~ ^[`awk 'BEGIN{FS="|" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $table_name`]$ ]]; then
          echo -e "invalid input for Primary Key !!"
        else
          break;
        fi
        echo -e "$column_name ($Column_Type) = \c"
        read data
      done
    fi

    #Set row
    if [[ $i == $columns_number ]]; then
      row=$row$data$rseperator
    else
      row=$row$data$seperator
    fi
  done
  echo -e $row"\c" >> $table_name
  if [[ $? == 0 ]]
  then
    echo "Data Inserted Successfully"
  else
    echo "Error Inserting Data into Table $table_name"
  fi
  row=""
  DMLMENU
}
# 5.Select From Table"
function selectMenu {
  echo  "Select One of the options below"
  echo "1. Select The Whole Table"
  echo "--------------------------------"
  echo "2. Select a single Column from a Table"
  echo "--------------------------------"
  echo "3. Back To DML Menu"
  echo "--------------------------------"
  echo "4. Back To CRUD Menu"
  echo "--------------------------------"
  echo "5. Exit"
  echo "--------------------------------"
  
  read ch
  case $ch in
    1) selectAll ;;
    2) selectCol ;;  
    3) clear; DMLMENU ;;
    4) clear; cd ../.. error-$(date +%F).txt; CRUDMENU ;;
    5) exit ;;
    *) echo " Wrong Choice " ; selectMenu;
  esac
}
# 5.1 selectin all table content and displaying content in a table view
function selectAll {
  ls  | grep -v ".txt$"
  echo -e "Enter Table Name: \c"
  read table_names
  column -t -s '|' $table_names
  sleep 3
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $table_names"
  fi
  selectMenu
}
#5.2choosing which column value you want to access
function selectCol {
  ls  | grep -v ".txt$"
  echo -e "Enter Table Name: \c"
  read table_names
  echo -e "Enter Column Number: \c"
  read colNum
  
  awk 'BEGIN{FS="|"}{print $'$colNum'}' $table_names
  sleep 3
  selectMenu
}
#6.Delete From Table"
function deleteFromTable {
  ls  | grep -v ".txt$"
  #enter name of table we wand to delete from
  echo -e "Enter Table Name: \c"
  read table_operation
  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $table_operation)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    DMLMENU
  else
    echo -e "Enter Condition Value: \c"
    read val
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $table_operation )
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
      DMLMENU
    else
    #if it exists we delete using sed
      NR=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print NR}' $table_operation)
      sed -i ''$NR'd' $table_operation 
      echo "Row Deleted Successfully"
      DMLMENU
    fi
  fi
}
#7.Update Table function
function updateTable {
  ls  | grep -v ".txt$"
  #entering the table name we want to update
  echo -e "Enter Table Name: \c"
  read table_operation
  #name of the value we want to change (attribute of table)
  echo -e "Enter Condition Column name: \c"
  read field
  #validating that the attribute exists in the table
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $table_operation)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    DMLMENU
  else
  #attribute exists 
    echo -e "Enter Condition Value: \c"
    read val
    #entering the old value of attribute we want to change or update
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $table_operation)
    if [[ $res == "" ]]
    #validate that is exists 
    then
      echo "Value Not Found"
      DMLMENU
    else
    #field name for update
      echo -e "Enter FIELD name for update : \c"
      read setField
      setFid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' $table_operation)
      if [[ $setFid == "" ]]
      then
        echo "Not Found"
        DMLMENU
      else
      #changing the old value to new value
        echo  "Enter new attribute value "
        read updated_value
        NR=$(awk 'BEGIN{FS="|"}{if ($'$fid' == "'$val'") print NR}' $table_operation )
        oldValue=$(awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setFid') print $i}}}' $table_operation)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$updated_value'/g' $table_operation 
        echo "Row Updated Successfully"
        DMLMENU
      fi
    fi
  fi
}


CRUDMENU
