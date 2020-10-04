
ring();

module assembly() {
    difference() {
        translate([-5,-30,0]) {
            rotate([0,0,45]) {
                translate([1430.95,13.97,0]) {
                    import("../../../externals/Mermaid_High_Heel_Shoe/Mermaid_High-Heel_Shoe.stl");
                }
            }
        }

        translate([20,0,173]) {
            ring();
        }
    }
}

module ring() {
    rotate([90,0,0]) {
        rotate_extrude(angle=360) {
            translate([30,0]) {
                circle(d=10);
            }
        }
    }
}