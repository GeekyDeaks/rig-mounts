// bed level

HEIGHT = .5;

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

for(o = [ [ AA, BB], [BB, AA], [BB, BB] ] ) {
  translate( [o[0], o[1], 0])
  for (a =[START:STEP:END]) outline(a);
}


*for(x = [ AA, BB ], y = [ AA, BB ] ) {
  translate( [x, y, 0])
  for (a =[START:STEP:END]) outline(a);
}



