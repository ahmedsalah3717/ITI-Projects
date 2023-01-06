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
    echo " three should be a table here "
  else
    echo "Database $dbName_connect wasn't found"
    CRUDMENU
  fi
}
CRUDMENU

