$fa = 1;
$fs = 1;
s = 50;
t = 0.4;
w = 2;
vd = 4 / 2;

module support() {
   ch1 = 15 / 2 + 4;
   ch2 = 15 / 2;
   translate([0, 0, ch1/2]) {
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
}

module bride(x, y) {
   translate([x, y, 10]) cube([2,4,20], true);
}
   p = 4;

difference() {
	union() {
	cube([s,s,w]);
		translate([9+3, s/2, 0]) {
			support();
		}
	}
   bride(3, 18);
   bride(21, 18);
   bride(3, 32);
   bride(21, 32);
	vis(p, p);
	vis(s-p, p);
	vis(s-p, s-p);
	vis(p, s-p);
	translate([s/2 + 9, s/2 + 9, w/2]) cube([20, 20, w], true);
}

