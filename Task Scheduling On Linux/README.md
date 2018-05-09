# Scheduling Tasks on Linux Using Crontab

## Getting Started with Crontab : 
> The crontab (**cron** derives from **_chronos_**, Greek for time; **tab** stands for **_table_**) command, found in Unix and Unix-like operating systems, is used to schedule commands to be executed periodically.
-------------
> For currently running **crontabs** on the system : 
``` bash
sudo crontab -l
```
> To edit the list of cronjobs : 
``` bash
sudo crontab -e
```

## About Scheduling of tasks or Cronjobs: 
**Cronjobs** are written in the following format :
``` bash
* * * * * /path/to/the/script.sh

```
The **5 stars** in above format represents different date parts in the following order : 
1. minute (from 0 to 59)
2. hour (from 0 to 23)
3. day of the month (from 1 to 31)
4. month (from 1 to 12)
5. day of the week (from 0 to 6) ( 0 = Sunday)

> ### Executing a task every minute : 
``` bash
* * * * * /path/to/the/script.sh

```
Leaving the star, or asterisk means **every**. In above example, they are all asterisks , so this means execute the script.sh 
* **every** minute
* of **every** hour
* of **every** day of the month
* of **every** month
* of **every** day in the week
**This script is being executed every minute, without exception.**

> ### Executing a task every _Monday to Friday_ at 1AM :
``` bash
0 1 * * 1-5 /path/to/the/scirpt.sh

```
This script is now being executed when the system clock hits : 
* minute: 0
* of hour: 1
* of day of the month: * (every day of month)
* of month: * (every month)
* and weekday: 1-5 ( i.e. Monday to Friday) 

> ###  Neat Scheduling Tricks : 
* To run some script every **10 minutes**, you can do this : 
``` bash 
0,10,20,30,40,50 * * * * /path/to/the/script.sh

```
Crontab also allows the following command for running any script every **10 minutes** : 
``` bash
*/10 * * * * /path/to/the/script.sh

```
> ### Special words 
Some of the specific keywords for running any script in some specific intervals are : 
```
@reboot					Run once, at startup
@yearly					Run once a year
@annually				Run once a year (same as @yearly)
@monthly				Run once a month
@weekly					Run once a week
@daily					Run once a day
@midnight				Run once a day (same as @daily)
@hourly					Run once an hour
```
Implementation of the **Special Words :**
``` bash
@daily /path/to/the/script.js

```

## Storing the output of Crontab :
``` bash
@daily /path/to/the/script.sh >> /var/log/crontab_output.log 2>&1

```
Linux can report on different levels. There's standard output (STDOUT) and standard errors (STDERR). STDOUT is marked 1, STDERR is marked 2. So the  statement  ``` 2>&1 ``` tells Linux to store STDERR in STDOUT as well, creating one datastream for messages & errors.
* ``` >> ``` will append to the file ( ``` > ``` would have overwritten the file )


## Additional Information :

#### For additional info about crontab : 
``` bash
man crontab
``` 

**Note :** cron requires that each entry in a crontab ends in a newline character. If the last entry in a crontab is missing the newline, cron will consider the crontab (at least partially) broken and refuse to install it.