/* REXX */
/* rexx */
/*
exec to split long lines in dbsync output ( raconline)
*/
ADDRESS ISPEXEC
'ISREDIT MACRO'
"ISREDIT    (l) = LINENUM .ZLAST"
"ISREDIT change '  generic' ' generic' all"
"ISREDIT change  data('EST4') nodata all"
"ISREDIT change  '    group' 'group' all"
"ISREDIT change  '  special' 'special' all"
"ISREDIT change  '   operations' ' operations' all"
"ISREDIT change  '  omvs' 'omvs' all"
"ISREDIT change  '    grpacc' 'grpacc' all"
"ISREDIT change  '   group' ' group' all"
"ISREDIT change  '   stdata' ' stdata' all "
"ISREDIT change  '   special' ' special' all "
"ISREDIT change  'revoke' 'resume' all "
"ISREDIT c  rc'data\(.*\)'  nodata  all"
"ISREDIT c  rc'name\(.*\)'  name(zzzzz)  all"
/* replace the following with blanks because of not shifting */
"ISREDIT change  ' nopassword '  '            ' all "
do i = 1 to l
      "ISREDIT      ( q )  = LINE   " i
      q = strip(q,"T")
     bra = 0
     start = 1
     blanks = 0
     pad = ""
     do j = 1 to length(q)
       if substr(q,j,1) = '(' then bra= bra + 1
       else
       if substr(q,j,1) = ')' then bra= bra - 1
       else
       if substr(q,j,1) = ' ' & bra = 0  then
       do
          blanks = blanks + 1
          if  blanks > 2  then
          do
             if j-start > 1 then
             do
               op = pad|| substr(q,start,j-start) "-"
               "isredit line_after .zlast=(op)"
             end
             start = j
             pad = "   "
          end
        end
    end
    op = pad|| substr(q,start,j-start)
    "isredit line_after .zlast =(op)"
    q = ""
end
return
