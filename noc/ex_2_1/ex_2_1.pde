Mover[] movers = new Mover[100];
void setup() {
    size(640, 360);
    smooth();
    background(255);
    
    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover(random(0.1,5), 0, 0);
    }
}

void draw() {
    background(255);

    for (int i = 0; i < movers.length; i++) {

        PVector wind = new PVector(0.001, 0);
        float m = movers[i].mass;
        PVector gravity = new PVector(0, 0.1*m);

        movers[i].applyForce(wind);
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
            location.y = 0;
        }

    }

    void applyForce(PVector force) {
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }
}
