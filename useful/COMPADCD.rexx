/* REXX */
/* rexx */
/*
exec to process class map
*/
ADDRESS ISPEXEC
'ISREDIT MACRO'
"ISREDIT (dsn)  = DATASET       "
"ISREDIT (member)  = MEMBER     "
parse var dsn prefix'.'middle'.'rest
nprefix = prefix
if middle = "Z24C" then middle  = "Z25D"
else
if middle = "Z25D" then middle  = "Z24C"

ndsn = prefix"."middle"."rest
ndsnm = ndsn"("member")"
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
