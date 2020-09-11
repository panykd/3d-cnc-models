$fn = 50;

tolerance = 0.2;

// Prong width


function dist(p1, p2) = sqrt(pow(p2[0]-p1[0],2) + pow(p2[1]-p1[1],2));

buckle_height=6.8;


// strap holder

strap_width = 25.4;
strap_holder_width = 32;
strap_holder_depth = 16;
strap_holder_height = 11;

shaft_thickness=2;

retainer_ratio = 5;

union() {
    
    buckle();

    
    translate([0, -(strap_holder_depth/2 + shaft_thickness), 0]) {
        linear_extrude(height=strap_holder_height, center=true) {
            difference() {
                square([strap_holder_width, strap_holder_depth], center=true);
                square([strap_width, strap_holder_depth / 1.5], center=true);
            }
        }
    }

    translate([0, -(strap_holder_depth/2 + shaft_thickness), 0])
    rotate([45,0,0]) {
        cube([strap_width, strap_holder_depth/retainer_ratio, strap_holder_depth/retainer_ratio], center=true);
    }
}

module buckle() {

    

    shaft_length=11;
    shaft_thickness=2;
    shaft_innerSpacing = 24;

    notch_length=3.5;
    notch_depth=4;


    buckle_half();
    mirror([1,0,0]) {
        buckle_half();
    }

    module buckle_half() {

        difference() {
            linear_extrude(height=buckle_height, center=true) {    
                buckle_profile();
            }
            
            notch();
            
            // Notch
            mirror([0,0,1]) {
                notch();
            }
            
        }            
    }
    
    module notch() {
        translate([shaft_innerSpacing/2-tolerance,0,0]) {
            rotate([90,0,90]) {
                linear_extrude(height=shaft_thickness+2*tolerance) {
                    polygon(points=[
                        [tolerance, (buckle_height/2 + tolerance)],
                        [shaft_length-notch_length*2, (buckle_height/2 + tolerance)],
                        [shaft_length-notch_length, (notch_depth/2)],
                        [shaft_length-tolerance, (notch_depth/2)],
                        [shaft_length-tolerance, (buckle_height/2 + tolerance)]
                    ]);
                }
            }
        }
    }


    module buckle_profile() {
        
        union() {
            prong();
            spacer();
        }
        
        width = 28;
        thickness=2;
        translate([0,-thickness])
        square([width/2, thickness]);

        module prong() {

            prong_spacing = 23;
            prong_length = 23;
            prong_width = 7.5;
            prong_step = 0.75;
            
            c1 = dist([shaft_innerSpacing/2, shaft_length],[prong_spacing/2, prong_length]);
            c2 = dist([prong_spacing/2, prong_length],[shaft_innerSpacing/2+shaft_thickness+prong_step, shaft_length]);    
            
            a1 = acos((prong_length-shaft_length)/c1);
            a2 = acos((prong_length-shaft_length)/c2);    
            
            difference() {
                union() {
                    polygon(points=[
                        [shaft_innerSpacing/2, 0],
                        [shaft_innerSpacing/2, shaft_length],
                        [shaft_innerSpacing/2, shaft_length],
                        [prong_spacing/2, prong_length],
                        [shaft_innerSpacing/2+shaft_thickness+prong_step, shaft_length],
                        [shaft_innerSpacing/2+shaft_thickness, shaft_length],
                        [shaft_innerSpacing/2+shaft_thickness, 0],
                    ]);
                    
                    inner_prong();
                    outer_prong();
                }
                
                offset(r=-thickness/2) {
                    hull() {
                        offset(-0.5) {
                            inner_prong();
                        }
                        
                        offset(-0.5) {
                            outer_prong();
                        }
                    }
                }
            }
            
            module inner_prong() {
            
                h1 = 3.5;
                r1 = (h1/2) + (pow(c1,2)/(8*h1));

                translate([prong_spacing/2, prong_length]) {
                    rotate(90+a1) {
                        translate([-c1/2, 0]) {
                            intersection() {
                                translate([-r1,0]) {
                                    square([2*r1, h1]);
                                }
                                translate([0, -r1+h1]) {
                                    circle(r=r1);
                                }
                            }
                        }
                    }
                }
            }
            
            module outer_prong() {
        
                h2 = 2.5;
                r2 = (h2/2) + (pow(c2,2)/(8*h2));
                
                // Outer curve
                translate([prong_spacing/2, prong_length]) {
                    rotate(90+a2) {
                        translate([-c2/2, -h2]) {
                            intersection() {
                                translate([-r2,0]) {
                                    square([2*r2, h2]);
                                }
                                translate([0, r2]) {
                                    circle(r=r2);
                                }
                            }
                        }
                    }
                }
            }
        }

        module spacer() {
        
            spacer_spacing = 2.5;
            spacer_length = 27;
            spacer_width = 7;
            spacer_thickness = 1.2;
            
            polygon(points=[
                [spacer_spacing/2, 0],
                [spacer_spacing/2, spacer_length],
                [spacer_spacing/2+spacer_width, spacer_length-spacer_thickness],
                [spacer_spacing/2+spacer_width, spacer_length-2*spacer_thickness],
            
            
                [spacer_spacing/2+spacer_thickness, spacer_length-1.5*spacer_thickness],
            
                [spacer_spacing/2+spacer_thickness, spacer_thickness*6],
            
                [spacer_spacing/2+3*spacer_thickness, 0]
            ]);
        }
    }
}