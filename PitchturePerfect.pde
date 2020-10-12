import controlP5.*;
import processing.sound.*;

SoundFile first, second, third, fourth;

PImage img;
PImage myImage;

ControlP5 cp;
int x = 0;
int y = 0;
float distC, distD, distDm, distEm, distF, distG, distAm, distBm;  

//RGB Values for each chord, where 1,2,3 represents R,G,B respectively
float c1 = 255; float c2 = 185; float c3 = 2; 
float d1 = 229; float d2 = 0; float d3 = 3; 
float dm1 = 192; float dm2 = 3; float dm3 = 95;
float em1 = 2; float em2 = 40; float em3 = 137;
float f1 = 0; float f2 = 81; float f3 = 164; 
float g1 = 0; float g2 = 92; float g3 = 69; 
float am1 = 0; float am2 = 134; float am3 = 44;
float bm1 = 255; float bm2 = 239; float bm3 = 3; 

IntDict notesToCount = new IntDict();

float[] distances;
int minIndex; 
int maxIndex;
int countC, countD, countDm, countEm, countF, countG, countAm, countBm;
int total;
String [] order = new String[64];

void setup(){
  size(600, 800);
  background(75);
  distances = new float[8];
  
  notesToCount.set("max", 0);
  PFont pfont = createFont("Helvetica",30,true);
  ControlFont font = new ControlFont(pfont,20);

  //PlayButton
  cp = new ControlP5(this);
  cp.addButton("Play")
  .setPosition(width*0.05,height*0.025)
  .setSize(70,40)
  .setFont(font)
  .setColorBackground(color(255,255,255))
  .setColorCaptionLabel(color(0,0,0))
  .setColorForeground(color(255,0,99))
  .setColorActive(color(0,255,0))
  .setBroadcast(true);
  
  cp.addButton("Select_File")
  .setPosition(width*0.7,height*0.025)
  .setSize(150,40)
  .setFont(font)
  .setColorBackground(color(255,255,255))
  .setColorCaptionLabel(color(0,0,0))
  .setColorForeground(color(255,0,99))
  .setColorActive(color(0,255,0))
  .setBroadcast(true);
  
}

void draw(){
  //Choose image to be scan
  //Options: armstrong, monaLisa, screamer, theSonOfMan
  if ( img != null ){
    myImage = img;
    myImage.resize(width,height);
    image(myImage,0,0);
    myImage.loadPixels();

    for (x = 0; x < width; x++){
      for (y = 0; y < height; y++){
        //location of current pixel being scanned
        int currentPix = x + y * width;
        //current color of pixel being scanned
        color currentColor = myImage.pixels[currentPix];
        float colorR = red(currentColor);
        float colorG = green(currentColor);
        float colorB = blue(currentColor);
   
        //distance between current pixel and chords
        distC = dist(c1, c2, c3, colorR, colorG, colorB);
        distD = dist(d1, d2, d3, colorR, colorG, colorB);
        distDm = dist(dm1, dm2, dm3, colorR, colorG, colorB);
        distEm = dist(em1, em2, em3, colorR, colorG, colorB);
        distF = dist(f1, f2, f3, colorR, colorG, colorB);
        distG = dist(g1, g2, g3, colorR, colorG, colorB);
        distAm = dist(am1, am2, am3, colorR, colorG, colorB);
        distBm = dist(bm1, bm2, bm3, colorR, colorG, colorB);
    
        //add all distance to a Floatlist 
        distances[0] = distC;
        distances[1] = distD;
        distances[2] = distDm;
        distances[3] = distEm;
        distances[4] = distF;
        distances[5] = distG;
        distances[6] = distAm;
        distances[7] = distBm;
        float Min = distances[0];
        
        //determine which chord is the pixel color is closest too and add 1 to the count respectively
        for(int i = 0; i < distances.length; i++){
          if(distances[i] < Min) {
            Min = distances[i];
            minIndex = i;
          }
        }
          if(minIndex == 0){
                countC++;
          }else if(minIndex == 1){
                countD++;
          }else if(minIndex == 2){
                countDm++;
          }else if(minIndex == 3){
                countEm++;
          }else if(minIndex == 4){
                countF++;
          }else if(minIndex == 5){
                countG++;
          }else if(minIndex == 6){
                countAm++;
          }else if(minIndex == 7){
                countBm++;
          }
      }
    }
    //Assign total number of each count (for 
    notesToCount.set("C", countC);
    notesToCount.set("D", countD);
    notesToCount.set("Dm", countDm);
    notesToCount.set("Em", countEm);
    notesToCount.set("F", countF);
    notesToCount.set("G", countG);
    notesToCount.set("Am", countAm);
    notesToCount.set("Bm", countBm);
  }
  //Check number of pixel scan is correct
  //total = countC + countD + countDm + countEm + countF + countG + countAm + countBm;
  //println("total:" + total);
}

void Select_File(){
  selectInput("Select an image", "imageChosen"); 
}

void imageChosen( File f ){
    if( f.exists() )
  {
     img = loadImage( f.getAbsolutePath() ); 
  }
}


//find the mapping with the highest count
void addNotes(){
  notesToCount.sortValuesReverse();
  String [] tempKeys = notesToCount.keyArray();
  order[1] = tempKeys[0];
  order[2] = tempKeys[1];
  second = new SoundFile(this, order[1]+"_Chord.aiff");
  third = new SoundFile(this, order[2]+"_Chord.aiff");
}

//Arrange chords according to progression and then play music
void Play(){
  //assign 0 value to G/C from the list in case they are the largest count in the list to facilitate in finding the maximum later
  //Either G Major or C Major so start with G/C notes
  
  //First Note G
  if(notesToCount.get("G") > notesToCount.get("C")){
    notesToCount.set("G", 0);
    order[0] = "G";
    first = new SoundFile(this, order[0]+"_Chord.aiff");
    
      //if starts with G, must end with C or D
      if(notesToCount.get("C") > notesToCount.get("D")){
        notesToCount.set("C",3);
        order[3] = "C";
        fourth = new SoundFile(this, order[3]+"_Chord.aiff");

      }
      if(notesToCount.get("D") > notesToCount.get("C")){
        notesToCount.set("D",3);
        order[3] = "D";
        fourth = new SoundFile(this, order[3]+"_Chord.aiff");
      }
   
     //find the next maximum note to be the 2nd note and 3rd note in chord progression
     addNotes();
  }
  
  //First Note C
  if(notesToCount.get("G") < notesToCount.get("C") ){
    notesToCount.set("C",0);
    order[0] = "C";
    first = new SoundFile(this, order[0]+"_Chord.aiff");
    
      //if starts with C, must end with F or G
      if(notesToCount.get("F") > notesToCount.get("G")){
        notesToCount.set("F",0);
        order[3] = "F";
        fourth = new SoundFile(this, order[3]+"_Chord.aiff");
      }
      if(notesToCount.get("G") > notesToCount.get("F")){
        notesToCount.set("G",0);
        order[3] = "G";
        fourth = new SoundFile(this, order[3]+"_Chord.aiff");
      }
    
    //find the next maximum note to be the 2nd note and 3rd note in chord progression
    addNotes();

  }
    for(int i = 0; i < 10; i++){
      first = new SoundFile(this, order[0]+"_Chord.aiff");
      second = new SoundFile(this, order[1]+"_Chord.aiff");
      third = new SoundFile(this, order[2]+"_Chord.aiff");
      fourth = new SoundFile(this, order[3]+"_Chord.aiff");
      first.play(1);
      delay(800);
      second.play(1);
      delay(800);
      third.play(1);
      delay(800);
      fourth.play(1);
      delay(800);
      
      //used to check whether correct notes where playing
      //println(order[i]);
    }
}
