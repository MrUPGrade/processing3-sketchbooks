boolean shouldDraw = true;
int canceled = 0;


void setup() {
  frameRate(30);
  background(0);
  //fullScreen(P3D);
  size(600, 600, P3D);
  
}

void draw() {
  if (!shouldDraw) {
    return;
  }

  colorMode(HSB);

  float x = -1;
  float y = -1;
  boolean drawPixel = false;
  for (int test = 0; test < 1000; test++) {
    x = random(0, width);
    y= random(0, height);

    loadPixels();
    int loc = int(x) + int(y) * width;
    int p = pixels[loc];
    float b = brightness(p);
    if (b > 0) {
      canceled ++;
    } else {
      drawPixel = true;
      break;
    }
  }

  if (drawPixel) { 
    stroke(255, 70);
    strokeWeight(80);
    point(x, y);
  }

  checkIfFinished();
}

void checkIfFinished() {
  boolean foundDark = false;
  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      int loc = x + y * width;
      int p = pixels[loc];
      float b = brightness(p);
      if (b == 0) {
        foundDark = true;
      }
    }
  }

  if (!foundDark) { 
    print("HAHA");
    colorMode(HSB);  
    fill(77, 255, 255, 200);  
    textSize(30);
    String s = String.format("All pixels lighten\n%d tries failed", canceled);
    text(s, 20, height/2);
    shouldDraw = false;
  }
}
