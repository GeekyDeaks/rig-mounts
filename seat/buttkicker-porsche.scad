// buttkicker mount for porsche seat

$fn=50;


BK_R = 14;
BK_HEIGHT = 38;

BASE_R = 16;

BOLT_R = 3.3;

BASE_HEIGHT = 5;

TRIM = 0.1;
TRIM2 = TRIM * 2;


// top

*difference() {
  union() {
    
    translate([0, 0, BASE_HEIGHT])
    cylinder(h = BK_HEIGHT / 2, r = BK_R);
    cylinder(h = BASE_HEIGHT, r = BASE_R);
  }
  translate([0, 0, -TRIM])
  cylinder(h = BK_HEIGHT + BASE_HEIGHT + TRIM2, r = BOLT_R);
}

// bottom
difference() {
  union() {
    
    translate([0, 0, BASE_HEIGHT])
    cylinder(h = BK_HEIGHT / 2, r = BK_R);
    cylinder(h = BASE_HEIGHT, r = BASE_R);
  }
  translate([0, 0, -TRIM])
  cylinder(h = BK_HEIGHT + BASE_HEIGHT + TRIM2, r = BOLT_R);
  translate([0, 0, -TRIM])
  cylinder(h = 5, r = 5);
}