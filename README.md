



**Little JS Helper** - Little JS Helper helps find juicy paths in source code and JS files. This should not take the place of visting the source code or JS files but helps give you a starting point.



<p align="left">
  <B>Warning: Not for illeagal use. Don't be that person!! Get paid for being awesome legally.
The code is not perfect, just like me or you. Feel free to modify the code when you clone it.
This is a bash script with a little Python3.
    </B>
</p>


## Installation

```
1. git clone https://github.com/rollieolie/LittleJsHelper.git
2. cd LittleJsHelper
3. run ./copy_touserbin.sh - copies programs I created to /usr/bin/$programName so they can run onces called in main program
4. If you don't want to do that you can mannually change the programs path in main program or how you please
5. To run it - ./LittleJsHelper.sh -h for options or copy to /usr/bin/ then LittleJsHelper -h
6. Don't forget to add sudo if needed and to chmod +x $program when needed
```

## Features and programs wrapped up

### Using Little JS Helper
  
  ```shell
  
  Usage:
    ./LittleJsHelper.sh or LittleJsHelper (if copied to /usr/bin/)
  Flags:
    -h     Forget how is works? Go ahead and ask for help :) 
    -d     Default config ./LittleJsHelper.sh -d <url> ex: ./LittleJsHelper.sh -d https://www.example.com 
    -l     Same as -d just does it for a list of hosts ex: ./LittleJsHelper.sh -l hosts.txt 
    -u     Prints out list of URLs found in the url source code and Javascript ex: ./LittleJsHelper.sh -u https://www.example.com 
    -s     Just paths in source code of URL ex: ./LittleJsHelper.sh -s https://www.example.com 
    -J     Finds paths in js and list it out ex: ./LittleJsHelper.sh -J https://www.example.com 
    -b     This is the bing bang function which allows you to input .js file and find the paths in that file ex: ./LittleJsHelper.sh -b https://www.example.com/assets/main.js 
  
  ```
  ## Examples
  
  ### Default usage
  ```
  ./LittleJsHelper.sh -d https://www.example.com
  ```
  
  ### Other usages
  
  ```
  More examples are above in the flag options. If you want to save data to output file I would suggest using " | tee output.txt " ex: ./LittleJsHelper.sh -d https://www.example.com | tee output.txt
  
  ```
  
### Last but not least, I give credit to all bug bounty and web app security content creators. I would also like to thank Tomnomnom and GerbenJavado for great examples of regex patterns .  
