# useful-bashrc
This my bashrc is useful manage file and subdirectory in one directory. It contain one function to list the content of the directory and add a prefix number when print on terminal. We could go to subdirectory/view the content of file quickly with those index number. 
#Usage:
  1. Command: ld --> List the content of the current directory 
  
  ==> Result: 
  
 -----------------------------------------------------------------------------------------------------------------------------------------
 ---> DIR LIST:
1- design/                                          2- test/                                            3- tool/         

---> FILE LIST:

4- a.csh                                           |

5- a.txt                                           |

6- c.sh                                            |

----->

/home/users/tux/study

Sun Sep 10 06:59:11 ICT 2017

-----------------------------------------------------------------------------------------------------------------------------------------
  2. Command:
  
    g index |
    
    a index  \  + Content of index is file: View file by Vim
    
              > + Content of index is subdir: Cd to Subdir.  
              
    gindex   /
    
    aindex  |
    
   Example: Enter--> "a2" or "a 2": cd to test directory
   
            Enter--> "a5" or "g5" or "g 5": view file a.txt by Vim.
            
            
NOTE: this is the first draft function.
