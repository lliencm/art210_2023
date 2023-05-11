final static float MOVE_SPEED = 5;
final static float SPRITE_SCALE = 50.0/125;
final static float SPRITE_SIZE = 50;
final static float GRAVITY = 0.6;
final static float JUMP_SPEED = 14;

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

Sprite p;
PImage choco, marsh, crack, flow, rock, ground, star;
ArrayList<Sprite> platforms;
ArrayList<Sprite> stars;

int numStars;
float view_x = 0;
float view_y = 0;

void setup()
{
  size(800,600);
  imageMode(CENTER);
  p = new Sprite("Cherry.png", 0.7, 100, 300);
  p.change_x = 0;
  p.change_y = 0;
  platforms = new ArrayList<Sprite>();
  stars = new ArrayList<Sprite>();
  numStars = 0;
  
  star = loadImage("Star.png");
  choco = loadImage("Chocolate.png");
  marsh = loadImage("Marshmallow.png");
  crack = loadImage("Cracker.png");
  flow = loadImage("Flower.png");
  rock = loadImage("Rock.png");
  ground = loadImage("Ground.png");
  createPlatforms("map.csv");

}

void draw()
{
  background(100,200,200);
  scroll();
  
  p.display();
  resolvePlatformCollisions(p, platforms);
  
  collectStars();

  for(Sprite s: platforms)
    s.display();
    
  for(Sprite c: stars)
  {
    c.display();
    ((AnimatedSprite)c).updateAnimation();
  }
  fill(255,0,0);
  textSize(32);
  text("Star:" + numStars, view_x + 50, view_y + 50); 
}

void collectStars()
{
  ArrayList<Sprite> star_list = checkCollisionList(p, stars);
  if(star_list.size() > 0)
  {
    for(Sprite star: star_list)
    {
      numStars++;
      stars.remove(star);
    }
  }
  
}

void scroll()
{
 float right_boundary = view_x + width - RIGHT_MARGIN;
 if(p.getRight() > right_boundary)
 {
   view_x += p.getRight() - right_boundary;
 }
 
 float left_boundary = view_x + LEFT_MARGIN;
 if(p.getRight() < left_boundary)
 {
   view_x -= left_boundary - p.getLeft();
 }
 
 float bottom_boundary = view_y + height - VERTICAL_MARGIN;
 if(p.getBottom() > bottom_boundary)
 {
   view_y += p.getBottom() - bottom_boundary;
 }
 
 float top_boundary = view_y + VERTICAL_MARGIN;
 if(p.getTop() < top_boundary)
 {
   view_y -= top_boundary - p.getTop();
 }
 
 translate(-view_x, -view_y);
}

boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls)
{
  s.center_y += 5;
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  s.center_y -= 5;
  if(col_list.size() > 0)
  {
    return true;
  }
  else
  return false;
}

void resolvePlatformCollisions(Sprite s, ArrayList<Sprite> walls)
{
  s.change_y += GRAVITY;
  
  s.center_y += s.change_y;
  ArrayList<Sprite> col_list = checkCollisionList(s, walls);
  if(col_list.size() > 0)
  {
    Sprite collided = col_list.get(0);
    if(s.change_y > 0)
    {
      s.setBottom(collided.getTop());
    }
        else if(s.change_y < 0)
        {
          s.setTop(collided.getBottom());
        }
        s.change_y = 0;
      }
 
 s.center_x += s.change_x;
  col_list = checkCollisionList(s, walls);
  if(col_list.size() > 0)
  {
    Sprite collided = col_list.get(0);
    if(s.change_x > 0)
    {
      s.setRight(collided.getLeft());
    }
        else if(s.change_x < 0)
        {
          s.setLeft(collided.getRight());
        }
      }
}
boolean checkCollision(Sprite s1, Sprite s2)
{
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap)
  {
    return false;
  }
  else
  {
    return true;
  }
}

ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list)
{
  ArrayList<Sprite> collision_list = new ArrayList<Sprite>();
  for(Sprite p: list)
  {
    if(checkCollision(s, p))
      collision_list.add(p);
  }
  return collision_list;
}

void createPlatforms(String filename)
{
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++)
  {
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++)
    {
      if(values[col].equals("1"))
      {
        Sprite s = new Sprite(choco, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("2"))
      {
        Sprite s = new Sprite(marsh, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("3"))
      {
        Sprite s = new Sprite(crack, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("4"))
      {
        Sprite s = new Sprite(flow, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("5"))
      {
        Sprite s = new Sprite(rock, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
      else if(values[col].equals("6"))
      {
        Sprite s = new Sprite(ground, SPRITE_SCALE);
        s.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      }
       else if(values[col].equals("7"))
      {
        Star c = new Star(star, SPRITE_SCALE);
        c.center_x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.center_y = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        stars.add(c);
      }
    }
  }
}
        
       

void keyPressed()
{
  if(keyCode == RIGHT)
  {
    p.change_x = MOVE_SPEED;
  }
  else if(keyCode == LEFT)
  {
    p.change_x = -MOVE_SPEED;
  }
  else if(keyCode == UP && isOnPlatforms(p, platforms))
  {
    p.change_y = -JUMP_SPEED;
  }
}

void keyReleased()
{
  if(keyCode == RIGHT)
  {
    p.change_x = 0;
  }
  else if(keyCode == LEFT)
  {
    p.change_x = 0;
  }
}
