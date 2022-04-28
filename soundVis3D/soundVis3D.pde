import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;
FFT fft;
ArrayList<SoundRing> leftRings;
ArrayList<SoundRing> rightRings;
int maxSize = 50;
String label;

float rotY = 0;

void setup() {
  size(800,600, P3D);
  minim = new Minim(this);
  //song = minim.loadFile("jane.mp3", 1024);
  //song = minim.loadFile("felt.mp3", 1024);
  //song = minim.loadFile("lastofus.mp3", 1024);
  //song = minim.loadFile("16Hz-20kHz-Exp-1f-10sec.mp3", 1024);
  
  song = minim.loadFile("derezzed.mp3", 1024);
  //song = minim.loadFile("pillow.mp3", 1024);
  //song = minim.loadFile("taphaniang.mp3", 1024);
  AudioMetaData meta = song.getMetaData();
  label = meta.title() + " (" + meta.author() + ")"; 
  
  song.play();
  
  fft = new FFT(song.bufferSize(), song.sampleRate());
  leftRings = new ArrayList<SoundRing>();
  rightRings = new ArrayList<SoundRing>();
}

void draw() {
  background(0);
  
  pushMatrix();
  translate(10,height-10);
  text(label, 0,0,0);
  popMatrix();
  
  translate(width/2,0);
  rotateY(rotY);
  translate(-width/2,0);
  
  /* This uses the FFT to determine the frequencies present; then the 10 lowest frequency bands
     are averaged to determine the amount of red, the next 10 for green, and the next 10 for blue
     -- so very high pitched sounds aren't contributing to the color.  But for the songs I've tried
     this with, this seems to produce a nice variety of colors (or white for tonally full sections) */
  fft.forward(song.left);
  float freqRed = min(255, 25*fft.calcAvg(fft.indexToFreq(0), fft.indexToFreq(10)));
  float freqGreen = min(255, 25*fft.calcAvg(fft.indexToFreq(10), fft.indexToFreq(20)));
  float freqBlue = min(255, 25*fft.calcAvg(fft.indexToFreq(20), fft.indexToFreq(30)));
  
  SoundRing lsr = new SoundRing(song.left.toArray(), color(freqRed,freqGreen,freqBlue), 150);
  leftRings.add(lsr);
  if(leftRings.size() > maxSize) {
    leftRings.remove(0);
  }
  pushMatrix();
  translate(width/4.0, height/2.0);
  for(SoundRing ring : leftRings) {
    ring.display();
    ring.moveBack();
  }
  popMatrix();
  
  fft.forward(song.right);
  freqRed = min(255, 25*fft.calcAvg(fft.indexToFreq(0), fft.indexToFreq(10)));
  freqGreen = min(255, 25*fft.calcAvg(fft.indexToFreq(10), fft.indexToFreq(20)));
  freqBlue = min(255, 25*fft.calcAvg(fft.indexToFreq(20), fft.indexToFreq(30)));  
  
  SoundRing rsr = new SoundRing(song.right.toArray(), color(freqRed,freqGreen,freqBlue), 150);
  rightRings.add(rsr);
  if(rightRings.size() > maxSize) {
    rightRings.remove(0);
  }
  pushMatrix();
  translate(3.0*width/4.0, height/2.0);
  for(SoundRing ring : rightRings) {
    ring.display();
    ring.moveBack();
  }
  popMatrix();
  
}
/*
void stop() {
  song.close();
  minim.stop();
  super.stop();
}
*/
void mouseDragged() {
  rotY += float(mouseX - pmouseX)/width;
}
