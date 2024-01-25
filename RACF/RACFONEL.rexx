/* REXX */
/* rexx */
/*
exec to convert dbsync files into one lines
*/
ADDRESS ISPEXEC
'ISREDIT MACRO'
  "ISREDIT    (l) = LINENUM .ZLAST"
  trace o
do i = 6 to l       by 1
    "ISREDIT      ( data )  = LINE   " i
    d.i = data
end
  "ISREDIT delete all .zfirst  .zlast"
  q = ""
  trace o
  do i = 6 to l
    d = strip(d.i,'T')
    parse var d . '"'e'"'   .
    len = length(d  )
    q = q || e                 /* remove trailing ,*/
    if substr(d,len,1) = ","
    then
    do
   /* say "within a line " q */
    end
    else
    do   /*end of line  */
      op = q
      "isredit line_after .zlast=(op)"
      q = ""
    end
  end
  /*
  "ISREDIT    (l) = LINENUM .ZLAST"
  "ISREDIT change '         )' ')' All"
  "ISREDIT change  '        )' ')' All"
  "ISREDIT change   '       )' ')' All"
  "ISREDIT change    '      )' ')' All"
  "ISREDIT change     '     )' ')' All"
  "ISREDIT change      '    )' ')' All"
  "ISREDIT change       '   )' ')' All"
  "ISREDIT change        '  )' ')' All"
  */
  "ISREDIT sort 1 60 "
  "ISREDIT exclude all"
  "ISREDIT find 'racdcert' all"
  "ISREDIT delete all nx"
  "ISREDIT reset"
