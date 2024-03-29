//IBMUSERR JOB 1,MSGCLASS=H
// SET DD1='COLIN.RACF.C4.UNLOAD'
// SET DD2='COLIN.RACF.UNLOAD.C5'
//S1 EXEC PGM=IEFBR14
//OUTDD1 DD DISP=(MOD,DELETE),DSN=&DD1..SORT,
//         SPACE=(CYL,(1,1)),DCB=(LRECL=4096,RECFM=VB,BLKSIZE=13030)
//OUTDD2  DD DISP=(MOD,DELETE),DSN=&DD2..SORT.C4,
//         SPACE=(CYL,(1,1)),DCB=(LRECL=4096,RECFM=VB,BLKSIZE=13030)
//*
//SORT1   EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DISP=SHR,DSN=&DD1
//SORTOUT   DD DISP=(NEW,CATLG),SPACE=(CYL,(1,1)),
//          DSN=&DD1..SORT
//SYSIN   DD *
   SORT FIELDS=(5,2,CH,A,7,1,AQ,A,8,549,CH,A)
   ALTSEQ CODE=(F080,F181,F282,F383,F484,F585,F686,F787,F888,F989,
     C191,C292,C393,C494,C595,C696,C797,C898,C999,
     D1A1,D2A2,D3A3,D4A4,D5A5,D6A6,D7A7,D8A8,D9A9,
     E2B2,E3B3,E4B4,E5B5,E6B6,E7B7,E8B8,E9B9)
    OPTION   VLSHRT,DYNALLOC=(SYSDA,3)
//SORT2   EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//*ORTIN    DD DISP=SHR,DSN=IBMUSER.RACF.UNLOAD.D5,VOL=SER=SARES1,
//*            UNIT=3390
//SORTIN    DD DISP=SHR,DSN=&DD2
//SORTOUT   DD DISP=(NEW,CATLG),SPACE=(CYL,(1,1)),
//          DSN=&DD2..SORT.C4
//SYSIN   DD *
   SORT FIELDS=(5,2,CH,A,7,1,AQ,A,8,549,CH,A)
   ALTSEQ CODE=(F080,F181,F282,F383,F484,F585,F686,F787,F888,F989,
     C191,C292,C393,C494,C595,C696,C797,C898,C999,
     D1A1,D2A2,D3A3,D4A4,D5A5,D6A6,D7A7,D8A8,D9A9,
     E2B2,E3B3,E4B4,E5B5,E6B6,E7B7,E8B8,E9B9)
    OPTION   VLSHRT,DYNALLOC=(SYSDA,3)
