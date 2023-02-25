// gas holder
$fn = 50;

TRIM = 0.1;
TRIM2 = TRIM * 2;
MOUNT_WIDTH = 19.5; // width between the bars on the pedal back
MOUNT_HEIGHT = 20;
MOUNT_WALL = 2.6;

MOUNT_BOLT_HOLE_R = 5.8; // radius of the bolt
MOUNT_HOLE_R = 2.2;

MOUNT_DEPTH = 10.3; //

// 15.7 - 22.7, over 70mm
// sin = o / a = (22.7 - 15.7) / 70

MOUNT_ANGLE = asin((22.7 - 15.7) / 70);


PUCK_SCREW_R = 96 / 2;  // radius of the circle on which the screws reside
PUCK_BORDER = 3;
PUCK_SUPPORT_HEIGHT = 10;
PUCK_INNER_R = 34.5;

TAP_HOLE_R = 1.4;
TAP_HOLE_WALL = 3;
TAP_HOLE_DEPTH = 13;

echo(MOUNT_ANGLE);


// show the mount

module mount_block() {
  translate([0, 0, MOUNT_DEPTH / 2])
  difference() {
    
    cube([MOUNT_WIDTH, MOUNT_HEIGHT, MOUNT_DEPTH], center=true);
    cylinder(h = MOUNT_DEPTH + TRIM2, r = MOUNT_HOLE_R, center= true);
  }
}

module tap_holes(r=TAP_HOLE_R, h=TAP_HOLE_DEPTH) {
  // this is the delta angle of the screw hole from the 120deg
  da = asin(10 / PUCK_SCREW_R);
  
  for(d=[ -da, da ] ) {
    rotate([0, 0, d + 60])
    translate([PUCK_SCREW_R, 0, 0])
    cylinder(h=h, r=r);
    
  }
}



module puck_holder() {
  
  //tap_hole_angles = [0, 120, 240];
  tap_hole_angles = [30, 150, 270];
  
  difference() {
    union() {
      
      for(a = tap_hole_angles) {
        hull() {
          rotate([0, 0, a])
          tap_holes(r=TAP_HOLE_WALL);
          cylinder(h=TAP_HOLE_DEPTH, r=10 + TAP_HOLE_WALL);
        }
      }
      cylinder(h=TAP_HOLE_DEPTH, r=PUCK_INNER_R + PUCK_BORDER);
    }
    
    for(a = tap_hole_angles) {
      translate([0, 0, -TRIM])
      rotate([0, 0, a])
      tap_holes(r=TAP_HOLE_R, h=TAP_HOLE_DEPTH+TRIM2);
    }
    translate([0, 0, TAP_HOLE_DEPTH - PUCK_SUPPORT_HEIGHT])
    cylinder(h=PUCK_SUPPORT_HEIGHT + TRIM2, r=PUCK_INNER_R);
    
    
    translate([0, -PUCK_INNER_R + PUCK_BORDER, TAP_HOLE_DEPTH])
    rotate([90, 0, 0])
    cylinder(h=PUCK_BORDER * 2, r=PUCK_SUPPORT_HEIGHT/2);
    
    
  }
}


difference(){
  
  union() {
    mount_block();
    translate([0, 0, MOUNT_DEPTH])
    rotate([-MOUNT_ANGLE, 0, 0])
    puck_holder();
    translate([-MOUNT_WIDTH/2, -MOUNT_HEIGHT/2, MOUNT_DEPTH])
    cube([MOUNT_WIDTH, MOUNT_HEIGHT/2, 2]);
  }
  translate([0, 0, MOUNT_WALL])
  cylinder(h = 40, r = MOUNT_BOLT_HOLE_R);
}


module test_block() {
  
  td = 2;
  tw = MOUNT_WIDTH + 5;
  
  rotate([MOUNT_ANGLE, 0, 0])
  translate([-tw/2, -PUCK_INNER_R, 0])
  cube([tw, PUCK_INNER_R * 2, 2]);
  
  // block for the mount
  translate([0, 0, td])
  translate([-MOUNT_WIDTH/2, -MOUNT_HEIGHT / 2, 0])
  cube([MOUNT_WIDTH, MOUNT_HEIGHT, MOUNT_DEPTH]);
  
  // block to fill the gap
  translate([-MOUNT_WIDTH/2, -MOUNT_HEIGHT / 2, 0])
  cube([MOUNT_WIDTH, MOUNT_HEIGHT /2, 2]);
  
}

*difference() {

  test_block();
  cylinder(h=30, r=MOUNT_BOLT_HOLE_R, center=true);
}



