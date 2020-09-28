use <./openscad_modules/modules/RoundedRectangle.scad>;

r_screw = 1.2;
thickness = 2;
x_grating = 35;
y_grating = 15;
x_camera = 60;
y_camera = 21;
x_base = 44;
y_base = 73;
angle_z_grating = 30.38;
angle_x_grating = 90;
angle_z_camera = 30.38;
angle_x_camera = 90 - 4.69;
RESOLUTION = 50;


translate([0, -12, 0])
    BasePlate();

translate([1, 7, 0]) {
    // center indicator
    translate([0, y_base/2-0.5, 0])
            cube([x_base/4+3, 1, thickness]);

    translate([12, y_base/2, thickness])
        rotate([0, 0, -angle_z_grating])    
            FilmHolder();

    translate([20, y_base/2-15, thickness])
        rotate([0, 0, -angle_z_grating])
            translate([0, -9, 0])
                CameraHolder();
}


module FilmClip() {
    translate([0, 5, 0]) {
        translate([2.6, 0, 0])
            rotate([90, 0, 0])
                RoundedRectangle(x=3.5, y=y_grating+5, thickness=5, r=0.8, $fn=RESOLUTION);
        
        rotate([90, 0, 0])
            RoundedRectangle(x=2, y=y_grating+5, thickness=5, r=0.8, $fn=RESOLUTION);
    }

    translate([2-0.8, 0, 0])
        cube([0.6+0.8*2, 5, 1.5]);
    
    // stopper
    translate([2-0.8, 5, y_grating+5-3])
        rotate([90, 0, 0])
            RoundedRectangle(x=0.5+0.8, y=2, thickness=5, r=0.6, $fn=RESOLUTION);
    
    // side stopper
    translate([2.1, 0, 0])
        cube([0.6+0.8, 1, 10]);
}

module FilmHolder() {
    translate([-6.1/2, -x_grating/2, 0]) { 
        FilmClip();
        translate([0, x_grating, 0])
            mirror([0, 1, 0])
                FilmClip();
    }
}

module CameraHolder() {
    translate([-thickness/2, -x_camera/2, 0]) rotate([90, 0, 0]) rotate([0, 90, 0]) {
        difference() {
            RoundedRectangle(x_camera, y_camera,thickness, 2, RESOLUTION);
            
            // connector
            translate([0, 0, 0])
                 cube([15, 10, thickness]);
            
            // screw
            translate([2.1, 16, 0])
                cylinder(r=r_screw, h=thickness, $fn=RESOLUTION);
            
            // screw
            translate([53.5, 5, 0])
                cylinder(r=r_screw, h=thickness, $fn=RESOLUTION);
        }
    }
}

module BasePlate() {
        intersection() {
            RoundedRectangle(x_base, y_base, thickness, 4, RESOLUTION);
        difference() {
            difference() {
                cube([x_base, y_base, 3]);

                translate([-38, -0, 0])
                for (i=[0: 12]) {
                    for (j=[0:14]) {
                        translate([6.2*j+i*3.5, 5.8 *i, 0])
                            rotate([0, 0, 90])
                                cylinder(r=3, h=5, $fn=6);
                    }
                }
            }
        }
    }
        
        difference() {
            RoundedRectangle(x_base, y_base, thickness, 4, RESOLUTION);
            translate([2, 2, 0])
                RoundedRectangle(x_base-4, y_base-4, thickness, 3, RESOLUTION);
        }
}
