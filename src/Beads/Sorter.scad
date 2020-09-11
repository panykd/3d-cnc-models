$fn = 50;

// pyssla
tolerance=0.2;

od = 4.5 + tolerance;
id = 3;
h = 5 + tolerance;

thickness = 3;

angle = 30;

size=30;
length = sin(90-angle)*(size*0.75);

module bead() {
    difference() {
        cylinder(d=od, h=h);
        cylinder(d=id, h=h);
    }
}


dAdj = (cos(90-angle/2)*od/2);

difference() {
    
    
    
    union() {
        
        translate([-(size+thickness)/2 + 4*dAdj,-(size+thickness)/2,-od*2*cos(90-angle/2)]) {
            cube([(size+thickness),(size+thickness),od/2*sin(90-angle/2)+2*od*sin(90-angle/2)+size/2]);
        }
        
        // Shaft
        translate([-sin(90-angle)*(length-tolerance), 0, -cos(90-angle)*(length-tolerance)]) {
            rotate([0,90-angle,0]) { 
                cylinder(d=od+thickness/2,h=length+sin(90-angle)*thickness); 
            }
        }
    }
    
    aligner_cavity();
    
    // Stands
    

}

standHeight = cos(90-angle)*length + od;
translate([-(size+thickness)/2 + 4*dAdj,-(size+thickness)/2,-(length+od)*cos(90-angle/2)]) {
    
    ratio = 4;
    sAdj = size+thickness - size/ratio;
    
    translate([0,0,-standHeight/2]) {
        cube([size/ratio, size/ratio, standHeight]);
    }
    
    translate([sAdj, 0,-standHeight/2]) {
        cube([size/ratio, size/ratio, standHeight]);
    }
    
    translate([0,sAdj,-standHeight/2]) {
        cube([size/ratio, size/ratio, standHeight]);
    }
    
    translate([sAdj,sAdj,-standHeight/2]) {
        cube([size/ratio, size/ratio, standHeight]);
    }
}


module aligner_cavity() {
    

    

    //  Hoppers
    hull() {
        // Top Hopper
        x = 2*od*sin(90-angle/2)+dAdj;
        y = 4*od;
        translate([-4*dAdj,-y/2,x-dAdj]) {
            translate([x/2, y/2])
            linear_extrude(height=size/2, scale=[size/x, size/y])
            square([x,y], center=true);
        }
        

        // Bottom Hopper
        rotate([90-angle/2,0,90]) {
        linear_extrude(height=2*od) {

            union() {
                polygon(points=[
                    [-od/2,0],
                    [+od/2,0],
                    [2*od,2*od],
                    [-2*od,2*od],
                ]);
            }
        }

        // Bottom Grove
        
        translate([0,0,-dAdj]) {
            cylinder(d=od,h=2*od+dAdj);
            }
        }
    }
    
    // Shaft
    
    translate([-sin(90-angle)*length, 0, -cos(90-angle)*length]) {
        rotate([0,90-angle,0]) { 
            cylinder(d=od,h=length); 
        }
    }
}