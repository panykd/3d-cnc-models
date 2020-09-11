//https://scholarsarchive.byu.edu/cgi/viewcontent.cgi?article=2562&context=facpub

R = 20;
_t = 0.8;

translate([-R, R, 0]) {
    cube([2*R, 3, 5]);
}

translate([-R, -R, 0]) {
    cube([2*R, 3, 5]);
}

linear_extrude(height=5) {
    
    
    
    Flex16();
}

module Flex16() {

    //      1   2        3       4       5       6       7       8
    f = [0, 1,  0.30,    0.90,   1.00,   0.95,   0.90,   0.13,   0.90];

    //      1   2   3   4   5   6   7       
    a = [0, 10, 30, 35, 40, 45, 55, 85];

    k = [
            [0, 0],
            [0, 0], //1
            [0, R], //2
            [-f[1]*R*sin(a[1]), R], //3
            [-f[2]*R*sin(a[1]), f[2]*R*cos(a[1])],  //3
            [-f[2]*R*sin(a[2]), f[2]*R*cos(a[2])],  //4
            [-f[3]*R*sin(a[3]), f[3]*R*cos(a[3])],  //5
            [-f[4]*R*sin(a[4]), R],
            [-f[5]*R*sin(a[4]), f[5]*R*cos(a[4])],
            [-f[6]*R*sin(a[5]), f[6]*R*cos(a[5])],
            [-f[7]*R*sin(a[6]), f[7]*R*cos(a[6])],
            [-f[8]*R*sin(a[7]), f[8]*R*cos(a[7])],
            [-f[8]*R, 0],
            [0, -R],
            [-f[1]*R*sin(a[1]), -R],
            [-f[2]*R*sin(a[1]), -f[2]*R*cos(a[1])],
            [-f[2]*R*sin(a[2]), -f[2]*R*cos(a[2])],
            [-f[3]*R*sin(a[3]), -f[3]*R*cos(a[3])],
            [-f[4]*R*sin(a[3]), -R],
            [-f[5]*R*sin(a[4]), -f[5]*R*cos(a[4])],
            [-f[6]*R*sin(a[5]), -f[6]*R*cos(a[5])],
            [-f[7]*R*sin(a[6]), -f[7]*R*cos(a[6])],
            [-f[8]*R*sin(a[7]), -f[8]*R*cos(a[7])],
            [f[1]*R*sin(a[1]), R],
            [f[2]*R*sin(a[1]), f[2]*R*cos(a[1])],

            [f[2]*R*sin(a[2]), f[2]*R*cos(a[2])],
            [f[3]*R*sin(a[3]), f[3]*R*cos(a[3])],
            [f[4]*R*sin(a[3]), R],
            [f[5]*R*sin(a[4]), f[5]*R*cos(a[4])],
            [f[6]*R*sin(a[5]), f[6]*R*cos(a[5])],
            [f[7]*R*sin(a[6]), f[7]*R*cos(a[6])],
            [f[8]*R*sin(a[7]), f[8]*R*cos(a[7])],
            [f[8]*R, 0],
            [f[1]*R*sin(a[1]), -R],
            [f[2]*R*sin(a[1]), -f[2]*R*cos(a[1])],
            [f[2]*R*sin(a[2]), -f[2]*R*cos(a[2])],
            [f[3]*R*sin(a[3]), -f[3]*R*cos(a[3])],
            [f[4]*R*sin(a[3]), -R],
            [f[5]*R*sin(a[4]), -f[5]*R*cos(a[4])],
            [f[6]*R*sin(a[5]), -f[6]*R*cos(a[5])],
            [f[7]*R*sin(a[6]), -f[7]*R*cos(a[6])],
            [f[8]*R*sin(a[7]), -f[8]*R*cos(a[7])],
            [-f[7]*R*sin(a[7]), f[7]*R*cos(a[7])],
            [f[7]*R*sin(a[7]), f[7]*R*cos(a[7])],
            [-f[7]*R*sin(a[7]), -f[7]*R*cos(a[7])],
            [f[7]*R*sin(a[7]), -f[7]*R*cos(a[7])],
            [0, f[7]*R],
            [0, -f[7]*R]
    ];



    union() {
        polygon_offset(k, [[03, 04, 24, 23, 02]], -1);

        polygon_offset(k, [[04, 05, 06, 08, 09, 10, 46, 30, 29, 28, 26, 25, 24]], -_t);

        //polygon_offset(k, [[10, 11, 12, 22, 21, 47, 40, 41, 32, 31, 30, 46]], -_t);
        polygon_offset(k, [[46, 10, 11, 12, 22, 21, 47]], -_t);
        polygon_offset(k, [[47, 40, 41, 32, 31, 30, 46]], -_t);

        polygon_offset(k, [[21, 20, 19, 17, 16, 15, 34, 35, 36, 38, 39, 40, 47]], -_t);

        polygon_offset(k, [[15, 14, 13, 33, 34]], -_t);
    }

    module polygon_offset(a, b, x) {
        difference() {
            polygon(a, b);
            offset(x) polygon(a, b);
        }
    }
}
