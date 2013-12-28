/* Tête de vis six pans
	d = distance plat à plat opposé. 
 	h = épaisseur de l'écrou 
*/
module sixpans(d, h) {

	for(i=[0:60:120]) 
	rotate(i+30, [0,0,1]) cube([d,d*tan(30),h], true);
}

/* Ovale plat (pour trous coulissants)
	d = diamètre du trou
   l = longueur du trou 
	h = épaisseur du trou
*/
module ovale(d, l, h) {
	translate([-(l-d)/2,0,0]) cylinder(h, d/2, d/2, true);
	translate([(l-d)/2,0,0])	cylinder(h, d/2, d/2, true);
	cube([l-d,d,h],true);
}

/* Trous pour un moteur Nama 17
	h = épaisseur des trous
	j = jeu de glissement
*/
module nema17(h, j) {
	translate([-15.5,-15.5,0]) ovale(4, 4 + j, h);
	translate([ 15.5,-15.5,0]) ovale(4, 4 + j, h);
	translate([-15.5, 15.5,0]) ovale(4, 4 + j, h);
	translate([ 15.5, 15.5,0]) ovale(4, 4 + j, h);
	ovale(24, 24 + j, h);
}

/* Vis six pans
	de = distance plat à plat opposé de la tête
 	he = épaisseur de la tête
	dv = diamètre de la vis
	l = longueur totale de la vis
*/
module vissixpans(de, he, dv, l) {
	translate([0,0,he/2]) sixpans(de, he);
	cylinder(l, dv/2,dv/2);
}

/* vis à tete cylindrique et son écrou six pans
	m = metric 3 = M3, 4 = M4, etc.
	h = longueur totale de la vis
*/
module vis_noyee(m, h) {
	if(m==3) {
		cylinder(3, 6.5/2, 6.5/2);
		cylinder(h, 3.8/2, 3.8/2);
		translate([0,0,h-3/2]) sixpans(5.9, 3);
	}
	else if(m==4) {
		cylinder(4, 8.5/2, 8.5/2);
		cylinder(h, 4.4/2, 4.4/2);
		translate([0,0,h-4/2]) sixpans(7.5, 4);
	}
	else if(m==5) {
		cylinder(5, 10.5/2, 10.5/2);
		cylinder(h, 5.5/2, 5.5/2);
		translate([0,0,h-5/2]) sixpans(8.5, 5);

	}
}

//vissixpans(6, 3, 3, 20);
// nema17(5, 4);
//ovale(5, 10, 3);
//sixpans(8, 3);