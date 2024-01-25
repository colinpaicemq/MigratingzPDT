/* REXX */
/*
exec to copy a member from an ADCD. to a user.  dataset
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
"ISREDIT COPY '"ndsnm"' AFTER .ZFIRST"
