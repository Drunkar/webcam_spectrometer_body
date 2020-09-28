// 金属ケース　ＹＭ－１００
// http://akizukidenshi.com/catalog/g/gP-09534/

cut_margin = 0.1;
x_box = 100;
y_box = 70;
z_box= 30;

%cube([x_box, y_box, z_box]);

y_offset = y_box;
square([x_box, y_box]);

// bottom
for (i=[0:1]) {

    translate([0, y_offset+y_box*i+z_box*i, 0]) {
        square([x_box, z_box]);
        translate([x_box, cut_margin/2, 0])
            square([z_box, z_box-cut_margin]);
        translate([-z_box, cut_margin/2, 0])
            square([z_box, z_box-cut_margin]);
    }


    translate([0, y_offset+y_box*i+z_box*(i+1), 0]) {
        square([x_box, y_box+5*i]);
        translate([x_box, cut_margin/2, 0])
            square([z_box, y_box-cut_margin+5*i]);
        translate([-z_box, cut_margin/2, 0])
            square([z_box, y_box-cut_margin+5*i]);  
    }

}

translate([0, y_offset+y_box*2+z_box*2+5, 0]) {
    square([x_box, z_box]);
}