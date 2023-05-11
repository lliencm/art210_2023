class Star extends AnimatedSprite
{
  Star(PImage img, float scale)
  {
    super(img, scale);
    standNeutral = new PImage[2];
    standNeutral[0] = loadImage("Star.png");
    standNeutral[1] = loadImage("Star 1.png");
    currentImages = standNeutral;
  }
}
