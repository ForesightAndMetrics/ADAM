## File header
*=============================================================================
_File_      : ADAMCodeLibraryParser.awk
_Author_    : Gideon Kruseman \(g.kruseman@cgiar.org\)
_Version_   : 1.0
_Date_      : 4/4/2022 4:24:10 PM
_Changed_   : 4/4/2022 4:24:13 PM
_Changed by_: Gideon Kruseman \(g.kruseman@cgiar.org\)
_Remarks_   :
*=============================================================================
## Purpose
The purpose of the AWK tool is to parse the ADAM code library and summaruize the files in a list together with the documentation.

## Required input
The tool reads an options file that contains the following options with specified content, see Table 1.

Table 1
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
**option            description**
_prefix_          number of directory levels between drive and ADAM root directory

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Output
The tool generates a file calledf myviewer.tmp containing the files in the 
*============================   End Of File   ================================