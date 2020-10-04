// 10.8

$fn = 40;

tol = 0.1;
d1 = 10.7;
d2 = 7.5;
l=20;

difference() {
    union() {
        cylinder(d=d1-tol, h=l);

        translate([0,0,l]) {
            sphere(d=d1-tol);
        }
    }

    cylinder(d=d2+tol,h=d1+l);
}


