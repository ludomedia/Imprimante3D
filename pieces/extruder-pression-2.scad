t = 0.5;

mx = 130;
my = 60;
mz = 27;
//piston
px = 50;
py = 30;
pz = 17;
phalf = (my-py)/2;
pe = 5;
piny = py - 2 * pe;

// guide
gx = 17;
gz = 17;
gzpos = 5; // todo mesurer

// motor
mot_e = 31 / 2;
mot_vd = 3.5 / 2 + t;
mot_z = mz - pz;

module base() {
	difference() {
		cube([mx,my,mz]);
		translate([0,0,mz-gz]) {
			cube([mx-px-gx,my,gz]);
			translate([mx-px-gx,phalf+pe,0]) cube([mx-px-gx-pe,piny,pz]);
		}
		translate([mx-px,0,0]) cube([mx-px,phalf,mz]);
		translate([mx-px,my-phalf,0]) cube([mx-px,phalf,mz]);
		translate([mx-px-gx/2,0,mz-pz+gzpos]) rotate(-90, [1,0,0]) # cylinder(my, 2.5, 2.5);
	}
}

module vis(x, y) {
	translate([x,y,0]) cylinder(mot_z, mot_vd, mot_vd);
}

module motor() {
	vis(mot_e, mot_e);
	vis(mot_e, -mot_e);
	vis(-mot_e, mot_e);
	vis(-mot_e, -mot_e);
	cylinder(mot_z, 5, 5);
}

difference() {
	base();
	translate([10, my/2, 0]) rotate(45, [0,0,1]) # motor();
}
