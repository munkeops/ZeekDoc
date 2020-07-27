# the purpose of this code is to display an example as to how connection look like. they are huge nested records of records containing information about the whole connection. this program simply prints the connection to demonstrate how it looks and wat kind of information can be retrived

# global mycount:count=0;

event new_connection( c:connection)
{
    print "new connection", c;
}