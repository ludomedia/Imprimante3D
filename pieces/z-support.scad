$fa = 1;
$fs = 1;
s = 50;
t = 0.4;
w = 2;
vd = 3.2 / 2;
ch1 = 15 / 2 + 4;

module support(x, y) {
  
   ch2 = 15 / 2;
   translate([x, y, ch1/2]) {
		difference() {
			cube([18,28,ch1], true);
			translate([0, 0, ch2/2]) {
				rotate(90, [1, 0, 0]) {
				   cylinder(24 + 2 * t, 15/2 + t, 15/2 + t, true);
					cylinder(28, 6, 6, true);
				}
			}
		}
	}
}

module vis(x, y) {
   translate([x, y, w/2]) cylinder(w, vd, vd, true);
   translate([x, y, w/2 + w/4]) # cylinder(w/2, vd, vd + 1, true);
}

module bride(x, y) {
   translate([x, y, ch1/2]) cube([2,4,ch1], true);
}

module debride(x, y) {
   translate([x, y, 0]) {
		bride(-9, -9); vis(-16, -9);
		bride(-9, 9); vis(-16, 9);
		bride(9, -9); vis(16, -9);
		bride(9, 9); vis(16, 9);
	}
}

   p = 4;

difference() {
	union() {
		translate([0, 0, w/2]) cube([146,80,w], true);
		translate([-50, -26, 0]) {
			support(0, 0);
			support(0, 52);
			support(100, 0);
			support(100, 52);
		}
	}
	translate([-50, -26, 0]) {
		debride(0, 0);
		debride(0, 52);
		debride(100, 0);
		debride(100, 52);		
	}
	/*   bride(3, 18);
   bride(21, 18);
   bride(3, 32);
   bride(21, 32);
*/	
	translate([0, 10, w/2]) cube([54, 60, w], true);
}

