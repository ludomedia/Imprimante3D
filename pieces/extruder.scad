$fa = 1;
$fs = 1;

t = 0.4;

mot = 42;
w = 52;
h = mot;
vd = 3.5 / 2 + t;
d = 8;
vp = 31 / 2; //mot / 2 - 5;
daxe = 18.5;
daxepla = daxe-11-1.5;

print = 1;

module vis(x, y) {
	translate([x, y, 0]) cylinder(d, vd, vd, true);
}

module haut(d) {
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

module bas() {
	translate([0, 0, -d/2]) {
		difference() {
			translate([(w-mot)/2,0,0]) { cube([w, h, d], true); }
			translate([0, 0, -d/2]) {
				cylinder(d, 3.5 + t, 3.5 + t);
				cylinder(2 + t, 11 + t, 11 + t);
				translate([daxe, 0, 0]) {
					//cylinder(5.5 + t, 14.7/2 + t, 14.7/2 + t, $fn = 6);
					for ( i = [0 : 60 : 120] ) {
						rotate(i, [0,0,1]) cube([13, 8, 5.6], true);
					}
					cylinder(d, 4 + t, 4 + t);
				}
			}
			vis(-vp, vp);
			vis(-vp, -vp);
			vis(vp, vp);
			vis(vp, -vp);
		}
	}
}

if(print==0) {
	color("green") haut(3);
	color("red") bas();
}
else if(print==1) {
	haut(3);
}
else if(print==2) {
	rotate(180, [1, 0, 0]) bas();
}

