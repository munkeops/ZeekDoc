

event ssh_auth_attempted(c:connection,authenticated:bool)
{
    print fmt("ssh attempted. IP : %s",c$id$orig_h);
    print fmt("status: %d",authenticated);
    print " ";
    
}