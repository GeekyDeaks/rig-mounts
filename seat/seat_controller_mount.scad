$fn=50;

PART="BOTH";
//PART="LEFT";
//PART="RIGHT";

// delta for top holes
TOP_DX = 200;
TOP_DY = 10;

// delta for right holes
RIGHT_DX = -1;
RIGHT_DY = 53;

// delta for left holes
LEFT_DX = 9;
LEFT_DY = 33;

HOLE_RADIUS = 2.5;
HEIGHT = 40;
TAP_RADIUS = 1.3;
TAP_HEIGHT = 10;

module column(height=40, width = 12) {

  difference() {
    union() {
      cylinder(h = height, r = width/2);
      translate([-width/2, -width/2, 0])
      cube([width, width/2, height]);
    }
    // tap hole
    translate([0, 0, height - TAP_HEIGHT + 0.01])
    cylinder(h = TAP_HEIGHT, r = TAP_RADIUS);
  }
}

module support(length=10, width=12) {
  
  t = 4 ; // 3mm thickness
  cr = 3; // cutout radius
  
  // columns
  column();
  rotate([0, 0, 180])
  translate([0, length, 0])
  column();
  
  l = length - width;
  // bottom
  translate([-width/2, -l - width /2 , 0]) {
    difference() {
      cube([width, l, t]);
        // cutout
      hull() {
        translate([width/2, width/2, -0.01])
        cylinder(h=t+0.02, r=cr);
        translate([width/2, l - width/2, -0.01])
        cylinder(h=t+0.02, r=cr);
      }
    }
  }
  // top
  translate([-width/2, -l - width / 2, HEIGHT - t])
  cube([width, l, t]);  
 
}

LEFT_ROTATE = atan(LEFT_DX / LEFT_DY);
LEFT_LEN = sqrt(LEFT_DX ^ 2 + LEFT_DY ^ 2);
RIGHT_ROTATE = atan(RIGHT_DX / RIGHT_DY);
RIGHT_LEN = sqrt(RIGHT_DX ^ 2 + RIGHT_DY ^ 2);

if(PART=="BOTH") {
  rotate([0, 0, LEFT_ROTATE])
  support(length = LEFT_LEN);

  translate([TOP_DX, TOP_DY, 0])
  rotate([0, 0, RIGHT_ROTATE])
  support(length = RIGHT_LEN);
}

if(PART=="LEFT") support(length = LEFT_LEN);
if(PART=="RIGHT") support(length = RIGHT_LEN);




