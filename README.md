# MigratingzPDT
Files used to migrate to a new level of z/OS on zPDT and ADCD

## This is a repository of files I used to migrate from z24c to z25D


## Useful  ISPF edit macros
- COPYADCD Edit an empty member in a  USER.*.something dataset. If the dataset is USER.... then copy the member form ADCD.....   If the dataset is ADCD.... then copy the member from USER.....
- COMPADCD if editing a member USER.Z25D.PROCLIB(MYPROC) (for example) , it checks the existance of the member USER.Z24C.PROCLIB(MYPROC) and invokes ISPF compare so you can see the difference.  It compares members with a differnt middle qualifier
- USERADCD if editing a member USER.Z25D.PROCLIB(MYPROC) (for example) , it checks the existance of the member ADCD.Z25D.PROCLIB(MYPROC) and invokes ISPF compare so you can see the difference. If compares members with different ADCD/USER HLQ.


## RACF processing - placeholder files in RACF subdirectory
### Certificate processing

- EXPCERT.JCL -  invokes lring rexx to generate the commands to export the certificate is the specified user's keyring 
- CERTIMP.JCL - run this on the newer system to imprort ther certificates and create the keyring
- LRING.rexx - rexx processing that issuse the RACDCERT command to list a users keyring and process the results/  
-   



### RACF database object
- RACFUNLO.JCL JCL to unload a RACF database - changed DCB information
- SORTRACF.JCL JCL to sort the output from the RACF unload
- DBSYNCJ.JCL to convert the unloaded RACF dataset into the ALT/ADD/DELET files 
- RACFONEL.rexx ISPF macro which converts the logical line into one physical line.  You can then select which records you want to process - for example pick a userid and get the define, and all the permit statements
- RACSPLIT ISPF edit macro to convert the "one line" format into width of 80 - or there abouts.   This can be used with ISPF compare to compare two different RACF databases.
