use <MCAD/involute_gears.scad>;
use <MCAD/bearing.scad>;
include <MCAD/nuts_and_bolts.scad>;

// Settings

$fn=50;


// Variables
_tol=1;

pi_plate_thickness = 3.1;

bearing_model=606;
shaft_size= bearingDimensions(bearing_model)[0];

encoder_hole = COARSE_THREAD_METRIC_BOLT_MAJOR_DIAMETERS[shaft_size];
encoder_hex = METRIC_NUT_AC_WIDTHS[shaft_size];

ed_diameter = 25;
ed_thickness = 2;

filament_d = 1.75;

g_not=50;
assembly();


module tension_arm() {
    
}


function circularPitchForDiameter(d, number_of_teeth) = (180 * d/2) / (number_of_teeth/2+1);

module assembly() {

    // Filament
    cylinder(d=filament_d, h=50, center=true);

    //
    tension_idler();
    
    // Encoder Shaft
    translate([bearingDimensions(bearing_model)[1]/2+ 1.75/2, 0, 0]) {
        
        encoder_gear();
        
        //encoder_bearing
        translate([0,10,0]) {
            rotate([-90,0,0])
            bearing(model=606);
        }
        
        translate([0,23,-(ed_diameter/2 +pi_plate_thickness + _tol)]) {
            rotate([0,0,-90]) {
                encoder();
            }
        }
    }
    
    
    module encoder() {
        photointerrupter();

        translate([0,0,pi_plate_thickness + _tol]) {
            translate([0,0,ed_diameter/2]) {
                rotate([0,-90,0]) {
                    encoder_disk();
                }
            }
        }
    }
}





module encoder_disk() {
    
    slots = 32;
    slot_theta = 360/(slots*2);
    
    ir = (encoder_hex/2*1.2);
    or = (ed_diameter/2/10 * 9);
    
    ix = ir*cos(slot_theta/2);
    iy = ir*sin(slot_theta/2);
    
    ox = or*cos(slot_theta/2);
    oy = or*sin(slot_theta/2);
        
    difference() {
        linear_extrude(height=ed_thickness, center=true) {
            difference() {
                circle(d=ed_diameter);
                circle(d=encoder_hole);
                
                for(a = [0:slots-1]) {
                    rotate(360/(slots)*a) {
                        polygon(points=[
                            [ix,iy],        
                            [ox,oy],        
                            [ox,-oy],
                            [ix,-iy], 
                        ]);
                    }
                }
            }
        }
        
        translate([0,0,ed_thickness/4]) {
            nutHole(shaft_size);
        }
    }
}


module photointerrupter() {
    
    overall_height = 10.8;

    plate_length=24.5;
    plate_width=6.3;
    
    hole_spacing = 19;
    hole_diameter = 3.3;

    tower_length = 11.9;
    tower_height = overall_height-pi_plate_thickness;
    gap_width = 3.1;
    
    slot_depth=3.8;
    slot_length=gap_width + 2*0.6;
    slot_width=1;

    plate();
    towers();
    
    module towers() {
        difference() {
            translate([0,0,pi_plate_thickness]) {
                
                linear_extrude(height=tower_height) {
                    difference() {
                        square([tower_length, plate_width], center=true);
                        square([gap_width, plate_width], center=true);
                    }
                }
                
            }
            
            translate([-slot_length/2,-slot_width/2, overall_height-slot_depth]) {
                cube([slot_length, slot_width, slot_depth]);
            }
        }
    }
    
    module plate() {
        linear_extrude(height=pi_plate_thickness) {
            
            difference() {
                offset(r=0.5)
                offset(-0.5)
                square([plate_length, plate_width], center=true);
                
                translate([-hole_spacing/2, 0,0])
                    circle(d=hole_diameter);
                
                translate([hole_spacing/2, 0,0])
                    circle(d=hole_diameter);
            }
        }
    }
}

module tension_idler() {
    idler_thickness = 2;

    translate([-(bearingDimensions(bearing_model)[1] + filament_d + idler_thickness)/2,-bearingDimensions(bearing_model)[2]/2,0])
    rotate([-90,0,0]) {
        bearing(model=606);
        
        translate([0,0,bearingDimensions(bearing_model)[2]/2])
        rotate_extrude(angle=360) {
            polygon(points=[
                [bearingDimensions(bearing_model)[1]/2, -bearingDimensions(bearing_model)[2]/2],
                [bearingDimensions(bearing_model)[1]/2+idler_thickness+filament_d/2, -bearingDimensions(bearing_model)[2]/2],
                [bearingDimensions(bearing_model)[1]/2+idler_thickness, 0],
                [bearingDimensions(bearing_model)[1]/2+idler_thickness+filament_d/2, bearingDimensions(bearing_model)[2]/2],
                [bearingDimensions(bearing_model)[1]/2, bearingDimensions(bearing_model)[2]/2],
            ]);
        }
    }
}
module encoder_gear() {
    translate([0, -bearingDimensions(bearing_model)[2]/2, 0]){
        rotate([-90,0,0]) {
            
            difference() {
                gear(
                    number_of_teeth=g_not, 
                    circular_pitch=circularPitchForDiameter(bearingDimensions(bearing_model)[1],g_not), 
                    gear_thickness=bearingDimensions(bearing_model)[2],
                    bore_diameter=encoder_hole,
                    hub_diameter=bearingDimensions(bearing_model)[1]
                );
                
                cylinder(d=encoder_hex, $fn=6, h=bearingDimensions(bearing_model)[2]/2);
            }
        }
    }
}
