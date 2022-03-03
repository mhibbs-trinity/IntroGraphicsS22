String[] koch = new String [4];
String[] hilbert = new String [5];
String[] dragon = new String [11];
String[] tree = new String [6];
String[] bush = new String [4];

/* Mode variable to choose which LSystem to use */
public enum Mode { KOCH, HILBERT, DRAGON, TREE, BUSH }
Mode mode = Mode.KOCH;

void setup() {
  size(600,600);
  koch[0] = "F";
  koch[1] = "F-F++F-F";
  koch[2] = "F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F";
  koch[3] = "F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F-F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F-F-F++F-F-F-F++F-F++F-F++F-F-F-F++F-F";
  hilbert[0] = "A";
  hilbert[1] = "-BF+AFA+FB-";
  hilbert[2] = "-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-";
  hilbert[3] = "-+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+F+-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-F-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-+F+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+-";
  hilbert[4] = "-+-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-F-+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+F+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+-F-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-+F+-+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+F+-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-F-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-+F+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+-F-+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+F+-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-F-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-+F+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+-+F+-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-F-+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+F+-BF+AFA+FB-F-+AF-BFB-FA+F+AF-BFB-FA+-F-BF+AFA+FB-+-F-+AF-BFB-FA+F+-BF+AFA+FB-F-BF+AFA+FB-+F+AF-BFB-FA+-+-";
  dragon[0] = "FX";
  dragon[1] = "FX+YF";
  dragon[2] = "FX+YF+FX-YF";
  dragon[3] = "FX+YF+FX-YF+FX+YF-FX-YF";
  dragon[4] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[5] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[6] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[7] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[8] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[9] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  dragon[10] = "FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF+FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF+FX+YF+FX-YF-FX+YF-FX-YF-FX+YF+FX-YF+FX+YF-FX-YF-FX+YF+FX-YF-FX+YF-FX-YF";
  tree[0] = "0";
  tree[1] = "1[-0]+0";
  tree[2] = "11[-1[-0]+0]+1[-0]+0";
  tree[3] = "1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0";
  tree[4] = "11111111[-1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0]+1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0";
  tree[5] = "1111111111111111[-11111111[-1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0]+1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0]+11111111[-1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0]+1111[-11[-1[-0]+0]+1[-0]+0]+11[-1[-0]+0]+1[-0]+0";
  bush[0] = "F";
  bush[1] = "FF-[-F+F+F]+[+F-F-F]";
  bush[2] = "FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]";
  bush[3] = "FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]-[-FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]+FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]+FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]]+[+FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]-FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]-FF-[-F+F+F]+[+F-F-F]FF-[-F+F+F]+[+F-F-F]-[-FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]+FF-[-F+F+F]+[+F-F-F]]+[+FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]-FF-[-F+F+F]+[+F-F-F]]]";
}

int level=0;
void draw() {
  background(0);
  stroke(255);
  strokeWeight(3);
  
  if(mode == Mode.KOCH) {
    translate(width/2, height);
    float len = height / pow(3,level);
    for(int i=0; i<koch[level].length(); i++) {
      char c = koch[level].charAt(i);
      if(c == 'F') { line(0,0, 0,-len); translate(0,-len); }
      if(c == '-') { rotate(-PI/3); }
      if(c == '+') { rotate(PI/3); }
    }
  }
  else if(mode == Mode.HILBERT) {
    noFill();
    translate(width-100, height-100);
    float len = (height-200) / (pow(2,level) - 1);
    for(int i=0; i<hilbert[level].length(); i++) {
      char c = hilbert[level].charAt(i);
      if(c == 'F') { 
        line(0,0, 0,-len);
        //bezier(0,0, -len/2,-len/2, len/2,-len/2, 0,-len);
        translate(0,-len);
      }
      if(c == '-') { rotate(-PI/2); }
      if(c == '+') { rotate(PI/2); }
    }
  }
  else if(mode == Mode.DRAGON) {
    translate(width/2, height/2);
    stroke(255,0,0);
    pushMatrix();
    doDragon();
    popMatrix();
    stroke(0,255,0);
    rotate(PI/2);
    pushMatrix();
    doDragon();
    popMatrix();
    stroke(0,0,255);
    rotate(PI/2);
    pushMatrix();
    doDragon();
    popMatrix();
    stroke(255,255,0);
    rotate(PI/2);
    pushMatrix();
    doDragon();
    popMatrix();
  }
  else if(mode == Mode.TREE) {
    translate(width/2, height);
    float theta = map(mouseX, 0,width, 0,PI/2);
    for(int i=0; i<tree[level].length(); i++) {
      char c = tree[level].charAt(i);
      if(c == '0' || c == '1') {
        line(0,0, 0,-15);
        translate(0,-15);
      }
      if(c == '-') rotate(-theta);
      if(c == '+') rotate(theta);
      if(c == '[') pushMatrix();
      if(c == ']') popMatrix();
    }
  }
  else if(mode == Mode.BUSH) {
    translate(width/2, height);
    float theta = map(mouseX, 0,width, 0,PI/2);
    for(int i=0; i<bush[level].length(); i++) {
      char c = bush[level].charAt(i);
      if(c == 'F') {
        line(0,0, 0,-15);
        translate(0,-15);
      }
      if(c == '-') rotate(-PI/6);
      if(c == '+') rotate(PI/6);
      /* Randomized version:
      if(c == '-') rotate(-random(PI/12, PI/4));
      if(c == '+') rotate(random(PI/12, PI/4));
      */
      if(c == '[') pushMatrix();
      if(c == ']') popMatrix();
    }
  } 
}

void doDragon() {
  for(int i=0; i<dragon[level].length(); i++) {
    char c = dragon[level].charAt(i);
    float len = 8;
    if(c == 'F') {
      line(0,0, 0,-8);
      //bezier(0,0, -len/2,-len/2, len/2,-len/2, 0,-len);
      translate(0,-8);
    }
    if(c == '-') { rotate(-PI/2); }
    if(c == '+') { rotate(PI/2); }
  }
}


void keyPressed() {
  if(keyCode == LEFT || keyCode == DOWN) {
    level--;
    if(level < 0) level = 0;
  }
  if(keyCode == RIGHT || keyCode == UP) {
    level++;
    if(mode == Mode.KOCH && level > 3) level = 3;
    if(mode == Mode.HILBERT && level > 4) level = 4;
    if(mode == Mode.DRAGON && level > 10) level = 10;
    if(mode == Mode.TREE && level > 5) level = 5;
    if(mode == Mode.BUSH && level > 3) level = 3;
  }
  if(key == 'k' || key == 'K') { mode = Mode.KOCH; level = 0; }
  if(key == 'h' || key == 'H') { mode = Mode.HILBERT; level = 0; }
  if(key == 'd' || key == 'D') { mode = Mode.DRAGON; level = 0; }
  if(key == 't' || key == 'T') { mode = Mode.TREE; level = 0; }
  if(key == 'b' || key == 'B') { mode = Mode.BUSH; level = 0; }
}
