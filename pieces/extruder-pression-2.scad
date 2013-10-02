t = 0.5;

mz = 10;

entre_axes = 39.75;

// guide
gy = 30;
ge = 4 + 5 * 2;

// motor
mot_e = 31 / 2;
mot_vd = 3.5 / 2 + t;
mot_vd2 = 6 / 2 + t;
mot_z = mz;

fila_r = 1.5 + 1 + t;
fila_h = 8.5;
fila_entre_axes = 4-0.5 + 3/2;

mx_offset = 40;
mx = mx_offset + entre_axes + fila_entre_axes + 11;
my = 60;
guide_ox = mx_offset + entre_axes + fila_entre_axes;
motor_ox = mx_offset;

//pression
sx = 19;
sy = 17;
sz = 38 + 20;
pz = 38;
rz = 19;
rr = 8 / 2 + t;
axe_clip = 1;

rax = sz+20;
ray = sx+1;
raz = sy+1;
rep = 5;

fix_r1 = 2.5 + t;
fix_r2 = 4.5 + t;
fix_s = 15;

top = mz+fila_h + sx/2 + 2 * rep;
echo("top=",top);

module vis(x, y) {
	translate([x,y,0]) {
		cylinder(mot_z, mot_vd, mot_vd);
		translate([0,0,2]) cylinder(3, mot_vd2, mot_vd1);
		cylinder(2, mot_vd2, mot_vd2);
	}
}

module motor() {
	vis(mot_e, mot_e);
	vis(mot_e, -mot_e);
	vis(-mot_e, mot_e);
	vis(-mot_e, -mot_e);
	cylinder(mot_z, 15, 15);
}

module guide() {
		difference() {
			translate([-ge/2, 0, -fila_h ]) % cube([ge, gy, top - mz]);
			rotate(-90,[1,0,0]) {
				translate([0, 0, gy-5]) # cylinder(5, 4+t, fila_r);
				# cylinder(gy - 5, 4 + t, 4 + t);
			}
		}
}

module pression() {
	color("Red") {
		rotate(-90,[0,1,0]) {
			rotate(90,[0,0,1]) {
				difference() {
					cube([sx, sy, pz], true);
					rotate(90,[0,0,1]) {
						translate([0, 0, (pz-11)/2]) cube([6, 20, 11], true);
						translate([0, 0, pz/2 - axe_clip]) rotate(90, [0, 1, 0]) {
							cylinder(sy-2, 4.1, 4.1, true);
						}
						translate([0, 0, -pz/2  + rz/2]) {
						  cylinder(rz, rr, rr, true);
						}
					}
					//translate([sx/2, 0, 0]) cube([sx,sy,sz], true);
				}
			}	
		}
	}
}

module fixressort() {
	color("Orange") {
		cube([5, sy, sx], true);
		translate([-15/2,0,0]) rotate(90,[0,1,0]) cylinder(20, 2.5, 2.5, true);	
	}
}

module rail() {
	translate([0,-ray/2,0]) {
		difference() {
			translate([0,-rep,0]) cube([rax+2*rep, ray+2*rep, top]);
			translate([0,0,top-raz-2*rep]) cube([rax, ray, raz]);
			translate([rax,ray/2,mz+fila_h]) rotate(90,[0,1,0]) {
				translate([-5,-8/2,rep/2]) cube([14,8,4]);
				cylinder(2*rep, 2+t, 2+t);
			}
		}
	}
}

module fixation() {
	difference() {
		cube([fix_s, fix_s, top], true);
		translate([0,0,-top/2]) cylinder(top, fix_r1, fix_r1);
		translate([0,0,-top/2+5]) cylinder(2, fix_r2, fix_r1);
		translate([0,0,-top/2]) cylinder(5, fix_r2, fix_r2);
	}
}

module piece() {
	difference() {
		union() {
			cube([mx,my,mz]);
			translate([0,my-20,0]) {					
				difference() {
					cube([10,20,mz + 43]);
					translate([0, 10, mz + 10])
						rotate(90,[0,1,0]) {
							cylinder(10,2.5+t,2.5+t);
							translate([-25,0,0]) cylinder(10,2.5+t,2.5+t);
						}
				}
			}
			translate([guide_ox, 20-gy, mz + fila_h]) {
				guide();
				translate([0, my+20, 0]) rotate(180,[0,0,1]) guide();
			}
			translate([guide_ox + ge/2 + fix_s / 2 + 4, 0,top/2]) {
				translate([0, 20-rep -fix_s / 2, 0]) fixation();
				translate([0, my-(20-rep -fix_s / 2), 0]) fixation();
			}
			translate([motor_ox + entre_axes - 10,my/2,0]) {
				translate([pz/2 + 20,0,mz+fila_h]) ! pression();
				translate([sz + 16,0,mz+fila_h]) fixressort();
				rail();
			}
		}
		translate([motor_ox, my/2, 0]) {
			rotate(45, [0,0,1]) motor();
		}
		translate([motor_ox + entre_axes,my/2,0]) {
			cylinder(top, 7+t/2, 7+t/2);
			translate([0,0,mz-5]) cylinder(5, 8+t/2, 8+t/2);
			translate([0,0,top-2*rep]) cylinder(5, 8+t/2, 8+t/2);
		}
		translate([20,-25,0]) rotate(45,[0,0,1]) cube([32,65,mz]);
		translate([mx,my/2-7.5,3]) cube([55,15,mz-3]);
		translate([73,-10,0]) cylinder(mz, 25, 25);
		translate([73,my+10,0]) cylinder(mz, 25, 25);
	}
}

translate([-mx/2,-my/2,0]) {

	//intersection() {
	//	translate([70 ,my/2,5]) {
	//		# cube([40, 20, 10], true);
	//	}
	intersection() {
		piece();
		translate([mx+20 ,my/2,top/2 + mz + 0.01]) {
		  cube([30 + rax+2*rep, my + 20.1, top], true);
		}
	}
	//}
}