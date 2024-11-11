Oscillator[] oscillators = new Oscillator[10];

void setup() {
    size(640, 360);
    smooth();
    background(255);
    float xd = 0;
    float yd = 0;
    float wd = 0;
    float hd = 0;
    for (int i = 0; i < oscillators.length; i++) {
        oscillators[i] = new Oscillator(
                new PVector(),
                new PVector(-0.05+xd, -0.05+yd),
                new PVector(width/2, height/2)
        );
        xd += 0.01;
        yd += 0.01;
    }
}

void draw() {
    background(255);

    for (int i = 0; i < oscillators.length; i++) {
        oscillators[i].oscillate();
        oscillators[i].display();
    }
}


class Oscillator {
    PVector angle;
    PVector velocity;
    PVector amplitude;

    Oscillator() {
        angle = new PVector();
        velocity = new PVector(random(-0.05, 0.05), random(-0.05, 0.05));
        amplitude = new PVector(random(width/2), random(height/2));
    }
    
    Oscillator(PVector a, PVector v, PVector amp) {
        angle = a;
        velocity = v;
        amplitude = amp; 
    }

    void oscillate() {
        angle.add(velocity);
    }

    void display() {
        float x = sin(angle.x) * amplitude.x;
        float y = sin(angle.y) * amplitude.y;

        pushMatrix();
        translate(width/2, height/2);
        stroke(0);
        fill(175);
        line(0, 0, x, y);
        ellipse(x, y, 16, 16);
        popMatrix();
    }
}
