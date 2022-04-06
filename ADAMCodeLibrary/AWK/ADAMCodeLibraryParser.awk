#<%REGION File header%>
#=============================================================================
# File      : ADAMCodeLibraryParser.awk
# Author    : Gideon Kruseman (g.kruseman@cgiar.org)
# Version   : 1.0
# Date      : 4/4/2022 11:47:48 AM
# Changed   : 4/5/2022 12:09:13 PM
# Changed by: Gideon Kruseman (g.kruseman@cgiar.org)
# Remarks   :
#*! <%GTREECONTROL IGNORE IGNORE $include %>
#*! <%GTREECONTROL $include off%>

#=============================================================================
#<%/REGION File header%>
$0 && FILENAME=="AWK.opt" {
    option[$1]=$2
    for (i=3;i<=NF;i++) {
        option[$1]=option[$1] " " $i
       }
    print "option [" $1 "]: " option[$1]
    ReadOption=1
   }

$0 && FILENAME!="AWK.opt" {
    split($0,ADAMCodeLibraryItem,"\\")
    CurrentLine=ADAMCodeLibraryItem[option["prefix"]-1]
    skip=1
    for (i=option["prefix"];ADAMCodeLibraryItem[i+1];i++) {
        if (ADAMCodeLibraryItem[i]=="Backup") {
             i=1000
             skip=1
             CurrentLine=""
            }
        else if (ADAMCodeLibraryItem[i]=="") {
             i=1000
             skip=1
             CurrentLine=""
            }
        else {
            CurrentLine= CurrentLine "\\"  ADAMCodeLibraryItem[i]
            skip=0
           }
       }
    if (skip==0) {
       if((ADAMCodeLibraryItem[i]!="") && ADAMCodeLibraryItem[i]!="Backup") {
          if (ADAMCodeLibraryItem[i-1]=="AWK" || ADAMCodeLibraryItem[i-1]=="R" || ADAMCodeLibraryItem[i-1]=="GMS")  {
              if(uniqueCLcnt[CurrentLine]=="") {
                  uniqueCLcnt[CurrentLine]=++cntUniqueCL
                  uniqueCL[cntUniqueCL]= CurrentLine
                 }
              leaves[uniqueCLcnt[CurrentLine],++obs[uniqueCLcnt[CurrentLine]]]=ADAMCodeLibraryItem[i]
              for (j=1;j<=i-option["prefix"];j++) {
                  if (j > maxj) {maxj=j}
                  if (uniqueLcnt[j,ADAMCodeLibraryItem[option["prefix"]-1+j]]=="") {
                      uniqueLcnt[j,ADAMCodeLibraryItem[option["prefix"]-1+j]]=++levelCnt[j]
                      uniqueLval[j,levelCnt[j]]=ADAMCodeLibraryItem[option["prefix"]-1+j]
                     }
                  branch[j,uniqueLcnt[j,ADAMCodeLibraryItem[option["prefix"]-1+j]]]=uniqueCLcnt[CurrentLine]
                 }

             }

          print  "$include " CurrentLine "\\" ADAMCodeLibraryItem[i]    > "myviewer.tmp"
          print  "$include Documentation\\" CurrentLine "\\" ADAMCodeLibraryItem[i]  ".MD"  > "myviewer.tmp"
         }
      }
   }

END {
#    for (i=1;i<=levelCnt[1];i++) {
#*! <%GTREECONTROL Parse off%>
 #       print "*! <%G" "TREE " i "  " uniqueLval[1,i] "%>"            > "debug.tmp"
#*! <%GTREECONTROL Parse on%>
        for (j=1;j<=maxj;j++) {
            for (k=1;k<=levelCnt[j];k++)  {
                if (branch[j,k]!="") {print "j: " j "  k: " k " ==> branch[j,k]: " branch[j,k]  > "debug.tmp" }
               }

           }
#       }

   }
#*! <%GTREECONTROL $include on%>
#============================   End Of File   ================================