//$fs = 1;

dx = 2;
dy = 10;
dz = 50;

reso = 2;
dc = reso / 1.414;
fz = (2*8+1)*reso + 10;

es = dx+dx+reso/2 + 0.5;
r1 = 1.5;
r2 = 2.5;

module trou() {
	cylinder(dx, r1, r1, true);
	translate([0,0,dx/4]) cylinder(dx/2, r1, r2, true);
}

module fixe() {
	cube([dx,dy,dz], true);
	for(i = [-4 : 8]) {
		translate([dx/2,0,i*2])
		rotate(45,[0,1,0]) cube([dc,dy,dc], true);
	}
	translate([es,0,0])
	cube([dx,dy,fz-10], true);
	translate([es/2+dx/2,0,-9*reso]) cube([es,dy,2], true);
}

module mobile() {
	cube([dx,dy,fz], true);
	for(i = [-4 : 10]) {
		translate([dx/2,0,i*2])
		rotate(45,[0,1,0]) cube([dc,dy,dc], true);
	}
}

module adj() {
	translate([-(ax-dx)/2,0,0]) {
		difference() {
			union() {
				cube([ax,ay,az],true);	
				translate([0,-ay/2+dy+ar-ep,az/2]) rotate(90,[0,1,0]) {
					difference() {
						cylinder(ax, ar, ar, true);
						cylinder(ax, ar-ep, ar-ep, true);
					}
				}
			}
			translate([0,-ay/2+dy+(ar-ep),0]) {
				difference() {
					cube([ax,(ar-ep)*2,az], true);
					translate([0,1,0]) cube([ax,(ar-ep)*2 - 2,az], true);
				}
			}
		}
	}
}


difference() {
	fixe();
	translate([0,0,(dz/2-3)]) rotate(90,[0,1,0]) trou();
	translate([0,0,-(dz/2-3)]) rotate(90,[0,1,0]) trou();
}

ax = 5;
ay = 50;
az = 5;
ep = 1;
ar = 5;

color("Blue") {
	translate([dx+reso/2 + 0.25,0,0]) {
		difference() {
			translate([0,0,reso/2+reso*4]) {
				rotate(180,[0,1,0]) mobile();
				translate([0,ay/2-dy/2,fz/2+az/2]) adj();
			}
			translate([1.25 - ax / 2,0,reso/2+reso*4 + fz/2+az/2]) {
			# rotate(90,[1,0,0]) cylinder(dy, 1.25, 1.25, true);
			}
		}
	}
}
