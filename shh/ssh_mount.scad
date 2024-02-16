// SHH shifter mount

$fn=50;

//DEPTH = 5;
//DX = 90; // x spacing of holes
//DY = 70; // y spacing of holes
//SHH_HOLE_R = 3.5; // shifter hole radius
//MOUNT_HOLE_R = 4.5; // mount hole radius
//DM = 110; // mount hole spacing

DEPTH = 5; // depth of the model
BRACE_WIDTH = DEPTH * 2;
MOUNT_HOLE_Z = 20; // mount hole Z spacing
SHH_HOLE_Y = 25; // SHH hole Y spacing
SHH_HOLE_X = 70; // SSH hole X spacing
SHH_HOLE_R = 3.6; // shifter hole radius
MOUNT_HOLE_R = 4.6; // mount hole radius

MOUNT_HOLE_X = SHH_HOLE_X + (SHH_HOLE_R * 2) - (MOUNT_HOLE_R * 2);

BORDER=3; // border radius around the model holes

MODEL_X = SHH_HOLE_X + (SHH_HOLE_R + BORDER) * 2;
MODEL_Z = MOUNT_HOLE_Z + MOUNT_HOLE_R + BORDER;
MODEL_Y = SHH_HOLE_Y + SHH_HOLE_R + BORDER;

TRIM = 0.01;

module shh_holes(r=SHH_HOLE_R, h=DEPTH) {
  cylinder(r= r, h=h);
  translate([SHH_HOLE_X, 0, 0])
  cylinder(r= r, h=h);
}

module mount_holes(r=MOUNT_HOLE_R, h=DEPTH) {
  cylinder(r= r, h=h);
  translate([MOUNT_HOLE_X, 0, 0])
  cylinder(r= r, h=h);
}

module top() {
   // top of the mount is a hull made up of two cylinders for each
   // SHH hole and a cube of the back plane
  r = SHH_HOLE_R + BORDER;
  difference() {
    hull(){
      translate([r, SHH_HOLE_Y, 0]) 
      shh_holes(r=r, h=DEPTH);
      cube([SHH_HOLE_X + r * 2, DEPTH, DEPTH]);
    }
    translate([r, SHH_HOLE_Y, -TRIM]) 
    shh_holes(h=DEPTH + TRIM * 2);
  }
}

module side() {
  // figure out the mount hole X by using the SHH hole measurements
   // top of the mount is a hull made up of two cylinders for each
   // SHH hole and a cube of the back plane
  r = MOUNT_HOLE_R + BORDER;

  translate([0, DEPTH, 0])
  rotate([90, 0, 0])
  difference() {
    hull(){
      translate([r, MOUNT_HOLE_Z, 0]) 
      mount_holes(r=r, h=DEPTH);
      cube([MOUNT_HOLE_X + r * 2, DEPTH, DEPTH]);
    }
    translate([r, MOUNT_HOLE_Z, -TRIM]) 
    mount_holes(h=DEPTH + TRIM * 2);
  }
}

module brace() {
  translate([DEPTH, 0])
  rotate([0, 270, 0])
  linear_extrude(BRACE_WIDTH)
  polygon([ [DEPTH, DEPTH], [DEPTH, MODEL_Y], [MODEL_Z, DEPTH] ]);
  
}

top();
side();
translate([20 + BRACE_WIDTH / 2, 0, 0]) brace();
translate([MODEL_X - 20 - (BRACE_WIDTH / 2), 0, 0])brace();


