$fa = 1;
$fs = 1;

t = 0.4;

w = 50;
h = 40;
d = 20;

difference() {
	translate([0, 0, h/2]) {
		cube([w, d, h], true);
	}
	translate([0, -2, 0]) {
		translate([0, 0, 5])	cylinder(10, 2.5 + t, 3.5 + t);
		cylinder(5, 8 + t, 8 + t);
		translate([-2.5, -8, 0 ]) cube([5, 8 + t, 5]);
		translate([0, 0, h - 25]) cylinder(25, 4 + t, 4 + t);
	}
	translate([0, 0, 5+(h-10)/2]) {
		translate([-15, 0, 0]) {
			cube([10,d,h-10], true);
			cylinder(h, 2.5+t, 2.5+t);
		}
		translate([15, 0, 0]) {
			cube([10,d,h-10], true);
			cylinder(h, 2.5+t, 2.5+t);
		}
	}
	translate([(w-5)/2, 0, 0]) {
		translate([0, 0, 27.5 + (1.6+t) - 18 - 2]) {
			rotate(90, [0, 1, 0]) cylinder(5, 1.6+t, 1.6+t, true);
		}
		translate([0, 0, 47.5 + (1.6+t) - 18 - 2]) {
			rotate(90, [0, 1, 0]) cylinder(5, 1.6+t, 1.6+t, true);
		}
	}

	translate([-(w-5)/2, 0, 0]) {
		translate([0, 0, 28.5 + (1.6+t) - 18 - 2]) {
			rotate(90, [0, 1, 0]) cylinder(5, 1.6+t, 1.6+t, true);
		}
		translate([0, 0, 48.4 + (1.6+t) - 18 - 2]) {
			rotate(90, [0, 1, 0]) cylinder(5, 1.6+t, 1.6+t, true);
		}
	}
}

/*module haut(d) {
	translate([0, 0, d/2]) {
		difference() {
			union() {
				translate([(w-mot)/2,0,0]) cube([w, h, d], true); 
				translate([daxepla, -h/2, 6 - d/2]) cube([12, 24, 12], true); 
			}
			translate([0, 0, -d/2]) {
				cylinder(d, 6.5 + t, 6.5 + t);
				translate([daxe, 0, 0]) {
					cylinder(d, 4 + t, 4 + t);
				}
			}
			vis(-vp, vp);
			vis(-vp, -vp);
			vis(vp, vp);
			vis(vp, -vp);
			translate([daxepla, -h/2 -1, 6 - d/2]) {
				rotate(90, [1, 0, 0]) {
					cylinder(22, 4+t, 4+t, true);
					cylinder(28, 3+t, 3+t, true);
				}
			}
		}
	}
}
*/

