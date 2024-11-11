Mover[] movers = new Mover[10];
Attractor a;
Liquid liquid;

void setup() {
    size(640, 360);
    smooth();
    background(255);
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(random(0.1, 2), random(width), random(height));
    }
    a = new Attractor();


}

void draw() {
    background(255);

    a.display();

    for (int i = 0; i < movers.length; i++) {
        for (int j = 0; j < movers.length; j++) {
            if (i != j) {
                PVector force = movers[j].attract(movers[i]);
                movers[i].applyForce(force);
            }
        }
        movers[i].update();
        movers[i].display();
    }

}

class Mover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float G = 0.4;
    float mass;

    Mover() {
        mass = random(0.2, 5);
        location = new PVector(random(0, width), random(0, width));
        velocity = new PVector(random(-2,2), random(-2,2));
        acceleration = new PVector(0, 0);
    }

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

    PVector attract(Mover m) {
        PVector force = PVector.sub(location, m.location);
        float distance = force.mag();
        distance = constrain(distance, 5.0, 25.0);
        force.normalize();
        float strength = (G * mass * m.mass) / (distance * distance);
        force.mult(strength);

        return force;
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

class Attractor {
    float mass;
    PVector location;
    float G;

    Attractor() {
        location = new PVector(width/2, height/2);
        mass = 20;
        G = 0.4;
    }

    void display() {
        stroke(0);
        fill(175, 200);
        ellipse(location.x, location.y, mass*2, mass*2);
    }

    PVector attract(Mover m) {
        PVector force = PVector.sub(location, m.location);
        float distance = force.mag();
        distance = constrain(distance, 5.0, 25.0);
        force.normalize();
        float strength = (G * mass * m.mass) / (distance * distance);
        force.mult(strength);

        return force;
    }
    
}
