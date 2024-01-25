/* REXX */
/* exec to list the contents of a keyring
   This is run from JCL to create output files
   It creates several files
      OUTPUT  - the statements to export the certificates
      IMPORT  - The statements to import the certificates
      RING    - the statements to recreate the keyrings
*/
parse arg dsn userid password
if dsn="" then
do
 say "format is dsn <userid <password>> "
 say "   where DSN is the HLQ to use for exported certs"
 say "         userid is the userid that owns the ring "
 say "                defaults to the current userid "
 say "         password is the password to use for the export"
 return 8
end
address tso
if password = "" then
  passsword = "PASSW0RD"
fileout = "OUTPUT"
"EXECIO  0  DISKW "fileout" (OPEN"
if rc <> 0 then
do
  fileout = "SYSOUT"
  "EXECIO  0  DISKW "fileout" (OPEN"
end
fileimp = "IMPORT"
"EXECIO  0  DISKW "fileimp "(OPEN"
if rc <> 0 then
do
  fileimp = "SYSOUT"
  "EXECIO  0  DISKW "fileimp" (OPEN"
end
filering= "RING"
"EXECIO  0  DISKW "filering"(OPEN"
if rc <> 0 then
do
  filering= "SYSOUT"
  "EXECIO  0  DISKW "filering" (OPEN"
end
s.0 = 1
s.1  = "//         DD   *,SYMBOLS=JCLONLY"
"EXECIO  *  DISKW "fileout "(STEM s."
"EXECIO  *  DISKW "fileimp "(STEM s."
"EXECIO  *  DISKW "filering"(STEM s."
if userid = "" then userid =  SYSVAR("SYSUID")
if userid = "" then
   userid = "START1"
say "userid="userid"."
dsn = dsn"."userid
x = outtrap("var.")
"RACDCERT  LISTRING(*) ID("userid ")"
x = OUTTRAP('OFF')       /* turns trapping OFF */
if rc <> 0 then exit rc
do i = 7 to var.0
   if  substr(var.i,1,7) = "Digital" then
       parse var var.i . . . . . id":" .
   else
   if (substr(var.i,1,8) = "        >") then
      parse var var.i  . '>'ring'<' .
   else
   if (substr(var.i,1,6) = "  Cert") then nop;
   else
   if (substr(var.i,1,6) = "  Ring") then nop;
   else
   if (substr(var.i,1,6) = "  ----") then nop;
   else
   if substr(var.i,1,10) = "          " then nop;
   else
   do
        parse var var.i 3 name 38 owner 53 usage  66 default
        say id ring owner "'"name"'" usage default
        name = strip(name)
     if substr(name,1,6) <> "*** No" then
     do
       e.0 = 3
       owner = strip(owner,"B")
       e.1="RACDCERT EXPORT(LABEL('"name"')) - "
       e.2="   " owner "DSN('"dsn".C"i"')-"
       e.3="    FORMAT(PKCS12DER) password('"password"')"
       say "racdcert add('"dsn".C"i"')"owner "trust withlabel('"name"')",
           " password('&PASSWORD')"
      "EXECIO  *  DISKW "fileout "(STEM e."
       imp.0 = 2
       imp.1="RACDCERT ADD('"dsn".C"i"')" owner "-"
       imp.2="    TRUST withlabel('"name"') PASSWORD('&PASSWORD')"
       if default = "YES" then default = "DEFAULT"
       else default = " "
       usage = "usage("usage")"
      "EXECIO  *  DISKW "fileimp "(STEM imp."
       r.0 = 0
       r.1 = "RACDCERT ADDRING("ring") ID("userid")"
       r.2 = "RACDCERT ID("userid") CONNECT(RING("ring") -"
       r.3 = "    "owner default usage  " - "
       r.4 = "     LABEL('"name"')  )"
      "EXECIO  *  DISKW "filering"(STEM r."
     end
   end
end
"EXECIO  0  DISKW "fileout" (FINIS"
return 0
/*
export:
parse arg   count, userid, label
say "export" count userid label
return " "
*/
