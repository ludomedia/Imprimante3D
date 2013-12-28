include <util.scad>;

$fa = 1;
$fs = 1;

sx = 60;
sy = 75;
sz = 34;

my = 20;
mx = 5;
mz = 5;

/* passage de la grosse visse */
ax = 31;
ay = my/2;

/* passage du filament */
fy = ay - 4;
fz = sz / 2;
fr = 2.5;

/* pression */
px = 50;
py = 75;
pz = sz - 10 - 1;
pe1 = 14;
pe2 = 14;
pinz = pz - 2 * 5;
pdy = 4;

raccord_y = 10; // position de la fixation entre le socle et la pression

entre_axes = 41; // axe moteur et axe grosse vis
entre_axes_2 = 4 - 0.5 + 3 + 11; // axe grosse vis et axe roulement de pression


module meca() {
	color("Black", 0.5) {
		cylinder(12, 32, 32);		
		cylinder(62, 4, 4);		
		translate([0, entre_axes, 0]) {
			cylinder(12, 10, 10);
			translate([0, 0, 10]) cylinder(10, 7.5, 7.5);		
			translate([0, 0, 20+47/2]) cube([42,42,47], true);
		}
		translate([0, -entre_axes_2, 20 + fz - mz]) {
			cylinder(7, 11, 11, true);
			cylinder(15, 3.9, 3.9, true);
		}
	}
}

module pression(view) {
	intersection() {
		translate([-20,-20,0]) {
			if(view==0) translate([0,0,-pz]) cube([px+40,py+40,2*pz]);
			else if(view==1) translate([0,0,-pz]) cube([px+40,py+40,pz]);
			else if(view==2) cube([px+40,py+40,pz]);
		}
		difference() {
			union() {
				translate([-43,-pdy,-pz/2]) {
					translate([35, 0,0]) {
						difference() {
							union() {
								translate([0,-pe2/2,0]) cube([px+pe1/2,pe2,pz]);	
								translate([px-pe1/2,-pe2/2+3,0]) rotate(-5,[0,0,1]) {
									cube([pe1,py+pe2/2,pz]);	
									translate([0,py-10,pz/2]) cube([16,pe2,pz],true); 
								}
							}
							translate([0,-pe2/2,(pz-pinz)/2]) cube([px+20,py-20,pinz]);
						}
					}
					translate([35 + px,0,pz/2]) cube([pe1,pe2,pz],true); 
					// cylinder(pz,10,10);		
				}
				cylinder(pz, 3.8, 3.8, true);
				difference() {
					cylinder(pz, 5.5, 5.5, true);
					// translate([-15/2,pe2/2-pdy,-15/2]) cube([15,25,15]);
					cube([15,15,7], true);
				}
			}
			//# cylinder(pz-2*3, 4, 4, true);
			translate([0,0,-pz/2]) {
				translate([0,0,0]) vis_noyee(3, pz);
				translate([-43+px+35,-pdy,0]) {
					vis_noyee(3, pz);
					rotate(-5,[0,0,1]) translate([0,py-5,0]) {
						vis_noyee(3, pz);
						translate([3,-10,pz/2]) rotate(-90,[0,1,0]) cylinder(30,5,5);
					}
				}
				translate([-ax+sx-7,entre_axes_2-ay-raccord_y,0]) cylinder(pz, 4.5/2, 4.5/2);
			}
	
		}
	}
}

module fixation(l) {
	translate([-13, 8, 0]) vissixpans(7, 5, 4.5, l);
	translate([-13,-8, 0]) vissixpans(7, 5, 4.5, l);
	translate([ 13,-8, 0]) vissixpans(7, 5, 4.5, l);
	translate([ 13, 8, 0]) vissixpans(7, 5, 4.5, l);
}

module fixtube(b1, b2, tr) {
	translate([-5.3/2, -fy,  -10.5/2]) {
		cube([5.3, fy + 6, 10.5]);
	}
	// translate([-b1,-fy,-tr]) cube([b1,fy,tr*2]);
	// translate([5.3/2,-fy,-tr]) cube([5,fy,tr*2]);
	rotate(90, [0,1,0]) cylinder(b2 + 5.3/2, tr, tr);
	rotate(270, [0,1,0]) cylinder(b1, tr, tr);
}

translate([ax,ay,-20+mz]) meca();
! translate([ax,-entre_axes_2+ay,fz]) pression(2);

difference() {
	cube([sx,sy,sz]);
	translate([0,my,mz]) {
		cube([sx-mx,sy-my,sz-mz]);
	}
	translate([ax,ay,0]) {
		cylinder(sz, 7, 7);
		cylinder(5, 8.2, 8.2);
		translate([0,0,sz-5]) cylinder(5, 8.2, 8.2);
	}
	//// translate([ax,my+0.1,sz/2]) rotate(90,[1,0,0]) fixation(my+0.2);
	translate([0,fy,fz]) rotate(90,[0,1,0]) cylinder(sx, fr, fr); // filament
	translate([ax,fy - 8,fz]) cylinder(8, 12, 12, true);
	translate([10, fy, fz]) fixtube(11, 12, 3.3);
 	translate([ax,ay + entre_axes,mz/2]) rotate(90, [0,0,1]) nema17(mz, 4);
	translate([sx-mx,52,sz/2]) # rotate(90,[0,1,0]) cylinder(mx,2,2);
	translate([0,43,0]) cube([41,sy-43,mz]);
}

translate([0,0,sz/2]) {
	difference() {
		translate([sx-14/2,-18/2,0]) cube([14,18,pinz-1],true);
		translate([sx-14/2,-raccord_y,0]) cylinder(pinz-1,2.5,2.5, true);
	}
}


