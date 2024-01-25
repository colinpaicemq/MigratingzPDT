//IBMRUNL JOB 1,MSGCLASS=H                                              00010000
// SET DD='COLIN.RACF.C5.UNLOAD.OLD'                                    00011002
//S1 EXEC PGM=IEFBR14                                                   00020000
//OUTDD DD DISP=(MOD,DELETE),DSN=&DD,                                   00030001
//         SPACE=(CYL,(1,1)),DCB=(LRECL=4096,RECFM=VB,BLKSIZE=13030)    00040000
//*                                                                     00050000
//UNLOAD EXEC PGM=IRRDBU00,PARM=NOLOCKINPUT                             00090000
//SYSPRINT DD SYSOUT=*                                                  00100000
//INDD1 DD DISP=SHR,DSN=SYS1.RACFDS                                     00110000
//OUTDD DD DISP=(NEW,CATLG),DSN=&DD,                                    00120001
//         SPACE=(CYL,(1,1)),DCB=(LRECL=4096,RECFM=VB,BLKSIZE=13030)    00130000
//                                                                      00141000
//OUTDD DD DISP=(NEW,CATLG),DSN=IBMUSER.RACF.UNLOAD.D5,VOL=SER=SARES1,  00150000
//         SPACE=(CYL,(1,1)),DCB=(LRECL=4096,RECFM=VB,BLKSIZE=13030),   00160000
//         UNIT=3390                                                    00170000
