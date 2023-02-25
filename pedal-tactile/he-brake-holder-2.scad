// HE brake pedal tactile
// dayton puck mount
$fn=50;

PEDAL_BRACKET_WIDTH = 36.5;

HOLE_DISTANCE = 104.5; // distance between the two support holes


TOP_HOLE_DZ = 8.5; // distance from top hole to back of bracket
BOTTOM_HOLE_DZ = 6;

BRACKET_WALL_DEPTH = 2.5; // depth of wall along bracket
BRACKET_WALL_BORDER = 2.5;
PUCK_SUPPORT_DEPTH = 9;

TAP_HOLE_R = 1.5;
TAP_HOLE_WALL = 2.5;
TAP_HOLE_DEPTH = 9;

SUPPORT_HOLE_R = 2.3;
TRIM=0.1;
TRIM2=TRIM * 2;

//hr = SUPPORT_HOLE_R + BRACKET_WALL_BORDER;

PUCK_SCREW_R = 96 / 2;  // radius of the circle on which the screws reside
PUCK_BORDER = 5;
PUCK_SUPPORT_HEIGHT = 9;

PUCK_INNER_R = 36;
 
// this is the delta angle of the screw hole from the 120deg
DA = asin(10 / PUCK_SCREW_R);

TAP_HOLE_DEGS = [ -DA, DA, -DA + 120, DA + 120, -DA - 120, DA - 120];

echo(TAP_HOLE_DEGS);

module copy_mirror(vec=[0, 1, 0])
{ 
    children(); 
    mirror(vec) children(); 
}

module support_brace(h=1) {
  base = 6;
  translate([0, 0, base])
  rotate([0, 90, 0])
  linear_extrude(BRACKET_WALL_DEPTH)
  polygon([[0, 0], [base, 0], [base, h]]);
}

module bracket_support(dz=1) {
 
  w = SUPPORT_HOLE_R + BRACKET_WALL_BORDER * 2;
  difference() {
    
    hull() {
      cylinder(r=SUPPORT_HOLE_R + BRACKET_WALL_BORDER, h=BRACKET_WALL_DEPTH);
      translate([-w, -dz, 0])
      cube([w * 2, dz, BRACKET_WALL_DEPTH ]);
    }
    translate([0, 0, -TRIM])
    cylinder(r=SUPPORT_HOLE_R, h=BRACKET_WALL_DEPTH + TRIM2);
    
  }
  
  // put some braces in
  translate([-w, -dz, BRACKET_WALL_DEPTH])
  support_brace(h=dz);
  
  translate([w - BRACKET_WALL_DEPTH, -dz, BRACKET_WALL_DEPTH])
  support_brace(h=dz);
}


module left_brackets() {
  
  rotate([90, 0, 0]) {
    
    translate([0, TOP_HOLE_DZ, 0])
    bracket_support(dz=TOP_HOLE_DZ);
    translate([HOLE_DISTANCE, BOTTOM_HOLE_DZ, 0])
    bracket_support(dz=BOTTOM_HOLE_DZ);
  }
}

module tap_holes(r=TAP_HOLE_R, h=TAP_HOLE_DEPTH) {
  for(d=TAP_HOLE_DEGS) {
    rotate([0, 0, d + 60])
    translate([PUCK_SCREW_R, 0, 0])
    cylinder(h=h, r=r);
    
  }
}

copy_mirror() {
  translate([ -HOLE_DISTANCE / 2, -PEDAL_BRACKET_WIDTH / 2, PUCK_SUPPORT_HEIGHT])
  left_brackets();
}



// ring for the puck

module puck_holder() {
  hull() {
    
    // main cylinder for the puck
    cylinder(r=PUCK_SCREW_R + PUCK_BORDER, h=PUCK_SUPPORT_HEIGHT);

    // do some cylinders under each support
    
    copy_mirror() {
      translate([ -HOLE_DISTANCE / 2, PEDAL_BRACKET_WIDTH / 2 + 6, 0])
      cylinder(h = PUCK_SUPPORT_HEIGHT, r = 12);
    }

    copy_mirror() {
      translate([ HOLE_DISTANCE / 2, PEDAL_BRACKET_WIDTH / 2 + 6, 0])
      cylinder(h = PUCK_SUPPORT_HEIGHT, r = 12);
    }
  }
}

// build up the main base using a few different hulls()

module base() {
  
  copy_mirror() 
  hull() {
    translate([ -HOLE_DISTANCE / 2 - 1, PEDAL_BRACKET_WIDTH / 2 + 3, 0])
    cylinder(h = PUCK_SUPPORT_HEIGHT, r = 10);
    
    translate([ HOLE_DISTANCE / 2 + 1, PEDAL_BRACKET_WIDTH / 2 + 3, 0])
    cylinder(h = PUCK_SUPPORT_HEIGHT, r = 10);
  }
  
  hull() tap_holes(r=TAP_HOLE_R + TAP_HOLE_WALL);
  
  cylinder(h = PUCK_SUPPORT_HEIGHT, r = PUCK_INNER_R + PUCK_BORDER);

}

difference() {
  
  base();
  
  // hole for the puck
  translate([0, 0, -TRIM])
  cylinder(r=PUCK_INNER_R, h=PUCK_SUPPORT_HEIGHT + TRIM2);
  translate([0, 0, -TRIM])
  tap_holes(h=TAP_HOLE_DEPTH + TRIM2);
  
  // space for wires
  translate([PUCK_INNER_R - 1, 0, 0])
  rotate([0, 90, 0])
  cylinder(h=10, r= PUCK_SUPPORT_HEIGHT/2);
  
}


