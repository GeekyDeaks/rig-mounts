$fn=100;

// spacer for inserting into a front mount style wheel bracket
// so that the CS DD+ can be mounted on top
//
// it captures the bolts to the CD DD+ so that they should
// almost rest against the outer edge of the hole
// allowing half the washer to bind the wheel bracket


OVERLAP=0.01;
SUPPORT_WIDTH=10;

// wheel bracket hole radius and thickness
DEPTH=15;
HOLE_R=55;

// mounting bolt size M6
BOLT_R=3;

// figure out rotation angle for the mounting bolt hole
// width between centers on fanatec mount points
MOUNT_SPACE=40;
MOUNT_ANGLE = acos(MOUNT_SPACE / (HOLE_R - BOLT_R));

LOCK_R = 4;
// width between locking nub centers
LOCK_WIDTH = 55/2;
// figure out rotation angle for the locking nub
LOCK_ANGLE = acos(LOCK_WIDTH / HOLE_R);


module copy_mirror(vec=[0,1,0]) 
{ 
    children(); 
    mirror(vec) children(); 
}


difference() {
    
  cylinder(DEPTH, r=HOLE_R, center = true);
  cylinder(DEPTH + OVERLAP, r=HOLE_R - SUPPORT_WIDTH, center = true);
    
  copy_mirror([1,0,0])
  copy_mirror()
  rotate([0,0, -MOUNT_ANGLE])
  hull() {
      translate([HOLE_R - BOLT_R, 0, 0])  
      cylinder(DEPTH + OVERLAP, r=BOLT_R, center=true);
      translate([HOLE_R, 0, 0])  
      cylinder(DEPTH + OVERLAP, r=BOLT_R, center=true);
  }
}




// add the locking nubs
copy_mirror([1,0,0])
copy_mirror()
rotate([0, 0, LOCK_ANGLE])
translate([HOLE_R, 0, 0])
cylinder(DEPTH, r=LOCK_R, center=true);


