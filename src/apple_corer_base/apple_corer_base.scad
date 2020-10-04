
blades=8;
blade_width=2;
blade_slot_factor=4;
core_diameter=22.5;
inner_diameter=90;

$fn=60;

//cutout();

//projection(true) rotate([-90,0,0])
assembly();

module assembly() {
    difference() {
        profile();
        translate([0,0,5]) {
            cutout();
        }
    }
}

module profile()
intersection() {
        translate([0,0,inner_diameter/2]) {
            cube(inner_diameter,center=true);
    }

    
    difference() {
        translate([0,0,0]) {
            sphere(d=inner_diameter);
        }

        translate([0,0,inner_diameter/2]) {
            sphere(d=inner_diameter*0.8);
        }
    }
}

module cutout() {
    union() {
        difference() {
            cylinder(h= inner_diameter/2, d=core_diameter+blade_width*2);
            cylinder(h=inner_diameter/2, d=core_diameter);
        }

        for(a = [0:blades-1]) {   
            rotate(a * 360/blades) {
                translate([core_diameter/2,0,0]) 
                {
                    rotate([180,-90,0]) {
                        linear_extrude(height=(inner_diameter-core_diameter-blade_width)/2) {
                            polygon(points=[
                                [0, -blade_width/2],
                                [inner_diameter/2, -blade_slot_factor*blade_width],
                                [inner_diameter/2, blade_slot_factor*blade_width],
                                [0, blade_width/2],
                            ]);
                        }
                    }
                }
            }
        }        
    }
}