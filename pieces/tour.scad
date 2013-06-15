mg = 0; //0.7;

bh = 50;

module tour() {
	translate([-15, -15, 0])
	difference() {
	   cube([30, 30,  bh], false);
		translate([5, 15, 10]) {
		rotate(90, [0, 1, 0]) {
			  # cylinder(26, 4 + mg, 4 + mg, false);
			}
		}
		translate([0, 5, bh - 30])
		# cube([30, 16, 30]);
		translate([15, 0, bh - 10]) {
		rotate(270, [1, 0, 0]) {
  	   # cylinder(30, 2.5 + mg, 2.5 + mg, false);
		}
		}
	}
}


tour();
rotate(180, [1, 0, 0]) {
	rotate(90, [0, 0, 1])
	tour();
}

/*
module socle_roulement() {
	difference() {
		cube([20, 24, 10]);
		translate([10, 12, 10]) {
		  rotate(90, [1, 0, 0]) {
		    cylinder(20 + mg, 7.5 + mg, 7.5 + mg, true);
		    cylinder(24, 6 + mg, 6 + mg, true);
		  }			
		}
		translate([0, 3, 0]) cube([1, 3, 10]);		
		translate([19, 3, 0]) cube([1, 3, 10]);		
		translate([0, 24-3-3, 0]) cube([1, 3, 10]);		
		translate([19, 24-3-3, 0]) cube([1, 3, 10]);		
	}
}

module socle_barre() {
	difference() {
		translate([0, -6, 0]) {
			cube([10, 12, 10]);
		}
		translate([0, 0, 10]) {
			rotate(90, [0, 1, 0]) {
				cylinder(10, 4 + mg, 4 + mg);
			}
		}
		translate([3, -6, 0]) cube([3, 1, 10]);		
		translate([3, 6-1, 0]) cube([3, 1, 10]);		
	}
}

module support1() {

	union() {
		socle_roulement();
		translate([20, 12, 0]) {
			socle_barre();
			// cube([10, 24, 3]);
		}
	}
}

support1();
*/