// HE brake pedal tactile
// dayton puck mount
$fn=50;

PEDAL_BRACKET_WIDTH = 36.5;

HOLE_DISTANCE = 104.5; // distance between the two support holes


TOP_HOLE_DZ = 8.5; // distance from top hole to back of bracket
BOTTOM_HOLE_DZ = 6;

BRACKET_WALL_DEPTH = 2.5; // depth of wall along bracket
BRACKET_WALL_BORDER = 3;
PUCK_SUPPORT_DEPTH = 5;

TAPPED_HOLE_R = 1.5;

SUPPORT_HOLE_R = 2.2;
OVERLAP=0.1;

hr = SUPPORT_HOLE_R + BRACKET_WALL_BORDER;

!difference() {
  
  union() {
    
    // draw two cylinder at the bracket face for use with a hull()
    hull() {
      translate([0, hr, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
      //cube([w, BRACKET_WALL_DEPTH, w]);
      translate([HOLE_DISTANCE, hr, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
    }
    
    hull() {
      translate([0, hr, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
      translate([0, TOP_HOLE_DZ, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
    }
    

    hull() {
      translate([HOLE_DISTANCE, hr, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
      translate([HOLE_DISTANCE, BOTTOM_HOLE_DZ, 0])
      cylinder(h = BRACKET_WALL_DEPTH, r= hr);
    }


  }


  translate([0, TOP_HOLE_DZ, -OVERLAP])
  cylinder(h = BRACKET_WALL_DEPTH  + OVERLAP * 2, r= SUPPORT_HOLE_R);


  translate([HOLE_DISTANCE, BOTTOM_HOLE_DZ, -OVERLAP])
  cylinder(h = BRACKET_WALL_DEPTH  + OVERLAP * 2, r= SUPPORT_HOLE_R);
}



difference() {
  
  linear_extrude(BRACKET_WALL_DEPTH)
  offset(r=-BRACKET_WALL_BORDER / 2)
  offset(r=BRACKET_WALL_BORDER * 2)
  // make a thin polygon around the points we want to use
  polygon([
    [-0.1, 0],
    [HOLE_DISTANCE + 0.1, 0],
    [HOLE_DISTANCE + 0.1, BOTTOM_HOLE_DZ],
    [HOLE_DISTANCE - 0.1, BOTTOM_HOLE_DZ],
    [HOLE_DISTANCE + 0.1, 0.1],
    [0.1, 0.1],
    [0.1, TOP_HOLE_DZ],
    [-0.1, TOP_HOLE_DZ]
  ]);
  
  translate([0, TOP_HOLE_DZ, -OVERLAP])
  cylinder(h = BRACKET_WALL_DEPTH  + OVERLAP * 2, r= SUPPORT_HOLE_R);


  translate([HOLE_DISTANCE, BOTTOM_HOLE_DZ, -OVERLAP])
  cylinder(h = BRACKET_WALL_DEPTH  + OVERLAP * 2, r= SUPPORT_HOLE_R);
  
}




