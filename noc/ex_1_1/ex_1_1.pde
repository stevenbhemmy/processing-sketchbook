Mover[] movers = new Mover[20];

void setup() {
    size(640, 360);
    smooth();
    background(255);
    
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover();
    }
    /* location = new PVector(100, 100); */
    /* velocity = new PVector(2.5, 5); */
}

void draw() {
    background(255);

    for (int i = 0; i < movers.length; i++) {
        movers[i].update();
        movers[i].checkEdges();
        movers[i].display();
    }
    /* PVector mouse = new PVector(mouseX, mouseY); */
    /* PVector center = new PVector(width/2, height/2); */
    /* mouse.sub(center); */

    /* mouse.normalize(); */
    /* mouse.mult(50); */

    /* translate(width/2, height/2); */
    /* line(0, 0, mouse.x, mouse.y); */

    /* location.add(velocity); */

    /* if ((location.x > width) || (location.x < 0)) { */
    /*     velocity.x = velocity.x * -1; */
    /* } */
    /* if ((location.y > height) || (location.y < 0)) { */
    /*     velocity.y = velocity.y * -1; */
    /* } */

    /* stroke(0); */
    /* fill(175); */
    /* ellipse(location.x, location.y, 16, 16); */
}

// Reimplment portions of  Processing's PVector
class PractPVector {
    float x, y;

    PractPVector(float x_, float y_) {
        x = x_;
        y = y_;
    }

    void add(PVector v) {
        x = x + v.x;
        y = y + v.y;
    }

    void sub(PVector v) {
        x = x - v.x;
        y = y - v.y;
    }

    void mult(float n) {
        x = x * n;
        y = y * n;
    }

    void div(float n) {
        x = x / n;
        y = y / n;
    }

    float mag() {
        return sqrt(x*x + y*y);
    }

    void normalize() {
        float m = mag();
        if (m != 0) {
            div(m);
        }
    }
    
    void limit(float max) {
        if (mag() > max) {
            normalize();
            mult(max);
        }
    }
}

class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float topspeed;

    Mover() {
        location = new PVector(random(width), random(height));
        velocity = new PVector(random(-2,2), random(-2,2));
        acceleration = new PVector(-0.01, 0.01);
        topspeed = 10;
    }

    void update() {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector dir = PVector.sub(mouse, location);

        dir.normalize();
        dir.mult(0.5);
        acceleration = dir;

        velocity.add(acceleration);
        location.add(velocity);
        velocity.limit(topspeed);
    }

    void display() {
        stroke(0);
        fill(175);
        ellipse(location.x, location.y, 16, 16);
    }

    void checkEdges() {
        if (location.x > width) {
            location.x = 0;
        } else if (location.x < 0) {
            location.x = width;
        }
        if (location.y > height) {
            location.y = 0;
        } else if (location.y < 0) {
            location.y = height;
        }

    }

}
