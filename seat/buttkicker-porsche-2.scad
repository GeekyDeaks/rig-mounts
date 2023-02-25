// buttkicker porsche v2

$fn=100;


// sides 85, 63, 38

// A[85; 0] B[0; 0] C[27.647; 26.07]
A = [0, 1.5];
B = [85, 0];
C = [27.6, 26];
CM = [27.6, -26];

TRIM = 0.1;
TRIM2 = TRIM * 2;


function radius_from_segment(h, w) = ( h / 2) + ( w^2 / (h * 8) );

function circle_center(x1, y1, x2, y2, r) = [ 
    (x1+x2)/2 - sqrt(r^2-( sqrt((x2-x1)^2 + (y2-y1)^2)  /2)^2)*(y1-y2)/ sqrt((x2-x1)^2 + (y2-y1)^2) ,
    (y1+y2)/2 - sqrt(r^2-( sqrt((x2-x1)^2 + (y2-y1)^2)  /2)^2)*(x2-x1)/ sqrt((x2-x1)^2 + (y2-y1)^2)  
];

module copy_mirror(vec=[0, 1, 0])
{ 
    children(); 
    mirror(vec) children(); 
}

echo(circle_center(B[0], B[1], C[0], C[1], 152));

BA_R = radius_from_segment(h=2.5, w=85);
BC_R = radius_from_segment(h=2.5, w=63);


echo(radius_from_segment(h=2.5, w=63));
echo(radius_from_segment(h=2.8, w=85));

// A[76; 0] B[0; 0] C[26.158; 23.254]

module side(base_height=8, inner_height=18) {
  
  difference() {

    intersection() {
      linear_extrude(inner_height + base_height)
      offset(r=2)
      offset(r=-2)
      polygon([ A, B, C ]);
      translate(circle_center(B[0], B[1], A[0], A[1], BA_R))
      cylinder(30, r=BA_R);
      
    }
    translate(circle_center(B[0], B[1], C[0], C[1], BC_R))
    cylinder(30, r=BC_R);
  }

  linear_extrude(base_height)
  offset(r=2.5)
  polygon([ A, B, [C[0] + 5, C[1] + 5], [C[0] - 5, C[1] + 5] ]);
}

module holes() {
 
  //bit at the front
  translate([-20, 28, -TRIM])
  cube([100, 10, 2]);
  
  translate([33, 0, -TRIM])
  hull() {
    cylinder(h = 35, r = 3.2);
    translate([0, 3, 0])
    cylinder(h = 35, r = 3.2);
  }
  
  translate([0, 9, -TRIM])
  hull() {
    cylinder(h = 35, r = 3.2);
    translate([0, 6, 0])
    cylinder(h = 35, r = 3.2);
  }
  
  
  
}

module bottom() {
  difference() {
  
    rotate([0, 0, -90])
    translate([-C[0], 0, 0])
    copy_mirror()
    translate([0, -C[1] - 2.5, 0])
    side();
    
    translate([-23, -3, 0])
    holes();
  }
}

module top() {
  difference() {
    
    mirror([0, 0, 1])
    rotate([0, 0, -90])
    translate([-C[0], 0, 0])
    copy_mirror()
    translate([0, -C[1] - 2.5, 0])
    side(base_height=2);
  
    translate([-23, -3, -30])
    holes();
  }
}


*bottom();

//translate([0, 0, 60])

difference(){
  rotate([0 , 180, 0])
  top();
  translate([-50,-70,-1])
  cube([100,50,50]);
}

