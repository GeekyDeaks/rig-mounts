// bed level

HEIGHT = .2;

BED_SIZE = 200;

START = 10;
STEP = 20;
END = BED_SIZE / 2;


module outline(size=10) {

  difference() {
    cube([size, size, HEIGHT], center=true);
    cube([size - HEIGHT, size - HEIGHT, HEIGHT + 0.01], center=true);
  }
  
}

AA = BED_SIZE / 4;
BB = BED_SIZE - AA;

*for(o = [ [ AA, BB], [BB, AA], [BB, BB] ] ) {
  translate( [o[0], o[1], 0])
  cube([30, 30, HEIGHT], center=true);
}

for(x = [ AA, AA * 2, AA * 3, AA * 4 ], y = [ AA, AA * 2, AA * 3, AA * 4 ] ) {
  if(x > AA || y > AA)
  translate( [x, y, 0])
  difference() {
    cube([25, 25, HEIGHT], center=true);
    cube([15, 15, HEIGHT + 0.01], center=true);
  }
}


*for(x = [ AA, BB ], y = [ AA, BB ] ) {
  translate( [x, y, 0])
  for (a =[START:STEP:END]) outline(a);
}



