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

Random generator;

void setup() {
    size(640, 360);
    generator = new Random();
}

void draw() {
    float numx = (float) generator.nextGaussian();
    float sdx = 60;
    float meanx = 320;
    float x = sdx * numx + meanx;

    float numy = (float) generator.nextGaussian();
    float sdy = 30;
    float meany = 180;
    float y = sdy * numy + meany;

    float numr = (float) generator.nextGaussian();
    float sdr = 24;
    float meanr = 127;
    float r = sdr * numr + meanr;
    float numg = (float) generator.nextGaussian();
    float sdg = 25;
    float meang = 127;
    float g = sdg * numg + meang;
    float numb = (float) generator.nextGaussian();
    float sdb = 25;
    float meanb = 127;
    float b = sdb * numb + meanb;

    color col = color(r, g, b, 200);
    
    noStroke();
    fill(col);
    ellipse(x, y, 16, 16);
}
