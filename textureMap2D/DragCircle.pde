class DragCircle {
  float x,y,d;
  float offX,offY;
  boolean dragging = false;
  boolean hovering = false;
  color regularColor = color(128);
  color highlightColor = color(200);
  
  DragCircle(float _x, float _y, float _d) {
    x = _x;
    y = _y;
    d = _d;
  }
  void display() {
    //If the mouse is not pressed, stop dragging
    if(!mousePressed) {
      dragging = false;
    }
    //If the item was already being dragged
    if(dragging) {
      x = mouseX + offX;
      y = mouseY + offY;
    } else { //Otherwise, item not already being dragged...
      //So, if the mouse is now over the item...
      float diffX = x-mouseX;
      float diffY = y-mouseY;
      if(diffX*diffX+diffY*diffY < d*d/4) {
        //If mouse down, then start dragging
        if(mousePressed) {
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
