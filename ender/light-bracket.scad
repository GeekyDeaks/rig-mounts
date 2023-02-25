$fn=50;

LIGHT_R=40;
DEPTH=2; // print depth of the holder
WIDTH=30; // holder width

OVERLAP=0.01; // how much bigger to make the object we want to remove
              // to ensure it fully removes it

module light_profile(r=LIGHT_R, width=WIDTH) {
   // light profile is a quarter cylinder, we get this by taking a cylinder
   // and intersecting it with a cube
   intersection() {
      rotate([0, 90, 0])
      cylinder(r=r, h=width);
      cube([width, r, r]);
   }
}

module bracket() {
  //the bracket a bigger light profile with a smaller one removed
  difference() {
    light_profile(r=LIGHT_R + DEPTH * 2, width=WIDTH);
    translate([-OVERLAP, DEPTH, DEPTH])
    light_profile(r=LIGHT_R, width=WIDTH + OVERLAP * 2);
    // and remove the front of the bracket with a cube
    translate([-OVERLAP, DEPTH * 3, DEPTH * 3])
    cube([WIDTH + OVERLAP * 2, LIGHT_R, LIGHT_R]);
  }
}


bracket(); // first bracket

translate([100, 0, 0])
bracket(); // second bracket
