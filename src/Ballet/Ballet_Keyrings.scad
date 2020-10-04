size=10;
extrude = 12;
spacing=0.75;

text1 = "♥MISS♥";
text2 = "KIRSTY";
text3 = "ADULT♥";
text4 = "BALLET";

    //import("Female_Ballerina_fixed.stl");

union() {
    translate([0,0,-60]) {
        scale(1.2) {
            import("D:/3D/Keyrings/new_fiore.stl");
        }
    }


    difference() {

        union() {
            translate([0,0,-60]) {
                cylinder(h=60, d=size, $fn=30);
            }

            rotate([90,0,0]) {
                linear_extrude(height=extrude/2) {
                    text(text1, direction="ttb", size=size, spacing=spacing);
                }
            }
            
            rotate([90,0,90]) {
                linear_extrude(height=extrude/2) {
                    text(text2, direction="ttb", size=size, spacing=spacing);
                }
            }
            
            rotate([90,0,180]) {
                linear_extrude(height=extrude/2) {
                    text(text3, direction="ttb", size=size, spacing=spacing);
                }
            }

            rotate([90,0,270]) {
                linear_extrude(height=extrude/2) {
                    text(text4, direction="ttb", size=size, spacing=spacing);
                }
            }
        }
    }
}