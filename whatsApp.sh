clear
# granting termux storage
grant_permission(){
    yes | termux-setup-storage
}


# prefix variable
prefix="/sdcard/Android/media" # ! need change
gb="com.gbwhatsapp"
declare {fuad,original}="com.whatsapp"
path="path.txt" 
path2="path2.txt"

find "$prefix" > /dev/null
if [ $? == 1 ]; then 
    grant_permission
fi

################ FUNCTIONS ##################

OriToGB(){
    find "$prefix/$source" -type d -iname "*whatsapp*" | sort -rn > $path

    while read path;
    do
        if [ "$path" != "$prefix/com.whatsapp" ]; then
              mv -v "$path" "$(echo $path | awk -F "/" '{for(i=1; i<NF; i++) printf("%s/",$i); print "GB"$NF}')";
        fi
    done < $path

    mv -v "$prefix/$source" "$prefix/com.gbwhatsapp"
    rm -rf $path
}


GBToOri(){
    find "$prefix/$source" -type d -iname "GB*" | sort -rn > $path2

    while read path2;
    do
        if [ "$path2" != "$prefix/com.gbwhatsapp" ]; then
             mv -v "$path2" "$(echo $path2 | sed 's/\(.*\)GB/\1/')";
        fi
    done < $path2

    mv -v "$prefix/$source" "$prefix/com.whatsapp"
    rm -rf $path2
}
#############################################

echo -e "\n\n\e[1;101m=== RemApple WhatsApp Migrate ===\e[0m"
echo -e "\e[1;92m1. Original WhatsApp to GBWhatsapp\e[0m"
echo -e "\e[1;93m2. GBWhatsApp to Original WhatsApp\e[0m"
echo -e "\e[1;94m3. GBWhatsApp to FuadWhatsApp\e[0m"
echo -e "\e[1;95m4. FuadWhatsApp to GBWhatsApp\e[0m"
echo -e "\e[1;96m5. Update Program\e[0m"
echo -e "\e[1;104m6. Exite\e[0m"
echo -en "\n==> "
read locationDetermine

case "$locationDetermine" in 
    "1" | "4")
        source="$original"
        destination="$gb"
        OriToGB
        ;;
    "2" | "3")
        source="$gb"
        destination="$original"
        GBToOri
        ;;
    "5")
        rm -rf $HOME/whatsappMigrate
        cd $HOME
        git clone https://github.com/remku/whatsappMigrate
        cd whatsappMigrate
        bash whatsapp.sh
        ;;
    *)
        echo "Please select a valid input"
        exit
esac






