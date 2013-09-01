$fa = 1;
$fs = 1;

t = 0.4;

w = 55;
h = 15 - (2.2 / 2) - t - 0.5;
d = 67;
dx = -3;
dy = 3;
bh = 5;

bd = 3;

module support() {

difference() {
		translate([-w/2, -d/2, 0]) {
			difference() {
				cube([w, d, h]);
				translate([0, 0, bh]) cube([w, d - 14, h - bh]);
				translate([0, d - 14, bh]) rotate(60, [1, 0, 0]) # cube([w, 12, 12]);
				translate([37, -37, 0]) rotate(45, [0, 0, 1]) cube([80, 45, 5]);
				translate([2, -27, 0]) rotate(45, [0, 0, 1]) cube([30, 40, 5]);
				translate([2, -30, 0]) # cube([30, 40, 5]);
			}
		}


		translate([dx,-dy,0]) {
			rotate(45, [0, 0, 1]) {
				translate([0, -2, 0]) cylinder(h, 4 + t, 4 + t);	
				translate([0, 15, 0]) cylinder(h, 7 + t, 7 + t);	
				translate([-15, 0, 0]) cylinder(h, 2.5+t, 2.5+t);		
				translate([15, 0, 0]) cylinder(h, 2.5+t, 2.5+t);
			}
		}

		translate([-3.5/2, d/2 - (7.5+t) - 2 - bd , 0]) {
			translate([-20, 0, 0]) cube([3.5, bd, h]);
			translate([-5, 0, 0]) cube([3.5, bd, h]);
			translate([ 5, 0, 0]) cube([3.5, bd, h]);
			translate([ 20, 0, 0]) cube([3.5, bd, h]);
		}
		translate([0, d/2, h/2]) {
			rotate(90, [0, 1, 0]) {
				cylinder(2*24+t, 7.5+t, 7.5+t, true);
				cylinder(w+0.5, 5+t, 5+t, true);
			}
		}
	}
}

support();
// translate([-6, -6, -2]) rotate(180, [1, 0, 0]) rotate(90, [0, 0, 1]) support();