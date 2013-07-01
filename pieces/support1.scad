//$fa = 0.01;
mg = 0.7;

module socle_roulement() {
	difference() {
		cube([20, 28, 10]);
		translate([10, 14, 10]) {
		  rotate(90, [1, 0, 0]) {
		   cylinder(24 + mg, 7.5 + mg, 7.5 + mg, true);
		   # cylinder(28, 6 + mg, 6 + mg, true);
		  }			
		}
		translate([0, 3, 0]) cube([1, 3, 10]);		
		translate([19, 3, 0]) cube([1, 3, 10]);		
		translate([0, 24-3-3, 0]) cube([1, 3, 10]);		
		translate([19, 28-3-3, 0]) cube([1, 3, 10]);		
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
		translate([20, 14, 0]) {
			socle_barre();
			// cube([10, 24, 3]);
		}
	}
}

support1();