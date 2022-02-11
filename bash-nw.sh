#! bin/bash
####### PATH SECTION #######
path="/mnt/c/Users/luigi/Desktop/bash-scripts/"
modules="module1 module2 module3"
pom="/pom.xml"
############################
#### DEPENDENCY SECTION ####
dependency="<artifactId>jaxb-api</artifactId>"
############################

bak="/pom.xml.bak"

echo -e "\n

 _     _           _                    ______   _____  ______          _           _ _ 
| |   | |         | |      _           (_____ \ / ___ \|  ___ \        | |         | | |
| |   | |____   _ | | ____| |_  ____    _____) ) |   | | | _ | |    ___| | _   ____| | |
| |   | |  _ \ / || |/ _  |  _)/ _  )  |  ____/| |   | | || || |   /___) || \ / _  ) | |
| |___| | | | ( (_| ( ( | | |_( (/ /   | |     | |___| | || || |  |___ | | | ( (/ /| | |
 \______| ||_/ \____|\_||_|\___)____)  |_|      \_____/|_||_||_|  (___/|_| |_|\____)_|_|
        |_|                   
                                                          

v0.0.001\n"

echo -e "\e[35mPlease select an option:\n\e[39m"
options=("Select one module" "Review all modules")
select option in "${options[@]}"
do
    echo -e "\e[39m"
    case $option in
    "Select one module") 

        for input in $option
        do             
            echo -e "\e[35mThese are the available modules on which you can make changes:\e[39m"

        for module in $modules 
        do
            echo $module  
        done

        echo -e "\n\e[96mWrite the name of the module you want to work on:\n\e[39m"
        read select_m
        pth="$path${select_m}$pom"
        opt1_lines=$(grep -n $dependency $pth | awk -F  ":" '{print $1}')
        opt1_count=$(grep -o "$dependency" $pth | wc -l)
       
        if (( $opt1_count == 0 )); then
            echo -e "\e[91mDependency of type $dependency not found"
        elif (( $opt1_count == 1 )); then
            echo -e "\n*******\n\n\e[95mYou are working on:     \e[103m\e[30m $select_m \e[49m"
            echo -e "\n\e[97mFound dependency of type \e[93m$dependency\e[97m at line: \n\n$opt1_lines"
            opt1_x=$((($opt1_lines)+1))
            opt1_space=$(($opt1_lines))
            version=$(head -n $opt1_x $pth | tail -n 1)
            echo -e "\n\e[97mCheck current dependency version: \n\n\e[93m$version\n\e[97m"

            opt1_check="$path${select_m}$bak"
            opt1_upd_f="$opt1_check"
            echo -e "\e[96m>\e[93m "$select_m "\n"
            opt1_overwrite="$path${select_m}$pom"
            opt1_ow="$opt1_overwrite"

            change_selected() {
            while true; 
            do
                read -r -n 1 -p "${1:-Do you want to proceed and make changes?} [y/n]: " change_selected
                case $change_selected in
                [yY]) echo -e ; return 0 ;;
                [nN]) echo ; return 1 ;;
                *) printf " \033[31m %s \n\033[0m" "Invalid input"
                esac 
            done  
            }

            change_selected
            if [ "$change_selected" == "y" ]; then

                declare updates="Updating $select_m"

                echo -e "\e[96mWaiting for a new dependency version..."
                echo -e "\e[97mInsert new version: "
                read opt1_bump
                
                space=$(head -n $opt1_x $pth | grep -c -oP '(?<=\t).*?(?=<version>)')
                _space=${space}

                numLines=${_space}
                addSpace=$(printf "%*s%s" $numLines '' "$addSpace")
                
                opt1_sed=$(sed "${opt1_x}s~$version~$addSpace<version>$opt1_bump</version>~g" $pth > $pth.bak)
                eval $opt1_sed

                echo -e "Done! \e[92mUpdated dependency to version $opt1_bump  \e[39m"


            elif [[ -z "$pth" ]]; then
                exit 0
            elif [ "$change_selected" == "n" ]; then
                continue
            else
                echo -e "\e[96mProcess finished"
                exit 0
            fi

            changes_confirm_selected() {
            while true; do
            read -r -n 1 -p "${1:-Do you want to confirm the changes you made by overwriting the pom?} [y/n]: " confirm_selected
                case $confirm_selected in
                [yY]) echo -e ; return 0 ;;
                [nN]) echo ; return 1 ;;
                *) printf " \033[31m %s \n\033[0m" "Invalid input"
                esac 
            done  
            }

            changes_confirm_selected 
            if [ "$confirm_selected" == "y" ]; then
                if [[ -f $opt1_upd_f ]]; then
                    echo -e "\e[96mYour changes are being processed..."
                    mv $opt1_upd_f $opt1_ow
                    echo -e "\e[92mDone!\n \e[39m"
                    continue
                else
                    echo -e "\e[91mYou have not made changes on this module\e[39m"
                    continue
                fi
            elif [ "$confirm_selected" == "n" ]; then
                continue 
            else
                echo -e "\e[96mProcess finished"
                exit 0
            fi

        else 
            echo -e "Found $opt1_count dependencies of type $dependency at lines: \n $opt1_lines"
        fi
        done
        ;;

    "Review all modules") 
    review_all() {
    while true; do
    read -r -n 1 -p "${1:-Do you want to proceed with reviewing all modules?} [y/n]: " review_all
        case $review_all in
        [yY]) echo -e ; return 0 ;;
        [nN]) echo ; return 0 ;;
        *) printf " \033[31m %s \n\033[0m" "Invalid input"
        esac 
    done  
    }

    review_all
        if [ "$review_all" == "n" ]; then
            echo -e "\e[96mProcess finished"
            exit 0
        fi

    for mod_x in $modules
    do
        files="$path${mod_x}$pom"
        file="$files"

        lines=$(grep -n $dependency $files | awk -F  ":" '{print $1}')
        count=$(grep -o "$dependency" $files | wc -l)

    for file_x in $files 
    do
    if (( $count == 0 )); then
        echo -e "\e[91mDependency of type $dependency not found"
    elif (( $count == 1 )); then
        echo -e "\n*******\n\n\e[95mYou are working on:     \e[103m\e[30m $mod_x \e[49m"
        echo -e "\n\e[97mFound dependency of type \e[93m$dependency\e[97m at line: \n\n$lines"
        x=$((($lines)+1))
        version=$(head -n $x $files | tail -n 1)
        echo -e "\n\e[97mCheck current dependency version: \n\n\e[93m$version\n\e[97m"

        changes_list() {
        while true; do
        read -r -n 1 -p "${1:-Do you want to proceed?} [y/n]: " change_list
            case $change_list in
            [yY]) echo -e ; return 0 ;;
            [nN]) echo ; return 1 ;;
            *) printf " \033[31m %s \n\033[0m" "Invalid input"
            esac 
        done  
        }

        changes_list 
        if [ "$change_list" == "y" ]; then

            declare updates="Updating $mod_x"

            echo -e "\e[96mWaiting for a new dependency version..."
            echo -e "\e[97mInsert new version: "
            read bump_to
            sed=$(sed "${x}s~$version~      <version>$bump_to</version>~g" $files > $files.bak)
            eval $sed

            echo -e "Done! \e[92mUpdated dependency to version $bump_to\e[39m"

        elif [[ -z "$files" ]]; then
            exit 0
        elif [ "$change_list" == "n" ]; then
            continue
        else
            echo -e "\e[96mProcess finished"
            exit 0
        fi

    else 
        echo -e "Found $count dependencies of type $dependency at lines: \n $lines"
    fi

    done

    done

    proceed() {
        while true; do
        read -r -p "${1:-Do you want to proceed with saving the changes?} [y/n]: " proceed
            case $proceed in
            [yY]) echo -e ; return 0 ;;
            [nN]) echo ; return 1 ;;
            *) printf " \033[31m %s \n\033[0m" "Invalid input"
            esac 
        done  
        }

        proceed
        if [ "$proceed" == "n" ]; then
            echo -e "\e[96mProcess finished"
            exit 1
        fi

    echo -e "\n\e[96mYou have made changes to the following modules:\n \e[39m"
    for upd_m in $modules
    do
        check="$path${upd_m}$bak"
        upd_f="$check"
        echo -e "\e[96m>\e[93m "$upd_m "\n"
        overwrite="$path${upd_m}$pom"
        ow="$overwrite"

        changes_confirm() {
        while true; do
        read -r -p "${1:-Do you want to confirm the changes you made by overwriting the pom?} [y/n]: " confirm
            case $confirm in
            [yY]) echo -e ; return 0 ;;
            [nN]) echo ; return 1 ;;
            *) printf " \033[31m %s \n\033[0m" "Invalid input"
            esac 
        done  
        }

        changes_confirm 
        if [ "$confirm" == "y" ]; then

            if [[ -f $upd_f ]]; then
                echo -e "\e[96mYour changes are being processed..."
                mv $upd_f $ow
                echo -e "\e[92mDone!\n"
            else
                echo -e "\e[91mYou have not made changes on this module \e[39m"
                continue
            fi

        elif [ "$confirm" == "n" ]; then
            continue
        else
            echo -e "\e[96mProcess finished"
            echo -e "\e[39m"
            exit 0
        fi
    done
            ;;
    esac
    echo "Choose option: [1/2]"
done