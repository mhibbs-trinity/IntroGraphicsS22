class DragCircle {
  float x,y,d;
  float offX,offY;
  boolean dragging = false;
  boolean hovering = false;
  color regularColor = color(128);
  color highlightColor = color(200);
  boolean firstPress = false;
  boolean isPressed = false;
  
  DragCircle(float _x, float _y, float _d) {
    x = _x; y = _y; d = _d;
  }
  DragCircle(float _x, float _y, float _d, color regCol, color highCol) {
    x = _x; y = _y; d = _d;
    regularColor = regCol;
    highlightColor = highCol;
  }
  
  void display() {
    //If the mouse is not pressed, stop dragging
    if(!mousePressed) {
      dragging = false;
      firstPress = false;
      isPressed = false;
    }
    //If this is the first time the mouse has been pressed, mark
    //the firstPress event
    else {
      if(isPressed) {
        firstPress = false;
      } else {
        firstPress = true;
        isPressed = true;
      }
    }
    
    //If the item was already being dragged
    if(dragging) {
      x = mouseX + offX;
      y = mouseY + offY;
    } else { //Otherwise, item not already being dragged...
      //So, if the mouse is now over the item...
      //We used the dist() function in class, this way is faster because
      //it doesn't involve taking a square root, which is a pretty slow operation
      float diffX = x-mouseX;
      float diffY = y-mouseY;
      if(diffX*diffX+diffY*diffY < d*d/4) {
        //If this is the first press of the mouse, then start dragging
        if(firstPress) {
          dragging = true;
          offX = x-mouseX;
          offY = y-mouseY;
        } else { //otherwise, this is just a hover
          hovering = true;
        }
      }
      else { //If the mouse is not over the item, then don't hover
        hovering = false;
      }
    }
    //Now, actually draw the circle
    noStroke();
    if(dragging || hovering) fill(highlightColor);
    else fill(regularColor);
    ellipse(x,y,d,d);
  }
}
