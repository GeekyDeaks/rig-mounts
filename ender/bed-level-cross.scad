// bed level cross

HEIGHT = 0.2;
LINE_WIDTH = 20;

BED_X = 230;
BED_Y = 230;

union() {
  
  hull() {
    translate([ 50 + LINE_WIDTH / 2, 50 + LINE_WIDTH / 2, 0])
    cylinder(h = HEIGHT, d = LINE_WIDTH);

    translate([BED_X - LINE_WIDTH, BED_Y - LINE_WIDTH, 0])
    cylinder(h = HEIGHT, d = LINE_WIDTH);
  }

  hull() {
    translate([BED_X - LINE_WIDTH, LINE_WIDTH, 0])
    cylinder(h = HEIGHT, d = LINE_WIDTH);

    translate([LINE_WIDTH, BED_Y - LINE_WIDTH, 0])
    cylinder(h = HEIGHT, d = LINE_WIDTH);
  }
}
