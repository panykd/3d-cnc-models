//import("template-adult.svg");

depth=50;
length=100;
width = 10;
radius = 3;

handleXOffset = 100;
handleYOffset = 13;
handleAngleOffset = 130;

textXOffset = 30;
textYOffset = 40;

model = 0;

templates = [
    ["template-small-youth.svg","Small Youth"],
    ["template-youth.svg","Youth"],
    ["template-small-adult.svg","Small Adult"],
    ["template-adult.svg","Adult"]
];



if(model < 0) {
    rotate([-90,0,0])
        handle();
}
else if (model >= len(templates)) {
    template(templates[0][0], templates[0][1]);
}
else {
    template(templates[model][0], templates[model][1]);
}

module template(file, txt, includeHandle = false) {

    difference() {
        union() {
            linear_extrude(height=radius) {
                import(templates[model][0]);
                //import("template-youth.svg");
                //import("template-small-adult.svg");
                //import("template-adult.svg");
            }

            translate([handleXOffset,handleYOffset,radius]) {
                rotate([0,0,handleAngleOffset]) {
                    
                    translate([-(width+2*radius)/2,-(width+radius)/2,0]) {
                        cube([width+2*radius,width+radius,2*radius]);
                    }
                    
                    translate([(length-width)-(width+2*radius)/2,-(width+radius)/2,0]) {
                        cube([width+2*radius,width+radius,2*radius]);
                    }
                }
            }
            
            translate([textXOffset,textYOffset,radius/2])
                linear_extrude(height=radius)
                text(templates[model][1]);
        }
        
        translate([handleXOffset,handleYOffset,radius]) {
            rotate([0,0,handleAngleOffset]) {
                handle();
            }
        }
    }
}

module handle() {    
    rotate([90,0,0]) {
        translate([(length-width)/2,0,0]) {
            linear_extrude(height=10, center=true) {
                offset(r=radius) {
                    union() {
                        handle_half();
                        mirror([1,0,0]){
                            handle_half();
                        }
                    }
                }
            }
        }
    }

    module handle_half() {
        translate([0,radius,0]) {
            polygon(points=[
                [-(length-radius)/2, 0],
                [-(length-radius)/2, (depth-radius)],
                
                [0, (depth-radius)],
                [0, (depth-radius)-(width-radius)],
                
                [-(length-radius)/2 + (width-radius), (depth-radius)-(width-radius)],
                [-(length-radius)/2 + (width-radius), 0],
            ]);
        }
    }

}