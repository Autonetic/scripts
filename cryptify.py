import pyAesCrypt
import getpass
from os import stat, remove

print("\033[1;32m+-----------------------------------------+\033[0m")
print("\033[1;32m|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\|\033[0m")
print("\033[1;32m|-=[ \033[0m\033[1;35mSimple File Encryption - Cryptify\033[0m\033[1;32m ]=-|\033[0m")
print("\033[1;32m|--------------=(\033[0;35mCryptify\033[1;32m)=---------------|\033[0m")
print("\033[1;32m|/\/\/\/\/\/\033[0m\033[1;33mCoded@ Autonetix.co\033[0m\033[1;32m/\/\/\/\/\/|\033[0m")
print("\033[1;32m+-----------------------------------------+\033[0m")

purple = "\033[1;35m"
ltpurple = "\033[0;35m"
green = "\033[1;32m"
red = "\033[1;31m"
orange = "\033[1;33m"
nocolour = "\033[0m"

print(orange,"Welcome to Cryptify! - Simple file encryption using a Password")
location = input("Please enter the file or folders path:")
choice = input("Would you like to Encrypt a file, or Decrypt? Ee/Dd:").lower()
print(nocolour)
try:
  if choice == "e":
    print(orange,"Encryption Selected, Please enter a password:", nocolour)
    password = getpass.getpass()
    print(orange,"Encrypting File...", nocolour)
    #pyAesCrypt.encryptFile("location","location.aes",password)
    with open(location, "rb") as fIn:
      with open("encrypted.aes", "wb") as fOut:
        pyAesCrypt.encryptStream(fIn, fOut, password)
    print(green,"Encryption Successful!", nocolour)
    print(orange,"Output file name: encrypted.aes",nocolour)
  elif choice == "d":
    print(orange,"Decryption Selected, Please enter a password:", nocolour)
    decpass = getpass.getpass()  
    print(green,"Decrypting File...", nocolour)
    pyAesCrypt.decryptFile(location, "unencrypted.txt", decpass)
    print(green,"Decryption Successful!", nocolour)
    print(orange,"Output file name: unencrypted.txt",nocolour)
    
except Exception as err: print(red,"\nCaught an Exception...\n",err,nocolour)
  





