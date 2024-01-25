/* REXX */
/* rexx */
/*
exec to compare user./adcd. members and hight light differences
*/
ADDRESS ISPEXEC
'ISREDIT MACRO'
"ISREDIT (dsn)  = DATASET       "
"ISREDIT (member)  = MEMBER     "
parse var dsn prefix'.' rest
nprefix = prefix
if prefix = "USER" then nprefix = "ADCD"
else
if prefix = "ADCD" then nprefix = "USER"

ndsn = nprefix"."rest
ndsnm = nprefix"."rest"("member")"
"ISPEXEC LMINIT DATAID(EDT) DATASET('"ndsn"')"
if rc <> 0 then
do
   zedsmsg = 'not found 'ndsn
   'ISPEXEC  SETMSG MSG(ISRZ001)'
   return
end
"ISPEXEC LMOPEN DATAID("EDT") OPTION(INPUT)"
"ISPEXEC LMMFIND  DATAID("EDT") MEMBER("member")"
if rc =  0 then
do
   "ISREDIT compare '"ndsnm"'   exclude"
end
else
do
   zedsmsg = 'member not found 'member
   zedlmsg = 'member not found 'member
   'ISPEXEC  SETMSG MSG(ISRZ001)'
end
"ISPEXEC LMCLOSE DATAID("EDT") "
"ISPEXEC LMFREE DATAID("EDT") "
