

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

module base() {
	difference() {
		cube([mx,my,mz]);
		translate([0,0,mz-gz]) {
			cube([mx-px-gx,my,gz]);
			translate([mx-px-gx,phalf+pe,0]) # cube([mx-px-gx-pe,piny,pz]);
		}
		translate([mx-px,0,0]) cube([mx-px,phalf,mz]);
		translate([mx-px,my-phalf,0]) cube([mx-px,phalf,mz]);
	}
}

base();
