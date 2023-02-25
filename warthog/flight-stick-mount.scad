// warthog stick mount

$fn=50;


L_HOLE_DX = 60.1;
L_HOLE_DY = 60.1;
L_HOLE_R = 2.4;




BASE_R = 55;
BASE_HEIGHT = 5;

MOUNT_HOLE_BORDER = 10;
MOUNT_HOLE_DY = (BASE_R * 2) + MOUNT_HOLE_BORDER * 2;
MOUNT_HOLE_R = 4.2;
MOUNT_HOLE_X_OFFSET = -10;

MOUNT_HOLE_Z = 20; // mount hole Z spacing
MOUNT_SPACING = 40;
MOUNT_HOLE_ADJUST = 2; // mount hole adjustment from Z


TRIM = 0.1;
TRIM2 = 0.2;

module copy_mirror(vec=[0, 1, 0])
{ 
    children(); 
    mirror(vec) children(); 
}


module lower_mount_holes(h=BASE_HEIGHT, r1=L_HOLE_R, r2=L_HOLE_R) {
  dx = L_HOLE_DX / 2;
  dy = L_HOLE_DY / 2;
  for(x=[ -dx, dx], y=[-dy, dy]) {
    translate([x, y, 0])
    cylinder(h=h, r1=r1, r2=r2);
  }
}

module countersunk_base() {
  difference() {
    union() {
      cylinder(h = BASE_HEIGHT, r = BASE_R);
      hull() {
        translate([MOUNT_HOLE_X_OFFSET, MOUNT_HOLE_DY / 2, 0])
        cylinder(h=BASE_HEIGHT, r=MOUNT_HOLE_R + MOUNT_HOLE_BORDER);
        translate([MOUNT_HOLE_X_OFFSET, -MOUNT_HOLE_DY / 2, 0])
        cylinder(h=BASE_HEIGHT, r=MOUNT_HOLE_R + MOUNT_HOLE_BORDER);
      }
    }
    
    translate([0, 0, -TRIM])
    lower_mount_holes(h=BASE_HEIGHT + TRIM2);
    
    translate([0, 0, -TRIM])
    lower_mount_holes(h=BASE_HEIGHT / 2, r1=L_HOLE_R * 3, r2=L_HOLE_R * 3);
    
    translate([MOUNT_HOLE_X_OFFSET, MOUNT_HOLE_DY / 2, -TRIM])
    cylinder(h=BASE_HEIGHT +TRIM2, r=MOUNT_HOLE_R);
    translate([MOUNT_HOLE_X_OFFSET, -MOUNT_HOLE_DY / 2, -TRIM])
    cylinder(h=BASE_HEIGHT + TRIM2, r=MOUNT_HOLE_R);
  }
}

module simple_base() {
  
  difference() {
    
    cylinder(h = BASE_HEIGHT, r = BASE_R);
    translate([0, 0, -TRIM])
    lower_mount_holes(h=BASE_HEIGHT + TRIM2);
  }
}

module sides() {
  
  copy_mirror([1, 0, 0])
  translate([MOUNT_SPACING / 2, 0, 0]) {
    
  
    difference() {
      
      union() {
        
        
        // supports
        copy_mirror([0, 1, 0])
        translate([BASE_HEIGHT, MOUNT_HOLE_R + MOUNT_HOLE_BORDER - BASE_HEIGHT, 0])
        rotate([-90, 0, 0])
        linear_extrude(BASE_HEIGHT)
        polygon([ [0, 0], [MOUNT_HOLE_Z, 0], [0, MOUNT_HOLE_Z] ]);
      
        hull() {
          translate([0, -(MOUNT_HOLE_R + MOUNT_HOLE_BORDER), -1])
          cube([BASE_HEIGHT, (MOUNT_HOLE_R + MOUNT_HOLE_BORDER) * 2, 1]);
          translate([0, 0, -MOUNT_HOLE_Z - MOUNT_HOLE_ADJUST])
          rotate([0, 90, 0])
          cylinder(h = BASE_HEIGHT, r = MOUNT_HOLE_R + MOUNT_HOLE_BORDER);
        }
      }
      
      hull() {
        translate([-TRIM, 0, -MOUNT_HOLE_Z + MOUNT_HOLE_ADJUST])
        rotate([0, 90, 0])
        cylinder(h = BASE_HEIGHT + TRIM2, r = MOUNT_HOLE_R);
        translate([-TRIM, 0, -MOUNT_HOLE_Z - MOUNT_HOLE_ADJUST])
        rotate([0, 90, 0])
        cylinder(h = BASE_HEIGHT + TRIM2, r = MOUNT_HOLE_R);
      }
    }
  }
}

rotate([180, 0, 0]) {
  simple_base();
  sides();
}





