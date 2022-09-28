#!/bin/bash

#Current version of the script, printed in the backtitle
current_version="v1.1-beta"

#Function to get parameters for the entry
function addentry {
exec 3>&1; report_ip=$(dialog --title "[!] Input the required parameters" --backtitle "$current_version" --inputbox "Input the IP address to report" 0 0 2>&1 1>&3); exec 3>&-;
exec 3>&1; report_categories=$(dialog --title "[!] Input the required parameters" --backtitle "$current_version" --inputbox "Input the report category(ies). Comma separated for multiple categories" 0 0 2>&1 1>&3); exec 3>&-;
exec 3>&1; report_comment=$(dialog --title "[!] Input the required parameters" --backtitle "$current_version" --inputbox "(OPTIONAL) Input the report comment. Max 1024 characters" 0 0 2>&1 1>&3); exec 3>&-;
#Creating a temporary txt to store cURL results
api_output=$(mktemp api_output.txt)
#Send POST request
curl https://api.abuseipdb.com/api/v2/report \
  --data-urlencode "ip=$report_ip" \
  -d categories=$report_categories \
  --data-urlencode "comment=$report_comment" \
  -H "Key: $api_key" \
  -H "Accept: application/json" > $api_output #The output is written to the temp txt file
#Put the content of the temp txt file into a variable
api_msgbox=$(cat $api_output)
#Output the result in a Dialog box
dialog --title "POST request output" --backtitle "$current_version" --msgbox "$api_msgbox" 0 0
#Remove the temp file
rm "$api_output"
#Check if the positional argument "save" was provided
if [ $save_toggle = "save" ]; then
  #If yes, save the output to a txt file in the current directory.
  #The file name is made by the report ip + a timestamp in a ddmmyyyy_hhmmss format
  current_timestamp=$(date +%d%m%Y_%H%M%S)
  output_file_name="$report_ip""_$current_timestamp.txt"
  #Pass the POST request output to the txt file
  echo $api_msgbox > $output_file_name
  #Send a confirmation (showing the file name) to the user
  dialog --title "File created successfully" --backtitle "$current_version" --msgbox "Request output saved to file $output_file_name" 0 0
  #Finally invoke the function to ask if the user needs to input additional entries
  askforentry
else
  #Invoke the function to ask if the user needs to input additional entries
  askforentry
fi
}

#Function to ask the user if he wants to input another entry
function askforentry {
  askforentry_menu_options=(1 "YES" 2 "NO")
  askforentry_menu_select=$(dialog --clear --backtitle "$current_version" --title "Choose an option" --menu "Do you want to add another entry?:" 0 0 0 "${askforentry_menu_options[@]}" 2>&1 >/dev/tty)
  clear
  #If YES, invoke the addentry function again. If NO, terminate the execution
  case $askforentry_menu_select in
    1) addentry;; 2) exit 1;;
  esac
}

#Function to ask for the API key
function inputapikey {
  exec 3>&1; api_key=$(dialog --title "[!] Input the required parameters" --backtitle "$current_version" --inputbox "Please provide your API key"  0 0 2>&1 1>&3); exec 3>&-;
  addentry
}

#Function to check if the file containing the API key exists
function checkapikey {
  #Define the file containing the API key
  api_key_file=api.txt
  #Check if the file exists
  if [ -f "$api_key_file" ]; then
    #If yes, pass its content to the api_key variable
    api_key=$(cat $api_key_file)
    #Then, invoke the function asking for the input
    addentry
  else
    #If not, warn the user and ask for the key
    dialog --title "[!] File not found" --backtitle "$current_version" --msgbox "No API key provided (api.txt). You will be prompted to insert one in the next step. NOTE: it will be valid for this execution only. If you don't want to provide it each time, store it in a file named api.txt in the script working directory" 0 0
    inputapikey
  fi
}

#Pass the first positional parameter (should be "save") into a variable
save_toggle=$1
#Invoke the first function
checkapikey
