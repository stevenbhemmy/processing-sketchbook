// setup and background 
size(500, 300);
smooth();
background(230, 230, 230);
// draw two crossed lines
stroke(130, 0, 0);
strokeWeight(4);
line(width/2-70, height/2-70, width/2+70, height/2+70);
line(width/2+70, height/2-70, width/2-70, height/2+70);
// draw a filled circle too
fill(255, 150);
ellipse(width/2, height/2, 50, 50);
