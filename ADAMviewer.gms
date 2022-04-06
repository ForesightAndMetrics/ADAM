*<%REGION File header%>
*=============================================================================
* File      : ADAMviewer.gms
* Author    : Gideon Kruseman (g.kruseman@cgiar.org)
* Version   : 1.0
* Date      : 4/4/2022 11:38:43 AM
* Changed   : 4/5/2022 12:00:13 PM
* Changed by: Gideon Kruseman (g.kruseman@cgiar.org)
* Remarks   :
$ontext


$offtext
*=============================================================================
*<%/REGION File header%>
*! <%GTREE 1 initialization%>
*! <%GTREE 2 generate dir file%>

$call dir AdamCodeLibrary /S /B > Dir_AdamCodeLibrary.tmp
$onecho > AWK.opt
prefix 11
$offecho
$call awk -f  AdamCodeLibrary\AWK\ADAMCodeLibraryParser.awk  AWK.opt  Dir_AdamCodeLibrary.tmp
$call pause
$exit
*$include  Dir_AdamCodeLibrary.tmp
*$include  AdamCodeLibrary\AWK\ADAMCodeLibraryParser.awk
$ifi a==b $include  myviewer.tmp
$ifi a==b $include debug.tmp
*============================   End Of File   ================================