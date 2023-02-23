# Acme.sh shell simple installer & DNS Manual mode certificate register
# This shell script has been created as an installer of the acme.sh package and to allow the simplified creation of acme.sh DNS manual mode certificates 

# Author: Grant Kellie
# Email: contact@grantkellie.dev
# Website: grantkellie.dev
# Date Created: 2023 02 23
# Lasted Edited: 2023 02 23
# Copyright 2023 : Grant Kellie


#!/bin/bash

# If directory exists: use Acme.sh to setup or renew certificate
# Else: Setup and install acme.sh, give option to retry or close after
acme_directory="/home/$USER/.acme.sh/"
if [ -d "$acme_directory" ]; then
   
    # Enter the domain name
    echo "Please enter the domain name: "  
    read domain_name  

    # Issue Certificate command
    issue_cert="acme.sh --issue --dns -d $domain_name --yes-I-know-dns-manual-mode-enough-go-ahead-please"

    # Run Issue Certificate Command
    eval $issue_cert

else
    echo "acme.sh is not installed on this system."
    echo "https://github.com/acmesh-official/acme.sh"
     
    echo  "Would you like to install acme.sh official?"
    read -p "(Yes | No) " yn
    case ${yn:0:1} in
        y|Y|yes|Yes )
            echo "Set an email for acme.sh to register certificates with: "  
            read email  

            # Install acme.sh offical
            eval curl https://get.acme.sh | sh -s email=$email

            # Update Cron Entries
            # eval crontab -e

            # Cron Entry (Example)
            # */15 * * * * "/home/$USER/.acme.sh"/acme.sh --cron --home "/home/$USER/.acme.sh" > /dev/null

            echo "Would you like to read the commands list?"
            read -p "(Yes | No) " yn
            case ${yn:0:1} in
                y|Y|yes|Yes )
                    eval acme.sh -h            
                ;;
                * )
                    # exit
                ;;
            esac
        ;;
        * )
            # exit
        ;;
    esac
    
fi

# Pause before close
read junk