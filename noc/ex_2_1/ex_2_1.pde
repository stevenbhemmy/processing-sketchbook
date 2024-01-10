Mover[] movers = new Mover[30];
Liquid liquid;

void setup() {
    size(640, 360);
    smooth();
    background(255);
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(random(0.2,5), random(0,width), 0);
    }
    liquid = new Liquid(0, height/2, width, height/2, 0.05);
}

void draw() {
    background(255);

    // PVector wind = new PVector(0.002, 0);
    liquid.display();

    for (int i = 0; i < movers.length; i++) {

        if (movers[i].isInside(liquid)) {
            movers[i].drag(liquid);
        }

        float m = 0.1 * movers[i].mass;
        PVector gravity = new PVector(0, m);
        
        float c = 0.005;
        // PVector friction = movers[i].velocity.get();
        // friction.mult(-1);
        // friction.normalize();
        // friction.mult(c);

        // movers[i].applyForce(friction);
        // movers[i].applyForce(wind);
        movers[i].applyForce(gravity);

        movers[i].update();
        movers[i].checkEdges();
        movers[i].display();
    }
}

class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass;

    Mover(float m, float x, float y) {
        mass = m;
        location = new PVector(x, y);
        velocity = new PVector(0, 0);
        acceleration = new PVector(0, 0);
    }

    void update() {
        velocity.add(acceleration);
        location.add(velocity);
        acceleration.mult(0);
    }

    void display() {
        stroke(0);
        fill(175);
        ellipse(location.x, location.y, mass*16, mass*16);
    }

    void checkEdges() {
        if (location.x > width) {
            velocity.x *= -1;
            location.x = width;
        } else if (location.x < 0) {
            velocity.x *= -1;
            location.x = 0;
        }
        if (location.y > height) {
            velocity.y *= -1;
            location.y = height;
        } else if (location.y < 0) {
            velocity.y *= -1;
            location.y = -1;
        }

    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    boolean isInside(Liquid l) {
        if (location.x > l.x && location.x < l.x+l.w && location.y > l.y && location.y < l.y+l.h)
        {
            return true;
        }
        return false;
    }

    void drag(Liquid l) {
        float speed = velocity.mag();
        float dragMagnitude = l.c * speed * speed;

        PVector drag = velocity.get();
        drag.mult(-1);
        drag.normalize();

        drag.mult(dragMagnitude);

        applyForce(drag);
    }
}

class Liquid {
    float x, y, w, h;
    float c;

    Liquid(float x_, float y_, float w_, float h_, float c_) {
        x =  x_;
        y =  y_;
        w = w_;
        h = h_;
        c = c_;
    }

    void display() {
        noStroke();
        fill(175);
        rect(x,y,w,h);
    }
}

