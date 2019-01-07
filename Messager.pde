import processing.net.*;

char KeyA;
String input, name;
String MsgInProgress="";
String[] Messages = new String[14];
int r, g, b;
boolean connected;
boolean client, server, start;
Client c;
Server s;
void setup()
{
  size(800, 500);
  textAlign(CENTER);
  textSize(25);
  for (int i=0; i<14; i++)
  {
    Messages[i]="0||0||0|| ";
  }
  background(255);
}
void draw()
{
  background(255);
  fill(0);
  if (client==false&&server==false)
  {
    text("Enter S for server and C for client", width/2, height/2);
    if (MsgInProgress.equals("c"))
    {
      client=true;
    }
    if (MsgInProgress.equals("s"))
    {
      server=true;
    }
    MsgInProgress="";
  }
  if (client)
  {
    clientStart();
    clientReceive();
  }
  if (server)
  {
    serverStart();
    serverReceive();
  }
  text(MsgInProgress, 400, 450);
  int x=0;
  if (name!=null)
  {
    for (int i=400; i>0; i-=30)
    {
      String colorSplit[] = split(Messages[x], "||");
      String data[] = split(colorSplit[3], ':');
      int red = Integer.parseInt(colorSplit[0]);
      int blue = Integer.parseInt(colorSplit[1]);
      int green = Integer.parseInt(colorSplit[2]);
      fill(red, blue, green);
      if (data[0].equals(name))
      {
        textAlign(RIGHT);
        text(colorSplit[3], width-50, i);
      } else
      {
        textAlign(LEFT);
        text(colorSplit[3], 50, i);
      }
      textAlign(CENTER);
      x++;
    }
  }
}
void keyPressed()
{
  if (key==ENTER)
  {
    if (MsgInProgress.substring(0, 1).equals("/"))
    {
      String commandSplit[] = split(MsgInProgress, ' ');
      if (commandSplit[0].equals("/exit"))
      {
        if (client)
        {
          clientExit();
        }
        if (server)
        {
          serverExit();
        }
      }
      if (commandSplit.length>1)
      {
        if (commandSplit[0].equals("/red"))
        {
          r=Integer.parseInt(commandSplit[1]);
        }
        if (commandSplit[0].equals("/blue"))
        {
          b=Integer.parseInt(commandSplit[1]);
        }
        if (commandSplit[0].equals("/green"))
        {
          g=Integer.parseInt(commandSplit[1]);
        }
        if (commandSplit[0].equals("/rgb"))
        {
          if (commandSplit.length==4)
          {
            r=Integer.parseInt(commandSplit[1]);
            g=Integer.parseInt(commandSplit[2]);
            b=Integer.parseInt(commandSplit[3]);
          }
          if (commandSplit.length==2)
          {
            r=Integer.parseInt(commandSplit[1]);
            g=Integer.parseInt(commandSplit[1]);
            b=Integer.parseInt(commandSplit[1]);
          }
        }
      }
      MsgInProgress="";
    } else
    {
      if (client)
      {
        clientSend();
      }
      if (server)
      {
        serverSend();
      }
    }
  }
  if (key==BACKSPACE)
  {
    if (0<MsgInProgress.length())
    {
      MsgInProgress = MsgInProgress.substring(0, MsgInProgress.length()-1);
    }
  } else
    if (key!=CODED&&key!=ENTER)
    {
      KeyA=key;
      MsgInProgress=(MsgInProgress+KeyA);
    }
}