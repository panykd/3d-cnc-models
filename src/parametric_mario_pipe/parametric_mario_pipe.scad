pipeDiameter = 42;
wallThickness=3;
size = 2;
assembly(wallThickness);

$fn = 30;
$model = 0;

module assembly(_thickness) {
    
    // Scaling Calculation to determine block size as a function of the desired pipe diameter
    block_size = ceil((pipeDiameter / 6 + _thickness) * 2);
    
    pipe_radius = (block_size * size)/2;
    pipe_inner = pipe_radius-3*_thickness;
    
    if($model == -1) {
        projection(cut=true)
        {
            rotate([90,0,0]) 
            {
                union() {
                    model();
                    pipe();
                }
            }
        }
    }
    else if ($model == 0)
    {
        union() {
            model();
            pipe();
        }    
    }
    else if ($model == 1)
    {
        difference() {
            model();
            pipe();
        }
    }
    
    else if ($model == 2)
    {
        pipe();
    }
    
    else if ($model == 3)
    {
        lid();
    }
    
    module stand() {
        
        color("orange")
        translate([0,0,_thickness]) {
            cylinder(r=pipe_inner-_thickness, h = block_size-2*_thickness, $fn = 6);
        }
    }

    module water_way() {
        
        translate([0,0,_thickness]) {
            union() {
                // Pipe cutout
                cylinder(r=pipe_inner+0.3, h = block_size-_thickness);
                
                // Channel
                rotate([-90,0,-90]) {
                    linear_extrude(height = (2 + (size/2))*block_size-2*_thickness) {
                        base = (block_size-2*_thickness);
                        polygon(points=[
                            [-base/2, 0],
                            [0, -base],
                            [base/2, 0]
                        ]);
                    }
                }
                
                // Tower Cutout
                translate([(size-(size-2)*0.5)*block_size + 2*_thickness,-(block_size-4*_thickness)/2,0]) {
                    cube([block_size-4*_thickness, block_size-4*_thickness, 3*block_size-1*_thickness]);
                }
                
                translate([(size-(size-2)*0.5)*block_size + 1*_thickness,-(block_size-2*_thickness)/2,-2*_thickness+3*block_size]) {
                    lid_blank();
                }
            }
        }
    }
    
    module lid_blank() {
        
        cube([block_size-2*_thickness, block_size-2*_thickness, _thickness]);
    }
    
    module lid() {
        color("yellow")
        difference() {
            lid_blank();
            translate([(block_size-2*_thickness)/2, (block_size-2*_thickness)/2, 0]) {
                cube([_thickness*2, _thickness*2, _thickness*2], center=true);
            }
        }
    }


    module model() {
        
        union() {
            difference() {
                platform();
                //pipe();
                water_way();
            }
            
            stand();
        }

        module platform() {
            
            translate([block_size*(size-(size-2)*0.5), -block_size/2, 0]) {
                union() {
                    translate([0,0,block_size*2]) {
                        question_block();
                    }

                    translate([0,0,block_size*1]) {
                        brick_block();
                    }

                    translate([0,0,0]) {
                        ground_block();
                    }

                    // Joiner
                    translate([-block_size,0,0]) {
                        ground_block();
                    }
                    
                    
                    
                    // Pipe Platform
                    delta = (size-1)/2;
                    translate([-block_size*(size-((size-3)*0.5)),0,0]) {
                        union() {
                            for(ix = [-delta:1:delta]) {
                                for(iy = [-delta:1:delta]) {                        
                                    translate([ix*block_size,iy*block_size,0])
                                        ground_block();
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    module pipe() {
            color("green")
            rotate_extrude(angle=360) {
                
                rotate([0,0,0]) {
                    polygon(points=[
                        [pipe_inner,block_size/2],
                        [pipe_radius-_thickness,block_size/2],
                        [pipe_radius-_thickness,(2*block_size)],
                        [pipe_radius,(2*block_size) + _thickness],
                        [pipe_radius,(3*block_size)],
                        [pipe_inner,(3*block_size)]
                    ]);
                }
            }
        }


    module question_block() { color("yellow") block_template("question.dat");   }
    module brick_block()    { color("red") block_template("bricks.dat");     }
    module ground_block()   { color("orange") block_template("ground.dat");     }


    module block_template(texture_file) {
        scale(block_size/20) {
            union() {
                cube(20);

                translate([20,0,20])
                rotate([90,-180,0])
                surface(file = texture_file, center=false);
                
                translate([20,20,20])
                rotate([90,180,90])
                surface(file = texture_file, center=false);
                
                translate([0,20,20])
                rotate([90,180,180])
                surface(file = texture_file, center=false);

                translate([0,0,20])
                rotate([90,180,-90])
                surface(file = texture_file, center=false);
            }
        }
    }
}