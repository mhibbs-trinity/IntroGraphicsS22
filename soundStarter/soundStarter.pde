import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioPlayer song;

FFT fft;
BeatDetect beat;
float eRadius;

void setup() {
  size(1024,400);
  minim = new Minim(this);
  song = minim.loadFile("derezzed.mp3", 1024);
  //song = minim.loadFile("fall.mp3", 1024);
  //song = minim.loadFile("jane.mp3", 1024);
  //song = minim.loadFile("felt.mp3", 1024);
  //song = minim.loadFile("lastofus.mp3", 1024);
  //song = minim.loadFile("pillow.mp3", 1024);
  //song = minim.loadFile("taphaniang.mp3", 1024);
  //song = minim.loadFile("16Hz-20kHz-Exp-1f-5sec.mp3", 1024);
  //song = minim.loadFile("16Hz-1600Hz-Exp-1f-10sec.mp3", 1024);
  //song = minim.loadFile("16Hz-20kHz-Lin-1f-10sec.mp3", 1024);
  //song = minim.loadFile("440Hz-5sec.mp3", 1024);
  
  song.play();
}

void draw() {
  background(0);
  
  stroke(255);
  strokeWeight(3);
  float bufSz = song.bufferSize();
  for(int i=0; i<bufSz-1; i++) {
    line(i, map(song.mix.get(i), -1,1, height,0),
       i+1, map(song.mix.get(i+1), -1,1, height,0));
  }
  
}

void stop() {
  song.close();
  minim.stop();
  super.stop();
}
