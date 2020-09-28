use <./openscad_modules/modules/RoundedRectangle.scad>;
use <./openscad_modules/modules/RoundedCube.scad>;
use <./openscad_modules/modules/DiamondColumns.scad>;

r_LED = 2.6;
thickness = 2;
x_base = 46;
y_base = 100;
z_base = 30;
x_slit = y_base;
y_slit = 30-5-thickness-2;
x_sample_chamber = 16;
x_LED_holder = x_sample_chamber;
y_LED_holder = y_slit+5+2;
RESOLUTION = 50;



difference() {
    RoundedCube(x=y_base, y=x_base, z=z_base, r=2, $fn=RESOLUTION);
    translate([2, 2, 0])
        cube([y_base-4, x_base-4, z_base-2]);
    
    // front
    translate([2, 0, 0])
        cube([y_base - 4, 5, z_base - 2]);

    translate([3, 1.5, z_base-4])
        DiamondColumns(num_x=7, num_y=6, h=5, r_hole_max=3);
    
    rotate([90, 0, 0])
        translate([3, 0, -x_base])
            DiamondColumns(num_x=7, num_y=4, h=5, r_hole_max=3);
    
    rotate([0, 90, 0])
        rotate([0, 0, 90])
            translate([1.5, 0.5, 0])
                DiamondColumns(num_x=5, num_y=6, h=5, r_hole_max=2);
    
    rotate([0, 90, 0])
        rotate([0, 0, 90])
            translate([1.5, 0.5, y_base-2])
                DiamondColumns(num_x=5, num_y=6, h=5, r_hole_max=2);
    
    // screw holes
    rotate([0, 90, 0]) rotate([0, 0, 90]) mirror([0, 0, 1]) {
        translate([5, 0, -3]) {
            RoundedRectangle(x=10, y=12, thickness=5, r=1, $fn=RESOLUTION);
            cube([10, 6, 5]);
        }
        
        translate([x_base-10-2, 0, -3]) {
            RoundedRectangle(x=10, y=12, thickness=5, r=1, $fn=RESOLUTION);
            cube([10, 6, 5]);
        }
        
        translate([0, 0, -y_base+3]) {
            translate([5, 0, -5]) {
                RoundedRectangle(x=10, y=12, thickness=5, r=1, $fn=RESOLUTION);
                cube([10, 6, 5]);
            }
            
            translate([x_base-10-2, 0, -5]) {
                RoundedRectangle(x=10, y=12, thickness=5, r=1, $fn=RESOLUTION);
                cube([10, 6, 5]);
            }
        }
    }
    
    // cable hole
    rotate([90, 0, 0])
        translate([y_base-10.5, 4.8, -x_base-1])
        cylinder(r=2, h=5, $fn=4);
    
    // cap of chamber
translate([y_base/2+(x_sample_chamber+2*thickness)/2, 2, y_LED_holder])
    rotate([0, 0, 90]) {
            translate([13, (x_sample_chamber+2*thickness)/2, 0])
                cylinder(r=x_sample_chamber/2, h=2, $fn=RESOLUTION);
    }
}

rotate([0, 90, 0]) rotate([0, 0, 90]) mirror([0, 0, 1]) {
    translate([5, 0, -2]) {
        difference() {
            union() {
                RoundedRectangle(x=10, y=12, thickness=1, r=1, $fn=RESOLUTION);
                cube([10, 6, 1]);
            }
            translate([10/2, 6, 0])
                cylinder(r=1.5, h=10, $fn=RESOLUTION);
        }
    }
    
    translate([x_base-10-2, 0, -2]) {
        difference() {
            union() {
                RoundedRectangle(x=10, y=12, thickness=1, r=1, $fn=RESOLUTION);
                cube([10, 6, 1]);
            }
            translate([10/2, 6, 0])
                cylinder(r=1.5, h=10, $fn=RESOLUTION);
        }
    }
    
    translate([0, 0, -y_base+5]) {
        translate([5, 0, -4]) {
            difference() {
                union() {
                    RoundedRectangle(x=10, y=12, thickness=1, r=1, $fn=RESOLUTION);
                    cube([10, 6, 1]);
                }
                translate([10/2, 6, 0])
                    cylinder(r=1.5, h=10, $fn=RESOLUTION);
            }
        }
        
        translate([x_base-10-2, 0, -4]) {
            difference() {
                union() {
                    RoundedRectangle(x=10, y=12, thickness=1, r=1, $fn=RESOLUTION);
                    cube([10, 6, 1]);
                }
                translate([10/2, 6, 0])
                    cylinder(r=1.5, h=10, $fn=RESOLUTION);
            }
        }
    }
}

// cap of chamber
translate([y_base/2+(x_sample_chamber+2*thickness)/2, 2, y_LED_holder])
    rotate([0, 0, 90]) {
        difference() {
            RoundedRectangle(x_base-10+thickness-2, x_sample_chamber+2*thickness, 2, 2, RESOLUTION);
            translate([13, (x_sample_chamber+2*thickness)/2, 0])
                cylinder(r=x_sample_chamber/2, h=2, $fn=RESOLUTION);
        }
    }