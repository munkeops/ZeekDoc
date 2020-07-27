# the purpose of this program is to display various cases of ssh detections and events that can be used. 
# many such custom events available by zeek for various network detection purposes
event ssh_auth_attempted(c:connection,authenticated:bool)
{
    print " ";
    print " ";
    print fmt("ssh attempted. IP : %s",c$id$orig_h);
    print fmt("status: %d",authenticated);
    print " ";
    
}

#During the SSH key exchange, the server supplies its public host key. This event is generated when the appropriate key exchange message is seen for SSH2.
event ssh2_server_host_key(c: connection, key: string)
{
    print " ";
    print " ";
    print "key: ",key;
}

#for legacy devices
#  During the SSH key exchange, the server supplies its public host key. This event is generated when the appropriate key exchange message is seen for SSH1.
# event ssh1_server_host_key(c: connection, key: string)
# {
#     print "key: ",key;
# }

event ssh_capabilities(c: connection, cookie: string, capabilities: SSH::Capabilities)
{
    print " ";
    print " ";
    print "capabilities",cookie, capabilities;
}