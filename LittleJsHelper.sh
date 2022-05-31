#!/bin/bash






Start(){
beauty_js $1 | tee UrlContent.txt;
cat UrlContent.txt | grep -iEho "https?://[^\"\\'>]+"| sort -u | grep "\.js" > jsurls.txt
GetUrl $1 > insideContent.txt
cat insideContent.txt | grep -iEho "https?://[^\"\\'>]+|\/[A-Za-z0-9_\-\/]*" | sort -u > InsidePaths.txt;
}

j=jsurls.txt

End(){
while read url;do
    echo
    echo
    echo '---------------------------------------------------'$url'--------------------------------------------------------------------';
    echo
    echo
    curl -sk $url | grep -iEo "https?://[^\"\\'>]+|\/[a-zA-Z0-9_\-\/]*\/[A-Za-z0-9_\-\/]*" | sort -u | tee jspaths.txt
    echo
    echo
    echo
    echo
done<$2
echo
echo '-------------------------------------------------Inside content' $1 '--------------------------------------------------------------'
echo
echo
cat InsidePaths.txt
echo
echo
echo '--------------------------------------------------The End---------------------------------------------------------------------------'
echo
echo
echo
}





AllUrls(){
cat InsidePaths.txt >> stuff.txt
cat output.txt >> stuff.txt
cat stuff.txt | grep -iEho "https?://[^\"\\'>]+" > allUrls.txt
cat allUrls.txt
rm stuff.txt
rm allUrls.txt
}





AllPaths(){
cat InsidePaths.txt >> morestuff.txt
cat output.txt >> morestuff.txt
cat morestuff.txt | grep -iEho "\/[A-Za-z0-9_\-\/]*" > allpaths.txt
}








UseAFile(){
while read url;do
    GetUrl $url
    cat UrlContent.txt | grep -iEho "https?://[^\"\\'>]+|\/[A-Za-z0-9_\-\/]*" | sort -u > InsidePaths.txt;
    cat UrlContent.txt | grep -iEho "https?://[^\"\\'>]+"| sort -u | grep "\.js" > jsurls.txt
    while read js;do
        echo
        echo
        echo '---------------------------------------------------'$js'--------------------------------------------------------------------';
        echo
        echo
        curl -sk $url | grep -iEo "https?://[^\"\\'>]+|\/[a-zA-Z0-9_\-\/]*\/[A-Za-z0-9_\-\/]*" | sort -u | tee jspaths.txt
        echo
        echo
        echo
        echo
    done<$2
    echo
    echo '-------------------------------------------------Inside content' $url '--------------------------------------------------------------'
    echo
    echo
    cat InsidePaths.txt
    echo
    echo
    echo '--------------------------------------------------The End---------------------------------------------------------------------------'
    echo
    echo
    echo
done<$1
}




BingBangJs(){
GetUrl $1 > jscontent.txt
cat jscontent.txt | grep -iEho "https?://[^\"\\'>]+|\/[A-Za-z0-9_\-\/]*" > urlsnpaths.txt
echo
echo
echo '--------------------------------------------------'+$1+'----------------------------------------------------------------'
echo
echo
cat urlsnpaths.txt | sort -u | sponge urlsnpaths.txt
cat urlsnpaths.txt
echo
echo
echo
echo
}








PathsInContent(){
GetUrl $1 > urlcontent.txt
cat urlcontent.txt | grep -iEho "https?://[^\"\\'>]+|\/[A-Za-z0-9_\-\/]*" > urlsnpaths.txt
cat urlsnpaths.txt | sort -u | sponge urlsnpaths.txt
cat urlsnpaths.txt
}





Help(){
# Display Help
echo "Welcome to LittleJsHelper ! "
echo
echo "This tool is meant to take a look for paths in source code of URL and inside JavaScript"
echo
echo "I created this tool for Bug Bounty hunting/Pentesting. This tool is meant to help or point to clues but not a substitute for looking yourself."
echo "Please don't be an asshole and use this for Black Hat/illeagal purposes. "
echo
echo "Seriously if you're good at hacking get paid for it legally. "
echo
echo "Syntax: scriptTemplate [-h|d|l|u|s|J|b]"
echo "use : ./LittleJsHelper.sh -opiton <url> or <hosts.txt> or <jsurl> [options] (-d -l -u -s -J -b) "
echo
echo "options:"
echo "-h     Forget how is works? Go ahead and ask for help :) "
echo "-d     Default config ./LittleJsHelper.sh -d <url> ex: ./LittleJsHelper.sh -d https://www.example.com "
echo "-l     Same as -d just does it for a list of hosts ex: ./LittleJsHelper.sh -l hosts.txt "
echo "-u     Prints out list of URLs found in the url source code and Javascript ex: ./LittleJsHelper.sh -u https://www.example.com "
echo "-s     Just paths in source code of URL ex: ./LittleJsHelper.sh -s https://www.example.com "
echo "-J     Finds paths in js and list it out ex: ./LittleJsHelper.sh -J https://www.example.com "
echo "-b     This is the bing bang function which allows you to input .js file and find the paths in that file ex: ./LittleJsHelper.sh -b https://www.example.com/assets/main.js "
echo
echo "If you want to save any of the data produced please just add | tee file.txt ex: ./LittleJsHelper.sh -[option] <url> or <list.txt> or <url.js> | tee output.txt "
echo
echo
echo "Go through README.MD to find out how to setup the program."
}

while getopts ":hdlusJb:" option; do
    case $option in
        h) # display Help
            Help
            exit;;
        d) # -d <https://URL_Path>
            Start $2
            End $j $2
            rm UrlContent.txt
            rm jsurls.txt
            rm insideContent.txt
            rm InsidePaths.txt
  
            exit;;
        l) # -l <hosts.txt>
            UseAFile $2
            rm UrlContent.txt
            rm jsurls.txt
            rm insideContent.txt
            rm InsidePaths.txt
            exit;;
        u) #print just urls
            Start $2 > bob1.txt
            End $j $2 > bob2.txt
            AllUrls $2
            rm bob1.txt
            rm bob2.txt
            rm UrlContent.txt
            rm jsurls.txt
            rm insideContent.txt
            rm InsidePaths.txt
            
            exit;;
        s) # Just the paths in source code
            PathsInContent $2
            rm urlcontent.txt
            rm urlsnpaths.txt
            exit;;
        J) # Just Js Paths found
            Start $2 > bob1.txt
            End $j $2 > bob2.txt
            cat bob2.txt | grep -iEo "\/[a-zA-Z0-9_\-\/]*\/[A-Za-z0-9_\-\/]*" | sort -u | tee jspaths.txt
            cat jspaths.txt
            rm bob1.txt
            rm bob2.txt
            rm UrlContent.txt
            rm jsurls.txt
            rm insideContent.txt
            rm InsidePaths.txt
            
            exit;;
        b) # On the spot js paths finding
            BingBangJs $2
            rm jscontent.txt
            rm urlsnpaths.txt
            exit;;
        \?) # Invalid option
            echo "Error: Invalid option brahh! use -h for help"
            exit;;
    esac
done







