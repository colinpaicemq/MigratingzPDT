# MigratingzPDT
Files used to migrate to a new level of z/OS on zPDT and ADCD

## This is a repository of files I used to migrate from z24c to z25D


## Useful  ISPF edit macros
- COPYADCD Edit an empty member in a  USER.*.something dataset. If the dataset is USER.... then copy the member form ADCD.....   If the dataset is ADCD.... then copy the member from USER.....
- COMPADCD if editing a member USER.Z25D.PROCLIB(MYPROC) (for example) , it checks the existance of the member USER.Z24C.PROCLIB(MYPROC) and invokes ISPF compare so you can see the difference.  It compares members with a differnt middle qualifier
- USERADCD if editing a member USER.Z25D.PROCLIB(MYPROC) (for example) , it checks the existance of the member ADCD.Z25D.PROCLIB(MYPROC) and invokes ISPF compare so you can see the difference. If compares members with different ADCD/USER HLQ.

## USER.*.PARMLIB
- AUTORCP - automatic message reply. Add MSGID(BPXI078D)  
- BPXPRMCP add  KERNELSTACKS(ABOVE)  
- BPXPRMTC configure for TCPIP add FILESYSTYPE TYPE(CINET), TCPIP2, TCPIP3, TCPIP4 
- BPXPRMUS mount user ZFS
- CLOCK00 set time zone to GMT 
CONSOL00
- COUPLE00 add FUNCTIONS ENABLE(XTCSIZE) to stop health check complaining- 
- CSFPRM00 add my CSF CKDS and PKDS and add a TKDS
- HZSPRMCP
- HZSPRMUS configuring for health check, removing sysplex only
- IEASYM00 add symbols for TCPIP
- IEASYS00 change AUTOR=(00,AD), add DEVSUP, change IZU=NO, change OMVS=(TC,00,01,BP,IZ,RZ,BB,ZW,US (add TC,US) PROG= add CP,MF, change SCH=(00,ZW,MF)
- IGDSMS00 Add entries for PDSE and PDSE1 
- IKJTSO00 Add LOGON PASSPHRASE(ON)  for MFA.  Add CSFDPKDS to AUTHPGG add cSFDPKDs to AUTHTSF
- IVTPRM00 add FIXED MAX(512M) HVCOMM(2000M)    for health checker  
- PFKTAB00 specify my PFKeys for the console
- PROGA0
- PROGA0  
- PROGCP  
- PROGL0  
- PROGMF  
- SCHEDMF for MFA
- SCHED00 add NOSYST for TCPIP because there are now more than one program in the job.
- SHUTCP My tailored shutdown commands- 
- VTAM00 - commands executed as part of IPL.  K A,NONE,L=L700 to make screen rollable by default, and $T CKPTDEF,OPVERIFY=NO fora health check     


## RACF processing - placeholder files in RACF subdirectory
### Certificate processing

- EXPCERT.JCL -  invokes lring rexx to generate the commands to export the certificate is the specified user's keyring 
- CERTIMP.JCL - run this on the newer system to imprort ther certificates and create the keyring
- LRING.rexx - rexx processing that issuse the RACDCERT command to list a users keyring and process the results/  
- DELOCERT.SYSIN - RACDCERT DELETE  statements for expired certificates owned by CERTAUTH - as reported by health checker
  



### RACF database object
- RACFUNLO.JCL JCL to unload a RACF database - changed DCB information
- SORTRACF.JCL JCL to sort the output from the RACF unload
- DBSYNCJ.JCL to convert the unloaded RACF dataset into the ALT/ADD/DELET files 
- RACFONEL.rexx ISPF macro which converts the logical line into one physical line.  You can then select which records you want to process - for example pick a userid and get the define, and all the permit statements
- RACSPLIT ISPF edit macro to convert the "one line" format into width of 80 - or there abouts.   This can be used with ISPF compare to compare two different RACF databases.
