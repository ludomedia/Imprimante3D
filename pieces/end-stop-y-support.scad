t = 0.4;
e = 3.5;
r1 = 1.2;
r2 = 2.5;

difference() {
	cube([50,20,e]);

	translate([10, 13.5, 0]) cylinder(e, r2 + t, r2 + t);
	translate([35.5, 10, 0]) {
		translate([10.4, 0, 0]) cylinder(e, r1 + t, r1 + t);
		cylinder(e, r1 + t, r1 + t);
	}
}