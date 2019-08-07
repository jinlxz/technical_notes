# Shell scripting tutorial
## 1. Definition
1. Login shell, A  login  shell  is  **one whose first character of argument zero is a -, or one started with the --login option.**
2. Interactive shell, it is one started **without non-option arguments**  and  without  the  -c  option whose standard input and error are both connected to terminals, **or one started with the -i option.** 

These two types of operating mode have the following behaviors:

- Login shell.

  It first reads and executes commands from the file /etc/profile, if  that  file exists.   After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and executes commands from the first one that exists and is  readable. The --noprofile option may be used when the shell is started to inhibit this behavior. When  a login shell exits, bash reads and executes commands from the file ~/.bash_logout, if it exists.
- interactive shell that is not a login shell

  Bash reads and executes commands from /etc/bash.bashrc and ~/.bashrc, if these files exist. This may be inhibited by using the --norc option. The --rcfile file option will force bash to read and execute commands from file instead of /etc/bash.bashrc and ~/.bashrc.

2. test if termux works.
