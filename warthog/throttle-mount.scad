// hotas throttle mount

module side_mounts(depth=5, spacing=40, dz=20, border=10, adjust=2, r=4.2) {
  
  trim = 0.1;
  trim2 = trim * 2;
  
  module copy_mirror(vec=[0, 1, 0])
  { 
      children(); 
      mirror(vec) children(); 
  }
  
  copy_mirror([1, 0, 0])
  translate([spacing / 2, 0, 0]) {
    
    difference() {
      
      union() {
        
        
        // supports
        copy_mirror([0, 1, 0])
        translate([depth, r + border - depth, 0])
        rotate([-90, 0, 0])
        linear_extrude(depth)
        polygon([ [0, 0], [dz, 0], [0, dz] ]);
      
        hull() {
          translate([0, -(r + border), -1])
          cube([depth, (r + border) * 2, 1]);
          translate([0, 0, -dz - adjust])
          rotate([0, 90, 0])
          cylinder(h = depth, r = r + border);
        }
      }
      
      hull() {
        translate([-trim, 0, -dz + adjust])
        rotate([0, 90, 0])
        cylinder(h = depth + trim2, r = r);
        translate([-trim, 0, -dz - adjust])
        rotate([0, 90, 0])
        cylinder(h = depth + trim2, r = r);
      }
    }
  }
}

module top(depth=5, hole_dx=110, r=3.2, border=6, offset=10) {
  
  trim = 0.1;
  trim2 = trim * 2;
  
  dy = 10;
  
  difference() {
   
    hull() {
      translate([hole_dx / 2 - offset, dy/2, 0])
      cylinder(h=depth, r=r+border);
      translate([-hole_dx / 2 - offset, dy/2, 0])
      cylinder(h=depth, r=r+border);
      translate([hole_dx / 2 - offset, -dy/2, 0])
      cylinder(h=depth, r=r+border);
      translate([-hole_dx / 2 - offset, -dy/2, 0])
      cylinder(h=depth, r=r+border);
    }
    
    translate([hole_dx / 2 - offset, 0, -trim])
    cylinder(h=depth + trim2, r=r);
    translate([-hole_dx / 2 - offset, 0, -trim])
    cylinder(h=depth + trim2, r=r);
  }
   
}

rotate([180, 0, 0]) {
  side_mounts();
  top();
}