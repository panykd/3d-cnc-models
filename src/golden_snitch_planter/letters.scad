
linear_extrude(height=5) {

    offset(-0.25) {
        projection() {
            translate([140, 750, 0]) {
                import("Golden_Snitch_Stand-Golden.stl");
            }
        
            translate([-30, 720, 0]) {
                import("Golden_Snitch_Stand-Snitch.stl");
            }
        }
    }
}