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
float t = 0;

void setup() { 
    size(640, 360);
    noiseDetail(7,0.6);
    background(255);
}

float ta = 0.0;
void draw() {
    loadPixels();
    float a = noise(ta);
    float xoff = 0.0;
    for (int x=0; x < width; x++) {
        float yoff = 0.0;
        for (int y=0; y < height; y++) {
            float bright = map(noise(xoff + a, yoff + a), 0, 1, 0, 255);
            pixels[x+y*width] = color(bright);
            yoff += 0.01;
        }
        xoff += 0.01;
    }
    updatePixels();
    ta += 0.01;
}
