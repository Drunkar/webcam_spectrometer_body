use <./openscad_modules/modules/RoundedRectangle.scad>;

r_LED = 2.6;
thickness = 2;
x_base = 44;
y_base = 100-4;
x_slit = y_base;
y_slit = 30-5-thickness-2;
x_sample_chamber = 16;
x_LED_holder = x_sample_chamber;
y_LED_holder = y_slit+5+2;
RESOLUTION = 50;



BasePlate();

// center indicator
translate([0, y_base/2-0.5, 0])
        cube([x_base/4+3, 1, thickness]);

translate([0, 0, thickness])
        SlitHolder();

translate([0, y_base/2, 0])
                LEDHolder();


module SlitClip() {
    translate([0, 5, 0]) {
        translate([2.6, 0, 0])
            rotate([90, 0, 0])
                RoundedRectangle(x=3.5, y=y_slit+5, thickness=5, r=0.8, $fn=RESOLUTION);
        
        rotate([90, 0, 0])
            RoundedRectangle(x=2, y=y_slit+5, thickness=5, r=0.8, $fn=RESOLUTION);
    }

    translate([2-0.8, 0, 0])
        cube([0.6+0.8*2, 5, 1.5]);
    
    // stopper
    translate([2-1, 5, y_slit+5-3])
        rotate([90, 0, 0])
            RoundedRectangle(x=0.5+0.8, y=2, thickness=5, r=0.6, $fn=RESOLUTION);
    
    // side stopper
    translate([2.1, 0, 0])
        cube([0.6+0.8, 1, 10]);
    
    // bottom
    cube([6.1, 5, 1]);
}

module SlitHolder() {
    SlitClip();
    translate([0, x_slit, 0])
        mirror([0, 1, 0])
            SlitClip();
}

module LEDHolder() {

    translate([0, -x_sample_chamber/2-thickness, 0])
        difference() {
            RoundedRectangle(x_base-10+thickness, x_sample_chamber+2*thickness, y_LED_holder, 2, RESOLUTION);
            translate([0, thickness, 0])
                RoundedRectangle(x_base-10, x_sample_chamber, y_LED_holder, 2, RESOLUTION);
            
            // LED hole
            rotate([90, 0, 0]) rotate([0, 90, 0])
            translate([x_sample_chamber/2+thickness, 15, 0])
                cylinder(r=r_LED, h=thickness*40, $fn=RESOLUTION);
            
            translate([0, -y_base/2, 0])
                cube([2.6, y_base, x_base]);
        }
}

module BasePlate() {
    cube([x_base, y_base, thickness]);
    
    // screw hole
    rotate([90, 0, 0]) {
        translate([5, 0, -5]) {
            difference() {
                RoundedRectangle(10, 12, 5, 1, RESOLUTION);
                translate([10/2, 6, 0])
                    cylinder(r=1.5, h=10, $fn=RESOLUTION);
            }
            
            translate([x_base-15, 0, 0])
            difference() {
                RoundedRectangle(10, 12, 5, 1, RESOLUTION);
                translate([10/2, 6, 0])
                    cylinder(r=1.5, h=10, $fn=RESOLUTION);
            }
            
            translate([0, 0, -y_base+5]) {
                difference() {
                    RoundedRectangle(10, 12, 5, 1, RESOLUTION);
                    translate([10/2, 6, 0])
                        cylinder(r=1.5, h=10, $fn=RESOLUTION);
                }
                
                translate([x_base-15, 0, 0])
                difference() {
                    RoundedRectangle(10, 12, 5, 1, RESOLUTION);
                    translate([10/2, 6, 0])
                        cylinder(r=1.5, h=10, $fn=RESOLUTION);
                }
            }
        }
    }
}
