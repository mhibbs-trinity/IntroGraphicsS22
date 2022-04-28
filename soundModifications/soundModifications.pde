import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioSample forward;
AudioSample backward;

void setup() {
  size(800,600, P3D);
  minim = new Minim(this);
  
  //String filename = "derezzed.mp3";
  //String filename = "Spongebob.mp3";
  String filename = "StevenUniverse.mp3";
  //String filename = "GameOfThrones.mp3";
  //String filename = "GoodFight.mp3";
  //String filename = "DoctorWho.mp3";
  //String filename = "Simpsons.mp3";
  //String filename = "Dora.mp3";
  //String filename = "Batman.mp3";
  //String filename = "Survivor.mp3";
  //String filename = "WalkingDead.mp3";
  //String filename = "TrueBlood.mp3";
  //String filename = "SouthPark.mp3";
  //String filename = "BigBang.mp3";
  //String filename = "BreakingBad.mp3";
  //String filename = "TwilightZone.mp3";
  //String filename = "Jeopardy.mp3";
  //String filename = "GoldenGirls.mp3";
  //String filename = "ILoveLucy.mp3";
  
  //String filename = "jane.mp3";
  //String filename = "felt.mp3";
  //String filename = "lastofus.mp3";
  //String filename = "pillow.mp3";
  
  forward = minim.loadSample(filename);
  //backward= forward;
  backward= reverse(forward);
  //backward= everyOtherSample(forward);
  //backward= doubleSamples(forward);
  //backward= doubleSamples(reverse(forward));
  //backward= everyOtherSample(reverse(forward));
  //backward= resampleAtRate(forward, 0.3f);
  //backward= resampleRateInterpolation(forward, 0.8f, 1.4f);
  backward.trigger();
}

AudioSample reverse(AudioSample samp) {
  float[] inSamples = samp.getChannel(AudioSample.LEFT);
  float[] outSamples= new float[inSamples.length];
  for(int i=0; i<inSamples.length; i++) {
    outSamples[inSamples.length-i-1] = inSamples[i];
  }
  AudioSample result = minim.createSample(outSamples, samp.getFormat());
  return result;
}

AudioSample everyOtherSample(AudioSample samp) {
  float[] in = samp.getChannel(AudioSample.LEFT);
  float[] out= new float[in.length / 2];
  for(int i=0; i<in.length; i++) {
    if(i/2 < out.length) {
      out[i/2] = in[i];
    }
  }
  return minim.createSample(out, samp.getFormat());
}

AudioSample doubleSamples(AudioSample samp) {
  float[] in = samp.getChannel(AudioSample.LEFT);
  float[] out= new float[in.length * 2];
  for(int i=0; i<in.length-1; i++) {
    if(i/2 < out.length) {
      out[i*2] = in[i];
      out[i*2+1] = (in[i] + in[i+1]) / 2;
    }
  }
  return minim.createSample(out, samp.getFormat());
}

AudioSample resampleAtRate(AudioSample samp, float rate) {
  float[] in = samp.getChannel(AudioSample.LEFT);
  ArrayList<Float> out = new ArrayList<Float>();
  float curr = 0;
  while(curr < in.length-1) {
    int low = floor(curr);
    int hi  = ceil(curr);
    if(low == hi) {
      out.add(in[low]);
    } else {
      float frac = map(curr, low,hi, 1,0);
      float interp = in[low]*frac + in[hi]*(1-frac);
      out.add(interp);
    }
    curr += rate;
  }
  float[] outSamples = new float [out.size()];
  for(int i=0; i<out.size(); i++) {
    outSamples[i] = out.get(i);
  }
  return minim.createSample(outSamples, samp.getFormat());
}

AudioSample resampleRateInterpolation(AudioSample samp, float lorate, float hirate) {
  float[] in = samp.getChannel(AudioSample.LEFT);
  ArrayList<Float> out = new ArrayList<Float>();
  float curr = 0;
  while(curr < in.length-1) {
    int low = floor(curr);
    int hi  = ceil(curr);
    if(low == hi) {
      out.add(in[low]);
    } else {
      float frac = map(curr, low,hi, 1,0);
      float interp = in[low]*frac + in[hi]*(1-frac);
      out.add(interp);
    }
    curr += lerp(lorate, hirate, map(curr, 0,in.length, 0,1));
  }
  float[] outSamples = new float [out.size()];
  for(int i=0; i<out.size(); i++) {
    outSamples[i] = out.get(i);
  }
  return minim.createSample(outSamples, samp.getFormat());
}


void draw() {
  background(0);
  
  
}
