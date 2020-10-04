tool_volume=[75, 50, 100];
tool_offset=[-tool_volume[0]/2, -tool_volume[1]/2, 0];

working_volume=[400, 400, 600];

bed_thickness=5;


//_p=[0,0,0];

// Tool Volume

//$t=0;

theta=360*$t;

_an_cx = working_volume[0]/2;
_an_cy = working_volume[1]/2;

_an_r = 100 * sin(3*theta);

_p = [_an_cx + _an_r * cos(theta), _an_cy + _an_r * sin(theta), 0];



translate([0,_p[1], 0]) {

    // X Axis
    
    rail_spacing=50;
    rail_diameter=15;
    
    translate([0,-rail_spacing/2,0]) {
        rotate([0,90,0]) {
            cylinder(d=rail_diameter, h=working_volume[0]);
        }
    }
    translate([0, rail_spacing/2,0]) {
        rotate([0,90,0]) {
            cylinder(d=rail_diameter, h=working_volume[0]);
        }
    }
    
    
    
    // Carriage
    translate([_p[0], 0, 0]) {
        
        bearing_length=50;
        
        translate([0,-rail_spacing/2,0]) {
            bearing(rail_diameter, 30, bearing_length);
        }
        translate([0,rail_spacing/2,0]) {
            bearing(rail_diameter, 30, bearing_length);
        }
        
        
        translate(tool_offset) {
            #cube(tool_volume);
        }
    }
}

    module bearing(id, od, l) {
        translate([-l/2,0,0]) {
                rotate([0,90,0]){
                    linear_extrude(height=l) {
                        difference() {
                            circle(d=od);
                            circle(d=id);
                        }
                    }
                }
            }
        }

// Work Volume
//%cube(working_volume);

// Bed
module bed() {
translate([0,0,working_volume[2]-_p[2]]) {
    translate([0,0,-bed_thickness]) {
        cube([working_volume[0], working_volume[1], bed_thickness]);
    }
}
}