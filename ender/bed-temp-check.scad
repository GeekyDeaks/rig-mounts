// bed temp check

HEIGHT = .2;

module test(x=0, y=0, t=50) {
  translate( [x, y, 0]) 
  difference() {
    cube([50, 50, HEIGHT], center=true);
    translate([0, 0, -HEIGHT])
    linear_extrude(HEIGHT * 2)
    text(str(t), halign="center", valign="center");
  }
}


p = [
  [50, 150, 60],
  [150, 150, 55],
  [150, 50, 50]

];

for(a = p){
  test(x=a[0], y=a[1], t=a[2]);
}





