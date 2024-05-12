$fn=50;

OVERLAP=0.01; // how much bigger to make the object we want to remove
              // to ensure it fully removes it
              
DEPTH=3; // print depth of the holder

PROFILE_SIZE=40; // size of the alu profile
CM_R=3.5; // M size of the camera mounting (CM) bolt
CM_X=100; // distance of the mount hole from the left
CM_Y=100; // distance of the mount hole from the bottom
CM_Z=40; // distance of the mount hole from the front

MM_HOLE_R=2.5; // M size of the model mounting (MM) bolt
MM_X=10; // offset of the MM hole in the X
MM_Y=10; // offset of the MM hole in the Y

CM_SUPPORT_WIDTH=30; // width of the support

module front_plate() {
    
    difference() {
        cube([CM_X + CM_SUPPORT_WIDTH / 2, PROFILE_SIZE, DEPTH]);
        
        translate([MM_X, MM_Y, -OVERLAP/2])
        cylinder(h = DEPTH + OVERLAP, r = MM_HOLE_R);
        
        translate([PROFILE_SIZE - MM_X, PROFILE_SIZE - MM_Y, -OVERLAP/2])
        cylinder(h = DEPTH + OVERLAP, r = MM_HOLE_R);
    }
}

module cm_bracket() {
    rotate([0, 270, 0])
    linear_extrude(DEPTH)
    polygon(points=[
        [0, 0], 
        [CM_Z + CM_SUPPORT_WIDTH / 2, CM_Y - CM_SUPPORT_WIDTH], 
        [CM_Z + CM_SUPPORT_WIDTH / 2, CM_Y],
        [CM_Z - CM_SUPPORT_WIDTH / 2, CM_Y],
        [0, PROFILE_SIZE]
    ]);
}

module cm_plate() {
    rotate([90, 0, 0])
    difference() {
        cube([CM_SUPPORT_WIDTH, CM_SUPPORT_WIDTH, DEPTH]);
        
        translate([CM_SUPPORT_WIDTH / 2, CM_SUPPORT_WIDTH / 2, -OVERLAP / 2])
        cylinder(h = DEPTH + OVERLAP, r = CM_R);
    }
}

front_plate();

union() {
    
    w_offset = (CM_SUPPORT_WIDTH / 2) - (DEPTH / 2);
    
    translate([CM_X - (CM_SUPPORT_WIDTH / 2), 0, DEPTH])
    cm_bracket();
    translate([CM_X + (CM_SUPPORT_WIDTH / 2), 0, DEPTH])
    cm_bracket();
    translate([
       CM_X - (CM_SUPPORT_WIDTH / 2) - DEPTH / 2, 
       CM_Y, 
       CM_Z - (CM_SUPPORT_WIDTH / 2) + DEPTH
    ])
    cm_plate();
}
