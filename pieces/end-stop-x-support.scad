t = 0.4;
e = 3.5;
r1 = 1.2;
r2 = 2.5;
$fs = 1;

difference() {
	cube([21,28,e]);

	translate([10.5, 19.5, 0]) cylinder(e, r2 + t, r2 + t);
	translate([5.7, 7, 0]) {
		translate([10.4, 0, 0]) cylinder(e, r1 + t, r1 + t);
		cylinder(e, r1 + t, r1 + t);
	}
}