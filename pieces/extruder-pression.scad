
//$fs = 1;
imp = 0.5;

sx = 17;
sy = 17;
sz = 38;
t = 0.4;

rz = 20;
rr = 8 / 2 + t;
axe_clip = 1;

mz = 10;
mx = 130;
my = 60;
roulement_offset = 14.7-6.25+8;
pression_offset = sz + roulement_offset - axe_clip;

module pression() {
	translate([0, 0, sz/2]) {
		difference() {
			cube([sx, sy, sz], true);
			translate([0, 0, (sz-10)/2]) cube([6, 20, 10], true);
			translate([0, 0, sz/2 - axe_clip]) rotate(90, [0, 1, 0]) {
				cylinder(sx-2, 4 + t, 4 + t, true);
			}
			translate([0, 0, -sz/2  + rz/2]) {
				cylinder(rz, rr, rr, true);
				translate([0, 0, rz/2]) sphere(rr, true);
			}
			//translate([sx/2, 0, 0]) cube([sx,sy,sz], true);
		}
	}
}

module meca() {
	color("Black", 0.5) {
		translate([0, 0, mz]) {
			cylinder(12, 32, 32);
			translate([0,0,-mz-11]) cylinder(11, 6.25, 6.25);
	
			translate([roulement_offset,0,-mz-11]) cylinder(5, 8, 8);
			
			translate([-41, 0, 0]) {
				cylinder(12, 10, 10);
				translate([0, 0, -10]) cylinder(10, 7.5, 7.5);		
				rotate(45, [0,0,1]) translate([0, 0, -10-47/2-1]) cube([42,42,47], true);
			}
		}
	}
}

rail_ep = 5;
rail_mg = 0.5;
rail_mg2 = 2;
ecrou_w = 9;
ecrou_d = 3;
ecrou_dia = 10;

rail_z = sx + 2*rail_mg;
rail_y = sy+2*(rail_ep+rail_mg);
rail_d = 12 - (roulement_offset - floor(roulement_offset));
rail_x = sz + rail_d;

module rail() {
	translate([-rail_x/2 + rail_d + pression_offset, 0, -rail_z/2]) {
		difference() {
			cube([rail_x, rail_y, rail_z], true);
			translate([-(rail_d-rail_mg2)/2,0,0]) {
				cube([rail_x-rail_d+rail_mg2, rail_y-2*rail_ep, rail_z], true);
			}
			translate([rail_x/2 - rail_d + rail_mg2, 0,-rail_mg]) {
				rotate(90, [0,1,0]) cylinder(rail_d-rail_mg2+imp, 2.5+t, 2.5+t);
				translate([ecrou_d/2,0,-rail_z/2+ecrou_dia/2]) cube([ecrou_d, ecrou_w + t, rail_z], true);
			}
		}
	}
}

guide_z = 15;
guide_w = 15;
guide_l = 20;
guide_r = 4 + t;
guide_r2 = 2 + t;
guide_offset = 14.7 - 6.25 - 3/2;

module guide() {
	translate([0, -my/2 + guide_l/2,0]) {
		difference() {
			translate([guide_offset, 0, -guide_z/2]) {
				cube([guide_w, guide_l, guide_z], true);
			}
			translate([guide_offset, 0, -11+2.5]) {
				rotate(90, [1,0,0]) {
					cylinder(guide_l, guide_r2, guide_r2, true);
					translate([0,0,2]) # cylinder(guide_l, guide_r, guide_r, true);
				}
			}
		}
	}
	translate([0, my/2 - guide_l/2,0]) {
		difference() {
			translate([guide_offset, 0, -guide_z/2]) {
				cube([guide_w, guide_l, guide_z], true);
			}
			translate([guide_offset, 0, -11+2.5]) {
				rotate(90, [1,0,0]) {
					cylinder(guide_l, guide_r2, guide_r2, true);
					//# cylinder(guide_l, guide_r, guide_r, true);
				}
			}
		}
	}

}

color("Red") translate([pression_offset, 0, -11+5/2 - rail_mg]) rotate(-90, [0,1,0]) pression();
meca();
rail();
guide();

translate([0, 0, mz/2]) {
	cube([mx, my, mz], true);		
}
