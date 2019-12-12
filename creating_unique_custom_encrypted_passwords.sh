: '
Step-by-step guide

Steps for Ubuntu/Linux:

    Go to http://www.jasypt.org/download.html and download the distribution zip file. Unzip the file, go in to the bin directory, and locate the 4 shell script files i.e. decrypt.sh, digest.sh, encrypt.sh and listAlgorithms.sh. For the encryption to work, all the files and folders downloaded need to be kept together as the bin files depend on files in the lib folder.
    Go to the terminal, 'cd' to the location of the bin folder, and add 'chmod +x digest.sh' to make the file executable.
    Modify your path to add the directory where your script is located: export PATH=$PATH:/appropriate/directory
    Go to codebase, locate the file 'StrongPasswordEncryptor.java', and verify algorithm, iterations and saltSizeBytes.
    For a single use, on the command line, from inside the bin directory, use the following command to create a new encrypted password:
    
    ./digest.sh input=thePassword algorithm=SHA-256 iterations=100000 saltSizeBytes=16
    
    If need to create multiple secure passwords, save the following bash script in the same bin folder as mentioned above, as the script uses the 'digest.sh' file for encryption. Name the file 'scriptEncypt', and make it executable using 'chmod +x scriptEncrypt.sh':
'
    
    #!/bin/bash
     
    rm ~/Downloads/newPasswords.txt
    touch ~/Downloads/newPasswords.txt
     
    while IFS='' read -r line || [[ -n "$line" ]];
    do
    ./digest.sh input="$line" algorithm=SHA-256 iterations=100000 saltSizeBytes=16 verbose=false >> ~/Downloads/newPasswords.txt
     
    done < ~/Downloads/"7.txt"
  
: '  
    Download as a text file the values you need to encrypt. Each value on a new line, and make sure to put a new blank line in the end, to ensure the last concerned value also gets encrypted and is not left out. Name the file '7.txt', and leave it in the Downloads folder. 
    cd to the location of the 'scriptEncrypt.sh' file, and run it using 'sh scriptEncrypt.sh'
    Ignore any output on the screen which says 'file cant be removed', 'wrong input=' etc. 
    Go to downloads folder, and your new text file 'newPasswords.txt' with all the encrypted passwords should be there
    Refer to http://www.jasypt.org/cli.html for documentation.
'
