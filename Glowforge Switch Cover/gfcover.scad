/*#################################################################################*\
   GFcover.scad
	-----------------------------------------------------------------------------

	Developed by:			Richard A. Milewski
	Description:            Switch cover for the Glowforge
   	

	Version:                1.0
	Creation Date:          9 July 2023
	Modification Date:      
	Email:                  richard+scad@milewski.org
	Copyright 				©2023 by Richard A. Milewski
    License - CC-BY-NC      https://creativecommons.org/licenses/by-nc/3.0/ 

\*#################################################################################*/


/*#################################################################################*\
    
    Notes

	Requires the BOSL2 library for OpenSCAD  https://github.com/revarbat/BOSL2/wiki

\*#################################################################################*/

/*#################################################################################*\
    
    CONFIGURATION

\*#################################################################################*/
include <BOSL2/std.scad>	// https://github.com/revarbat/BOSL2/wiki

font = "Arial Black";				// font for text
fontsize = 6;						// font size
fontdepth = 2;						// font depth
linesize = 10;						// line spacing

d_button = 40.5;			// diameter of button
d_button_hole = 41.5;		// diameter of button hole

base = [60, 60, 3];			// base dimensions

hingeY = 5;				// hinge Y and Z dimensions
hinge_pin = 2.5;			// hinge pin diameter

top = [60, 60, 4];	// top plate dimensions

corner = 2;					// rounding radius for hinge corners
corner2 = 5;				// rounding radius for base corners

shift = base.x/2 + 5;	// shift for printing both parts at once

module hide_variables () {}  // variables below hidden from Customizer

hinge = [base.x, hingeY, base.z + top.z + 2];					// hinge dimensions
hinge_gap = [hinge.x - 10, hinge.y, hinge.z - base.z];	// center gap in hinge
base_hinge_hole = [base.x, hinge_pin + 0.5];	// base hinge hole dimensions [l, dia]

top_hinge = [hinge_gap.x - 1, top.z+1, top.z];	// top hinge dimensions
top_hinge_hole = [top_hinge.x, 2];	// top hinge hole dimensions [l, dia]

base_pivot_point = (hinge.z - hinge_pin);	// pivot point for base hinge


$fn = 72;               //openSCAD roundness variable
eps = 0.01;             //fudge factor to display holes properly in preview mode
$slop = 0.025;			//printer dependent fudge factor for nested parts
 
/*#################################################################################*\
    
    Main

\*#################################################################################*/
	
left(shift) top();
//right(shift) base();
/*#################################################################################*\
    
    Modules

\*#################################################################################*/

module blank_top () {
	diff("tp_remove") {
		cuboid(top, rounding = corner2, edges = "Z", except = (BACK), anchor = BOT);
		back(top.y/2) cuboid(top_hinge, rounding = top.z/2, edges = "X", except = (FWD), anchor = FWD + BOT);
		tag("tp_remove") back(top.y/2 + top_hinge.y/2) up(top.z/2) #xcyl(d = top_hinge_hole.y, l = top_hinge_hole.x);
		fwd(top.y/2) xscale(4) zcyl(d2 = 8, d1 = 1, h = top.z, anchor = BOT);
	}
}

module top () {
	blank_top();
	up (top.z) {
		back(linesize * 1.5) show_text("Turn on fan");
		back(linesize/2) show_text("before");
		fwd(linesize/2)  show_text("starting");
		fwd(linesize *1.5) show_text("Glowforge!");
	}
}

module show_text(my_text) {
	color ("blue") text3d(my_text, size = fontsize, h = fontdepth, font = font, anchor = CENTER);
}

module base() {
	diff("bp_remove") {
		cuboid(base, rounding = corner2, edges = "Z", except = (BACK), anchor = BOT)
		attach(BOT) tag("bp_remove") cyl(d = d_button_hole, h = base.z + eps, anchor = TOP);
		
	}
	diff("bp2_remove")	
		back(base.y/2){
			cuboid(hinge, rounding = corner, edges = "X", except = (BOT+FWD), anchor = FWD + BOT);
			tag("bp2_remove") up(base.z) cuboid(hinge_gap, anchor = FWD + BOT);
			tag("bp2_remove") back(hinge.y/2) up(base_pivot_point)
				 xcyl(h=base_hinge_hole.x, d=base_hinge_hole.y);
		}
}

module echo2(arg) {						// for debugging - puts space around the echo.
	echo(str("\n\n", arg, "\n\n" ));
}