*<%REGION File header%>
*=============================================================================
* File      : ADAMcontrol.gms
* Author    : Gideon Kruseman (g.kruseman@cgiar.org)
* Version   : 1.0
* Date      : 4/2/2022 9:48:37 AM
* Changed   : 4/3/2022 6:01:08 PM
* Changed by: Gideon Kruseman (g.kruseman@cgiar.org)
* Remarks   :
$ontext

$offtext
*=============================================================================
*<%/REGION File header%>
*! <%GTREE 1 initialization%>
*?========================================================
*? trempoirary code
*?========================================================

$ifi dexist Documentation\ADAMCodeLibrary $goto next
$call md Documentation\ADAMCodeLibrary\ADAM
$call md Documentation\ADAMCodeLibrary\AWK
$call md Documentation\ADAMCodeLibrary\R
$label next

*?========================================================



*! <%GTREE 1.1 see latest error file%>
$ifi exist a==b $include ADAMControlerror.txt
$ifi not exist RunControl $call md RunControl

*! <%GTREE 1.2 test if ADAM components are available%>
*! <%GTREE 1.2.1 test libararies and documentation%>
$ifi not dexist ADAMCodeLibrary $goto Error_1_2_1_001
$ifi not dexist Documentation\ADAMCodeLibrary   $goto Error_1_2_1_002

*! <%GTREE 1.2.2 test Local ADAM settings%>
$ifi exist  RunControl\LocalAdamSettings.inc $goto LocalAdamSettingsExist
*! <%GTREECONTROL PARSE off%>
$onecho > RunControl\LocalAdamSettings.inc
*<%REGION File header%>
*=============================================================================
* File      : LocalAdamSettings.inc
* Template Author : Gideon Kruseman (g.kruseman@cgiar.org)
* Template date   : 4/2/2022
* Template version: 1.0
* Version   : 1.0
* Date      : %system.date% %system.time%
* Changed   :
* Changed by:
* Remarks   :
$ontext
This settings file contains some key local settings for ADAM.
- Projects folder   [ProjectsFolder]  has default
   The projects folder contains all relevant user inputs into ADAM based on the projects, data variant, and  scenario tree structure developed for QBGM and implemented in MAMBO (Kruseman et al, 2012). If the global control variable ProjectsFolder  is not defined then a projects folder "Projects" will be created in the ADAM root directory.
-
$offtext
*=============================================================================
*<%/REGION File header%>

*============================   End Of File   ================================
$offecho
*! <%GTREECONTROL PARSE on%>

$goto Error_1_2_2_001

$label LocalAdamSettingsExist

*! <%GTREE 1.2.3 test user settings%>
$ifi exist  RunControl\UserSettings.inc $goto ADAMUserSettingsExist
*! <%GTREECONTROL PARSE off%>
$onecho > RunControl\UserSettings.inc
*<%REGION File header%>
*=============================================================================
* File      : UserSettings.inc
* Template Author : Gideon Kruseman (g.kruseman@cgiar.org)
* Template date   : 4/2/2022
* Template version: 1.0
* Version   : 1.0
* Date      : %system.date% %system.time%
* Changed   :
* Changed by:
* Remarks   :
$ontext
This settings file contains some key user settings for ADAM.
- Project identifier   [ProjectID]
   Project identifier is used in the projects folder and contains all relevant user inputs into ADAM based on the projects, data variant, and  scenario tree structure developed for QBGM and implemented in MAMBO (Kruseman et al, 2012).
- Data variant identifier [DataVariantID]
- Screnario identifier [ScenarioID]
$offtext
*=============================================================================
*<%/REGION File header%>
$setglobal  ProjectID
$setglobal  DataVariantID
$setglobal  ScenarioID
*============================   End Of File   ================================
$offecho
*! <%GTREECONTROL PARSE on%>
$goto Error_1_2_3_001
$label ADAMUserSettingsExist

*! <%GTREE 1.3 read Local ADAM settings%>
$include RunControl\LocalAdamSettings.inc
$ifi not setglobal ProjectsFolder $goto ProjectFolderDefault
$ifi "%ProjectsFolder%"==""       $goto ProjectFolderDefault
$ifi not dexist %ProjectsFolder% $call md %ProjectsFolder%
$goto ProjectsFolderSet
$label ProjectFolderDefault
$ifi not dexist ProjectsFolder $call md ProjectsFolder
$label ProjectsFolderSet

*! <%GTREE 1.4 read user settings%>
$include RunControl\UserSettings.inc
$setlocal testlocal ok
$setlocal WriteLine ""
$ifi not setglobal ProjectID    $setlocal  testlocal bad
$ifi not setglobal ProjectID    $setlocal  WriteLine  %WriteLine% ProjectID
$ifi not setglobal DataVariantID    $setlocal  testlocal bad
$ifi not setglobal DataVariantID    $setlocal  WriteLine  %WriteLine% DataVariantID
$ifi not setglobal ScenarioID    $setlocal  testlocal bad
$ifi not setglobal ScenarioID    $setlocal  WriteLine  %WriteLine% ScenarioID
$ifi %testlocal%==bad $goto  Error_1_4_1_001

*! <%GTREE 88 END%>
$ifi exist ADAMControlerror.txt $call del ADAMControlerror.txt
$exit
*! <%GTREE 99 Error handling%>
*! <%GTREE 99.1 initialization errors%>
*! <%GTREE 99.1.1 initialization errors%>

*! <%GTREE 99.1.2 Adam component testing errors%>
*! <%GTREE 99.1.2.1 Whole libraries are missing%>
*! <%GTREE 99.1.2.1.001 Code library is missing%>
$label Error_1_2_1_001
$onecho > ADAMControlerror.txt
*=============================================================================
*              : %system.date% %system.time%
* Error number : 1.2.1.001
* Module       : %system.FN%%system.FE%
*=============================================================================
The ADAM code library could not be found. This is proabably due to an incomplete installation of ADAM.
Please reinstall ADAM

$offecho
$goto  Error_99_000

*! <%GTREE 99.1.2.1.002 Code library documentation is missing%>
$label Error_1_2_1_002
$onecho > ADAMControlerror.txt
*=============================================================================
*              : %system.date% %system.time%
* Error number : 1.2.1.002
* Module       : %system.FN%%system.FE%
*=============================================================================
The ADAM code library documentation could not be found. This is proabably due to an incomplete installation of ADAM.
Please reinstall ADAM

$offecho
$goto  Error_99_001

*! <%GTREE 99.1.2.2.001 ADAM local setting filr is missing is missing%>
$label Error_1_2_2_001
$onecho > ADAMControlerror.txt
*=============================================================================
*              : %system.date% %system.time%
* Error number : 1.2.2.001
* Module       : %system.FN%%system.FE%
*=============================================================================
The local ADAM settings file was missing. One has been created from the template and needs to be filled in if a different Projects
directory needs to be defined that is different from the default value.  The default is ProjectsFolder in teh ADAM root directory
$include RunControl\LocalADAMsettings.inc
$offecho
$goto  Error_99_001

*! <%GTREE 99.1.2.3.001 ADAM user settings file is missing%>
$label Error_1_2_3_001
$onecho > ADAMControlerror.txt
*=============================================================================
*              : %system.date% %system.time%
* Error number : 1.2.2.001
* Module       : %system.FN%%system.FE%
*=============================================================================
The ADAM user settings file was missing. One has been created from the template and needs to be filled in namely the vlaues for
the $setgobal control variables ProjectID, DataVariantID and ScenarioID
$include RunControl\UserSettings.inc
$offecho
$goto  Error_99_001


*! <%GTREE 99.1.4.1.001 missing user settings%>
$label Error_1_4_1_001
$onecho > ADAMControlerror.txt
*=============================================================================
*              : %system.date% %system.time%
* Error number : 1.4.1.001
* Module       : %system.FN%%system.FE%
*=============================================================================
The user settings file is not complete expecting $setglobal control variables for: ProjectID, DataVariantID and ScenarioID
The following $setglobal control variables are missing: %WriteLine%
please check: file
$include RunControl\UserSettings.inc
$offecho
$goto  Error_99_001


*! <%GTREE 99.99 Note at end of errorfile%>
$label Error_99_001
$onecho >>  ADAMControlerror.txt
*=============================================================================
Note:
ADAM uses GAMS as engine, some but not all of the modules in ADAM will work on a free license with limited solvers.
ADAM is optimized for use with GTREE integrated development environment:
     GTREE is currently not publicly downloadable
     A version can be obtained from g.kruseman@cgiar.org
*============================   End Of File   ================================
$offecho
$exit

*! <%GTREE 100 snippets and notes%>
$include documentation\ADAMCodeLibrary\test.md
*============================   End Of File   ================================