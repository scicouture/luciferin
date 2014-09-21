thickness = 2.5;
bondlength = 7;
tweak = 2;
endcapradius = 3;
endcapholeradius = 1.2;
sphereradius = 3;

pentradius = bondlength * 5.3 / 6;
hexside = cos(30) * bondlength;
pentside = cos(180 / 5) * pentradius;

pentcenter = hexside + pentside - tweak;
interbondx = pentcenter + pentradius - tweak;
pent2center = interbondx + bondlength + pentradius - tweak;
bond1x = -1 * (bondlength + cos(30) * (bondlength - tweak) - tweak);
bond1y = bondlength / 2 + sin(30) * (bondlength - tweak) - tweak;
bond3x = pent2center + cos(30) * pentradius - tweak;
bond3y = -(sin(30) * pentradius + thickness/2);
bond4x = bond3x + cos(30) * bondlength;
bond4y = bond3y - sin(30) * bondlength;
hole2x = bond3x + 2 * cos(30) * bondlength;

cutbond = bondlength - thickness;
cutpent = pentradius - thickness;

//ring module forked from https://github.com/indysci-dot-org/9ds-pendant/blob/master/9DS.scad
ringthickness = 1.5;
ringcount = 40;

module ring(){
	for(i = [0:ringcount])
		rotate([0,0,360/ringcount * i])
			translate([-ringthickness/2,-bondlength/3,thickness/2])
				rotate([0,90,0])
					cylinder(h=ringthickness, r=endcapholeradius, $fn=40);
}


//////////////////////////////////////
union() {

difference() {
union(){
	//hexagon
	rotate(a=[0,0,30]){
		cylinder($fn = 6, r = bondlength, h = thickness);
	}

	//pentagon 1
	translate([pentcenter, 0, 0]){
		cylinder($fn = 5, r = pentradius, h = thickness);
	}

	//interbond between pentagons
	translate([interbondx, thickness / -2, 0]){
		cube([bondlength, thickness, thickness]);
	}

	//pentagon 2
	translate([pent2center, 0, 0]){
	rotate(a=[0,0,180/5]){
		cylinder($fn = 5, r = pentradius, h = thickness);
	}}

	//bond 1
	translate([bond1x, bond1y, 0]){
	rotate(a=[0,0,-30]){
		cube([bondlength - tweak, thickness, thickness]);
	}}

//	//hole 1
//	translate([bond1x, bond1y + endcapradius / 2, 0]){
//		cylinder(r = endcapradius, h = thickness, $fn=20);
//	}
	translate([bond1x - tweak, bond1y + (tweak/2) + endcapradius / 2, 0]){
		ring();
	}

	//bond 3
	translate([bond3x, bond3y, 0]){
	rotate(a=[0,0,-30]){
		cube([bondlength, thickness, thickness]);
	}}

	//bond 4
	translate([bond4x - thickness/2, bond4y + thickness/2, 0]){
	rotate(a=[0,0,-90]){
		cube([bondlength, thickness, thickness]);
	}}

	//bond 5
	translate([bond4x, bond4y, 0]){
	rotate(a=[0,0,30]){
		cube([bondlength - tweak, thickness, thickness]);
	}}
	
//	//hole 2
//	translate([hole2x, bond3y + endcapradius / 2, 0]){
//		cylinder(r = endcapradius, h = thickness, $fn=20);
//	}
	translate([hole2x, bond3y + endcapradius / 2, 0]){
		ring();
	}
}

//cutout
union(){
	//cutout hexagon
	rotate(a=[0,0,30]){
		cylinder($fn = 6, r = cutbond, h = thickness);
	}

	//cutout pentagon 1
	translate([pentcenter, 0, 0]){
		cylinder($fn = 5, r = cutpent, h = thickness);
	}

	//cutout pentagon 2
	translate([pent2center, 0, 0]){
	rotate(a=[0,0,180/5]){
		cylinder($fn = 5, r = cutpent, h = thickness);
	}}

	//cutout hole 1
//	translate([bond1x, bond1y + endcapradius / 2, 0]){
//		cylinder(r = endcapholeradius, h = thickness, $fn=20//);
//	}

//	//cutout hole 2
//	translate([hole2x, bond3y + endcapradius / 2, 0]){
//		cylinder(r = endcapholeradius, h = thickness, $fn=20//);
//	}

}
}


	//sphere 1
	translate([pentcenter + cos(72) * pentradius, sin(72) * pentradius - sphereradius/2, thickness/2]){
		sphere(r=sphereradius, $fn=20);
	}

	//sphere 2
	translate([pentcenter + cos(72) * pentradius, -1 * (sin(72) * pentradius - sphereradius/2), thickness/2]){
		sphere(r=sphereradius, $fn=20);
	}

	//sphere 3
	translate([pent2center - cos(72) * pentradius, sin(72) * pentradius - sphereradius/2, thickness/2]){
		sphere(r=sphereradius, $fn=20);
	}

	//sphere 4
	translate([pent2center - cos(72) * pentradius, -1 * (sin(72) * pentradius - sphereradius/2), thickness/2]){
		sphere(r=sphereradius, $fn=20);
	}

	//sphere 5
	translate([bond4x, bond4y - bondlength + tweak, thickness/2]){
		sphere(r=sphereradius, $fn=20);
	}

}