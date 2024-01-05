// Pre-Processing 2.0 Java imports
import java.applet.*;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.event.MouseEvent;
import java.awt.event.KeyEvent;
import java.awt.event.FocusEvent;
import java.awt.Image;
import java.io.*;
import java.net.*;
import java.text.*;
import java.util.*;
import java.util.zip.*;
import java.util.regex.*;
// End java imports

Walker w;
Random generator;

void setup() {
    size(640, 360);
    w = new Walker();
    background(255);
    generator = new Random();
}

void draw() {
    w.step();
    w.display();
}

class Walker {
    int x, y;
    float tx, ty;

    Walker() {
        x = width/2;
        y = height/2;
        tx = 0;
        tx = 10000; 
    }
    
    void display() {
        stroke(0);
        fill(150);
        /* point(x, y); */
        ellipse(x, y, 16, 16);
    }

    void step() {
        int xstep, ystep;
        xstep = round(map(noise(tx), 0, 1, -5, 5));
        ystep = round(map(noise(ty), 0, 1, -5, 5));
        tx += 0.01;
        ty += 0.01;
        x += xstep;
        y += ystep;
    }
    

    void stepMontecarlo() {
        // Step size probability is linear with ... step size
        float xstep, ystep;
        xstep = 10*(3 * montecarloExp() - 2);
        ystep = 10*(3 * montecarloExp() - 2);

        x += round(xstep);
        y += round(ystep);
    }

    void stepLevy() {
        // Levy flight, randomly jumps to reduce oversampling
        float r = random(1);
        float xstep, ystep;
        if (r < 0.01) {
            // Jump!
            xstep = random(-50, 50);
            ystep = random(-50, 50);
        } else {
            xstep = random(-1, 1);
            ystep = random(-1, 1);
        }
        x += round(xstep);
        y += round(ystep);
    }

    void stepMouse() {
        float r = random(1);
        float stepFactor = (float) generator.nextGaussian();
        float sd = 0.2;
        float mean = 1.0 ;
        float stepSize = sd * stepFactor + mean;

        if (r < 0.5) {
            if( mouseX > x+50) {
                x += stepSize;
            } else if (mouseX < x-50) {
                x -= stepSize;
            }
            if ( mouseY > y+50) {
                y += stepSize;
            } else if (mouseY < y-50) {
                y -= stepSize;
            }
        } else {
            int stepx = int(random(3)) - 1;
            int stepy = int(random(3)) - 1;

            x += stepx * stepSize;
            y += stepy * stepSize;
        }
    }

    void stepRight() {
        // Tend toward the right

        float r = random(1);

        if (r < 0.4) { // %40 chance 
            x++;
        } else if (r < 0.6) {
            x--;
        } else if (r < 0.8) {
            y++;
        } else {
            y--;
        }
    }
    void stepGaussian() {
        // Guassian Random Walk
        float sd = 2;
        float mean = 0.0 ;
        float stepFactor = (float) generator.nextGaussian();
        float stepx = round(sd * stepFactor + mean);

        stepFactor = (float) generator.nextGaussian();
        float stepy = round(sd * stepFactor + mean);

        x += stepx;
        y += stepy;
    }
}

float montecarlo() {
    while (true) {
        float r1 = random(1);
        float probability = r1;
        float r2 = random(1);
        if (r2 < probability) {
            return r1;
        }
    }
}

float montecarloExp() {
    while (true) {
        float r1 = random(1);
        float probability = r1 * r1;
        float r2 = random(1);
        if (r2 < probability) {
            return r1;
        }
    }
}
        
