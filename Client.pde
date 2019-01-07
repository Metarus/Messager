void clientSend()
{
  if (connected&&name!=null)
  {
    c.write(r+"||"+g+"||"+b+"||"+name+": "+MsgInProgress);
  }
  if (name==null&&connected)
  {
    name=MsgInProgress;
  }
  if (connected==false)
  {
    c = new Client(this, MsgInProgress, 12345);
    connected=true;
  }
  MsgInProgress="";
}
void clientStart()
{
  if (connected==false)
  {
    text("Please enter an IP", width/2, height/2);
  }
  if (name==null&&connected)
  {
    text("Please enter a name", width/2, height/2);
  }
}
void clientReceive()
{
  if (connected)
  {
    if (c.available()!=0)
    {
      input = c.readString();
      for (int i=13; i>0; i--)
      {
        Messages[i]=Messages[i-1];
      }
      Messages[0]=input;
    }
  }
}
void clientExit()
{
  c.write("255||0||0||"+name+" has left the server");
  exit();
}