
$tol = 2;

$explode = 1.3;

container_diameter = 75;
container_height = 52;

block_height = 75;
block_size=100;

finger_hole = 25;

connector_height=6;
connector_thickness=3;

cap_thickness=3;

// extractor = 0 
// Riser = 1
// Cap = 2;



//extractor();
//riser();
cap();

//assembly();

module assembly() {
    components = [0, 1, 2];

    for(ix = [0:len(components)]) {
        translate([0, 0, ix*(block_height+connector_height+connector_height*$explode)]) {
            if(components[ix] == 0) { extractor(); }
            else if (components[ix] == 1) { riser(); }
            else if (components[ix] == 2) { cap() ; }
        }
    }
}


module extractor() {
    union() {
        top_connector();
        extraction_point();
        base_plate();
    }
}

module extraction_point() {    
    difference() {
        
        barrel();
        
        // Extraction Port
        linear_extrude(height = container_height+$tol) {
            translate([-(container_diameter+$tol)/2,-(container_diameter+$tol),0]) {
                square(container_diameter+$tol);
            }
        }

        // Finger Hole
        translate([0, finger_hole/2, container_height/2]) {
            rotate([0,90,0]) {
                linear_extrude(height=block_size, center=true) {
                    union() {
                        circle(d=finger_hole);
                        translate([-(finger_hole)/2, -(container_diameter+$tol)/2]) {
                            square([finger_hole, (container_diameter+$tol)/2]);
                        }
                    }
                }
            }
        }
    }
}

module cap() {
    union() {
        
        linear_extrude(height=cap_thickness) {
            barrel_profile();
        }
        
        bottom_connector();
    }
}

module riser() {
    union() {
        top_connector();
        difference() {
            barrel();
            
            rotate([90,0,0]) {
                translate([0,finger_hole,-block_size/2]) {
                    linear_extrude(height=block_size/2) {
                        circle(d=finger_hole);
                        
                        translate([-finger_hole/2,0]) {
                            square([finger_hole,block_size-3*finger_hole]);
                        }
                        
                        translate([0,block_size-3*finger_hole]) {
                            circle(d=finger_hole);
                        }
                    }
                }
            }
        }
        
        bottom_connector();
    }
}

module top_connector() {
    
    translate([0,0,block_height]) {
        linear_extrude(height=connector_height) {    
            difference() {
                barrel_profile();
                
                offset(-connector_thickness) {
                    base_profile();
                }
            }
        }
    }
}

module bottom_connector() {
    // Simple Slot Connection
    translate([0,0,-connector_height]) {    
        linear_extrude(height=connector_height) {    
            intersection() {
                barrel_profile();
                
                offset(-connector_thickness) {
                    base_profile();
                }
            }
        }
    }
}

module barrel() {
    
    difference() {
        linear_extrude(height = block_height) {
                barrel_profile();
        }
    }
}

module barrel_profile() {
    difference() {
        base_profile();
        circle(d=container_diameter+$tol);
    }
}

module base_plate() {
    translate([0,0,-cap_thickness]) {
        linear_extrude(height=cap_thickness) {
            base_profile();
        }
    }
}

module base_profile() {
    circle(d=block_size, $fn=6);
}