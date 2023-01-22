/*#################################################################################*\
    Vent_Ring.scad
	-----------------------------------------------------------------------------

	Developed by:			Richard A. Milewski
	Description:            
   	

	Version:                1.0
	Creation Date:          
	Modification Date:      
	Email:                  richard+scad@milewski.org
	Copyright 				©2022 by Richard A. Milewski
    License - CC-BY-NC      https://creativecommons.org/licenses/by-nc/3.0/ 

\*#################################################################################*/


/*#################################################################################*\
    
    Notes

\*#################################################################################*/


/*#################################################################################*\
    
    CONFIGURATION

\*#################################################################################*/
include <BOSL2/std.scad>

$fn = 72;

od = 116;
id = 104;
z1 = 1;
od2 = 106;
z2 = 6;

module hide_variables () {}  // variables below hidden from Customizer

/*#################################################################################*\
    
    Main

\*#################################################################################*/
	
 tube(od = od, id = id, h = z1, anchor = BOT);
 tube(od = od2, id = id, h = z2, anchor = BOT);

/*#################################################################################*\
    
    Modules

\*#################################################################################*/

module echo2(arg) {
	echo(str("\n\n", arg, "\n\n" ));
}