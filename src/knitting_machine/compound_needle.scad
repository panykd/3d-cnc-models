length=80;

backoff = 25;

hook_thickness=1.5;
hook_length=30;
hook_rake=5;

od=10;

pos_rest =      [0, 0];
pos_open =      [backoff + 2*hook_rake, backoff+hook_rake];
pos_closed =    [backoff, backoff+hook_length];
pos_transfer =  [0, backoff+hook_length + 1.5*hook_rake];
pos_pickup =    [backoff + 2.5*hook_rake, backoff+hook_rake];


// front bottom
rotate([0,-45,0]) {
    translate([-backoff, 0, 0]) {
        compound_needle(pos_rest);
    }
}

// back bottom
rotate([0,-45,180]) {
    translate([-backoff, 0, 0]) {
        compound_needle(pos_rest);
    }
}

// front top
rotate([0,-15,0]) {
    translate([-backoff, 0, 0]) {
        compound_needle(pos_rest);
    }
}

// back top
rotate([0,-15,180]) {
    translate([-backoff, 0, 0]) {
        compound_needle(pos_rest);
    }
}

module compound_needle(pos=[0,0]) {
    
    translate([pos[0],0,0]) {
        hook();
    }
    
    translate([-hook_length+pos[1],0,0]) {
        closing_element();
    }
}

module hook() {
    
    id=6;
    
    
    
    
    
    
    translate([-hook_length,0,0]) {    
        difference() {
            rotate([90,0,0]) {
                linear_extrude(height=hook_thickness, center=true) {
                    difference() {
                        union() {
                            
                            // Shaft
                            translate([-length+hook_length,-od/2]) {
                                square([length,od]);
                            }
                            
                            // Tip
                            translate([hook_length,0]) {
                                circle(d=od, $fn=30);
                            }
                        }
                        
                        union() {
                            // Circle
                            translate([hook_length,0]) {
                                circle(d=id, $fn=30);
                            }
                            
                            polygon(points=[
                                    [0,od/2],
                                    [hook_length,-id/2],
                                    [hook_length,id/2],
                                    [hook_length-hook_rake, id/2],
                                    [hook_length-hook_rake/2.5, od/2],
                                    [hook_length-hook_rake, od/2]
                                ]);
                        }
                    }
                }
            }
            
            //taper
            linear_extrude(height=od/2) {
                polygon(points=[
                    [hook_length-hook_rake-1,hook_thickness/2],
                    [hook_length,hook_thickness/2],
                    [hook_length-hook_rake,0],
                    [hook_length,-hook_thickness/2],
                    [hook_length-hook_rake-1,-hook_thickness/2],
                ]);
            }
        }
    }
}

module closing_element() {
 
    thickness=0.5;
    
    _t = thickness*2 + hook_thickness;
    
    difference() {
        translate([-hook_length, 0,0]) {
            difference() {
            
                translate([-length+hook_length, -_t/2, -od/2]) {            
                    cube([length, _t, od]);
                }
                
                translate([-length+hook_length,-hook_thickness/2,-od/2]) {
                    cube([length, hook_thickness, od]);
                }
            }
        }
        
        translate([-hook_rake/2,0,-od/4-od/2]) {
            rotate([90,-10,0]) {
                linear_extrude(height=_t, center=true) {
                    union() {
                        circle(r=od, $fn=30);
                    }
                    translate([0,0,0]) {
                        square([od,od]);
                    }
                }
            }
        }
    }
}