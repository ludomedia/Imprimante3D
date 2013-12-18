$fa = 1;
$fs = 1;

t = 0.4;
h = 5;
r = 16.5/2;

module hotend() {
	difference() {
		cylinder(28, r, r);
		/*translate([0,0,5]) {
			difference() {
				cylinder(4.5, r, r);
				cylinder(4.5, 12.5/2, 12.5/2);
			}
		}*/
	}	
	translate([0,0,5+3.5/2]) {
		translate([7.5, 10, 0]) rotate(90, [1,0,0]) cylinder(20, 3.5/2, 3.5/2);
		translate([-7.5, 10, 0]) rotate(90, [1,0,0]) cylinder(20, 3.5/2, 3.5/2);
	}
}

module fixtube(h, h2) {
	translate([-12,  -10.5/2, h2]) {
		cube([12 + 6, 10.5, 5.3]);
		//cube([5.3, fy + 6, 10.5]);
	}
	// translate([-b1,-fy,-tr]) cube([b1,fy,tr*2]);
	// translate([5.3/2,-fy,-tr]) cube([5,fy,tr*2]);
	cylinder(h, 3.3, 3.3);
	//rotate(270, [0,1,0]) cylinder(b1, tr, tr);
}

module aircache() {
	difference() {
		union() {
			translate([0, 15 + 2, 0]) cylinder(38, 10, 10);	
			translate([-10,0,0]) cube([20,18,38]);
		}
		union() {
			translate([0, 15 + 2, 0]) {
				cylinder(36-9, 9, 9);	
				translate([0, 0, 36 - 9]) sphere(9);	
			}
			translate([-8.5,0,0]) cube([17,17,36-9]);
			translate([0,18,36-9]) rotate(90,[1,0,0]) # cylinder(18, 8.5, 8.5);
		}
	}
}

difference() {

	union() {

		translate([0,0,h]) {
			cylinder(10+11.5, r + 3, r + 3);
			aircache();
		}

		/*translate([0,0, 20]) {
			difference() {
				cylinder(5, r + 3, r + 3);
				cylinder(5, r, r);
			}
		}*/
		rotate(45, [0,0,1]) translate([-22, -22, 0]) cube([44,44,h]);
	}

	# translate([0,0,15]) hotend();
	rotate(90, [0,0,1]) fixtube(15,5);

	translate([-25, -35, 0]) cube([50, 25, 50]);

	//cylinder(h, 4 + t, 4 + t);	
	translate([0, 15 + 2, 0]) cylinder(h, 7 + t, 7 + t);	
	translate([-15, 2, 0]) cylinder(h, 2.5+t, 2.5+t);		
	translate([15, 2, 0]) cylinder(h, 2.5+t, 2.5+t);
}
	

