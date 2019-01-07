void serverSend()
{
  if (name!=null)
  {
    s.write(r+"||"+g+"||"+b+"||"+name+": "+MsgInProgress);
    for (int i=13; i>0; i--)
    {
      Messages[i]=Messages[i-1];
    }
    Messages[0]=r+"||"+g+"||"+b+"||"+name+": "+MsgInProgress;
  }
  if (name==null)
  {
    name=MsgInProgress;
  }
  MsgInProgress="";
}
void serverStart()
{
  if (start==false)
  {
    s = new Server(this, 12345);
    start=true;
  }
  if (name==null)
  {
    text("Please enter a name", width/2, height/2);
  }
}
void serverReceive()
{
  c = s.available();
  if (c!=null)
  {
    input = c.readString();
    for (int i=13; i>0; i--)
    {
      Messages[i]=Messages[i-1];
    }
    Messages[0]=input;
    s.write(input);
  }
}
void serverExit()
{
  s.write("255||0||0||"+name+" has left the server; The server has been closed");
  exit();
}