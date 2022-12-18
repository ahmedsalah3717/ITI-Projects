#!/bin/bash
#dbmsname=""
# the place you  want to create the database and the name of the DBMS
#notice if you want to chose the list databases command without creating some databases you can navigate to the folder containing the databased first
echo "If You Want To Create A DBMS With A New Name Enter yes "
echo "If You Want To Enter The DBMS Directly Enter go "
read answer
if [[ $answer == yes ]];then
 
 echo "What do you want to call the DBMS ?
 Note: Care that the DBMS will be created in the home directory 
 "
 read DBMSname 
 cd $HOME
 dbmsname="$DBMSname-$(date +%T)"
 # I just wanted to make a specific name for every database i create not to fall in any naming conflicts you know life is hard sometimes and you just want to die xD anyways all good i'm fine or am i? haha i;m just kidding man ijust wanna sleep wallah, i sleep like 4 hours a day like this is not healthy bro JUST LET ME SLEEP ! also for the females reading this if Corona doesn't take you out can I ? UwU  
 #mkdir -m 755 $HOME/"$DBMSname-$(date +%T)" 2>> error-$(date +%F).txt
 mkdir -m 755 $HOME/$dbmsname 2>> error-$(date +%F).txt
 
 cd $HOME/$dbmsname
 echo "creating database $dbmsname just a sec.. "
 sleep 2
clear
 echo "Loading... BEEP BOOP 🤖"
 sleep 4
 clear
 
 echo  "yay! $dbmsname was created! "
 sleep 2
 echo "Welcome To DBMS 😃 "
 sleep 2


 
#if the user wants to connecto to an old DBMS
 
elif [[ $answer == go ]];then
clear
ls -F $HOME | grep "/$"
read -p "Enter the name of the DBMS directory you want to access to  " dbms_location
cd $HOME/$dbms_location
clear
echo "Welcome Back !!"



else 
 exit
fi
  

#the main manu that appears for DML and DDL operations
function CRUDMENU {
  echo  "Welcome to the CRUD Menu you can chose from these options: "
  sleep 1
  echo -e "\n1. Create Database"
  echo "--------------------------------"
  echo "2. List Databases"
  echo "--------------------------------"
  echo "3. Connect To Databases"
  echo "--------------------------------"
  echo "4. Drop Database"
  echo "--------------------------------"

  echo  "Choose Action? "
  read menuchoice
  case $menuchoice in
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
   if [[ $answer == yes ]];then
   cd $HOME/$dbmsname
   elif [[ $answer == go ]];then
cd $HOME/$dbms_location
fi
  echo "These are the databases inside : "
  ls -F $pwd | echo */
  echo  "Enter Database Name you want to add: "
  read database_name_creation
  #create the database in the directory we're in atm  and we make a unique name no to fall into naming conflict
  #if there is an error in the mkdir command somehow ele howa mish fahm ezay ht7sl bs momken kol 4e2 gayz ya3ne the error will go to same file created this day 

  
   
  mkdir "$database_name_creation-$(date +%F)" 2>> error-$(date +%F).txt

    
  if [[ $? == 0 ]]
  then
    echo "Database Created "
    
  else
    echo "Error "
  fi
  CRUDMENU
}

#DropDataBase

function dropping {
  if [[ $answer == yes ]];then
   cd $HOME/$dbmsname/
   ls -d */

   elif [[ $answer == go ]];then
   cd $HOME/$dbms_location/
   ls -d */

   fi
  echo "Enter Database Name You want to Drop: "
  read dropdb_name
  rm -r $dropdb_name 2>> error-$(date +%F).txt
  if [[ $? == 0 ]]; then
    echo "Database Dropped Successfully"
  else
    echo "Wrong DataBase Name"
  fi
  CRUDMENU
}
############Connect to DataBase
function connect {

  if [[ $answer == yes ]];then
   cd $HOME/$dbmsname/
   ls -d */

   elif [[ $answer == go ]];then
   cd $HOME/$dbms_location/
   ls -d */

    

   fi
    echo "Enter The Database Name You Want To Connect To : "
    #get the name of database you want to cd to by user
  read dbName_connect
  cd $dbName_connect
 
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
    2)  echo "These are the list of tables inside!" ; ls -d */ ; sleep 3 ; DMLMENU ;;
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
###creating table inside database chosen
function createTable {
  echo -e "Enter Table Name you want to add!"
  read table_name
  #checking if the name is already taken 
  if [[ -f $table_name ]]; then
    echo "This table name is already taken pls try another name"
    DMLMENU
  fi
  echo -e "enter number of columns"
  read colsNum
  rseperator="\n"
  counter=1
  seperator="|"
  primary_key=""
  labels_types_keys="Field"$seperator"Type"$seperator"key"
  while [ $counter -le $colsNum ]
  do
    echo  "Specify name for column number: $counter:"
    read column_name

    echo  "choose the type of column $column_name: "
    select var in "int" "str"
    do
      case $var in
        int ) colType="int";break;;
        str ) colType="str";break;;
        * ) echo "Wrong Choice" ;;
      esac
    done
    if [[ $primary_key == "" ]]; then
      echo -e "Do you want to make this a primary key ? "
      select var in "yes" "no"
      do
        case $var in
          yes ) primary_key="PK";
          labels_types_keys+=$rseperator$column_name$seperator$colType$seperator$primary_key;
          break;;
          no )
          labels_types_keys+=$rseperator$column_name$seperator$colType$seperator""
          break;;
          * ) echo "Wrong Choice" ;;
        esac
      done
    else
      labels_types_keys+=$rseperator$column_name$seperator$colType$seperator""
    fi
    if [[ $counter == $colsNum ]]; then
      temp=$temp$column_name
    else
      temp=$temp$column_name$seperator
    fi
    ((counter++))
  done
  touch .$table_name
  echo -e $labels_types_keys  >> .$table_name
  touch $table_name
  echo -e $temp >> $table_name
  if [[ $? == 0 ]]
  then
    echo "Table Created Successfully"
    DMLMENU
  else
    echo "Error Creating Table $table_name"
    DMLMENU
  fi
}
#
function dropTable {
  echo -e "Enter Table Name: \c"
  read tName
  rm $tName .$tName error-$(date +%F).txt
  if [[ $? == 0 ]]
  then
    echo "Table Dropped Successfully"
  else
    echo "Error Dropping Table $tName"
  fi
  DMLMENU
}

function insert {
  echo -e "Enter table name you want to insert values to : "
  read table_name
  if ! [[ -f $table_name ]]; then
    echo " $table_name doesn't exist try another name "
    DMLMENU
  fi
  colsNum=`awk 'END{print NR}' .$table_name`
  seperator="|"
  rseperator="\n"
  for (( i = 2; i <= $colsNum; i++ )); do
    column_name=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$table_name)
    colType=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$table_name)
    colKey=$( awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$table_name)
    echo -e "$column_name ($colType) = \c"
    read data

    # Validate Input
    if [[ $colType == "int" ]]; then
      while ! [[ $data =~ ^[0-9]*$ ]]; do
        echo -e "invalid DataType !!"
        echo -e "$column_name ($colType) = \c"
        read data
      done
    fi

    if [[ $colKey == "PK" ]]; then
      while [[ true ]]; do
        if [[ $data =~ ^[`awk 'BEGIN{FS="|" ; ORS=" "}{if(NR != 1)print $(('$i'-1))}' $table_name`]$ ]]; then
          echo -e "invalid input for Primary Key !!"
        else
          break;
        fi
        echo -e "$column_name ($colType) = \c"
        read data
      done
    fi

    #Set row
    if [[ $i == $colsNum ]]; then
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
function updateTable {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    DMLMENU
  else
    echo -e "Enter Condition Value: \c"
    read val
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tName error-$(date +%F).txt)
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
      DMLMENU
    else
      echo -e "Enter FIELD name to set: \c"
      read setField
      setFid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$setField'") print i}}}' $tName)
      if [[ $setFid == "" ]]
      then
        echo "Not Found"
        DMLMENU
      else
        echo -e "Enter new Value to set: \c"
        read newValue
        NR=$(awk 'BEGIN{FS="|"}{if ($'$fid' == "'$val'") print NR}' $tName error-$(date +%F).txt)
        oldValue=$(awk 'BEGIN{FS="|"}{if(NR=='$NR'){for(i=1;i<=NF;i++){if(i=='$setFid') print $i}}}' $tName error-$(date +%F).txt)
        echo $oldValue
        sed -i ''$NR's/'$oldValue'/'$newValue'/g' $tName error-$(date +%F).txt
        echo "Row Updated Successfully"
        DMLMENU
      fi
    fi
  fi
}

function deleteFromTable {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Condition Column name: \c"
  read field
  fid=$(awk 'BEGIN{FS="|"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$field'") print i}}}' $tName)
  if [[ $fid == "" ]]
  then
    echo "Not Found"
    DMLMENU
  else
    echo -e "Enter Condition Value: \c"
    read val
    res=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print $'$fid'}' $tName error-$(date +%F).txt)
    if [[ $res == "" ]]
    then
      echo "Value Not Found"
      DMLMENU
    else
      NR=$(awk 'BEGIN{FS="|"}{if ($'$fid'=="'$val'") print NR}' $tName error-$(date +%F).txt)
      sed -i ''$NR'd' $tName error-$(date +%F).txt
      echo "Row Deleted Successfully"
      DMLMENU
    fi
  fi
}

function selectMenu {
  echo  "Select One of the options below"
  echo "1. Select The Whole Table"
  echo "--------------------------------"
  echo "2. Select a single Column from a Table"
  "--------------------------------"
  echo "3. Back To DML Menu"
  "--------------------------------"
  echo "4. Back To CRUD Menu"
  "--------------------------------"
  echo "5. Exit"
  "--------------------------------"
  
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

function selectAll {
  echo -e "Enter Table Name: \c"
  read tName
  column -t -s '|' $tName error-$(date +%F).txt
  if [[ $? != 0 ]]
  then
    echo "Error Displaying Table $tName"
  fi
  selectMenu
}

function selectCol {
  echo -e "Enter Table Name: \c"
  read tName
  echo -e "Enter Column Number: \c"
  read colNum
  awk 'BEGIN{FS="|"}{print $'$colNum'}' $tName
  selectMenu
}


CRUDMENU