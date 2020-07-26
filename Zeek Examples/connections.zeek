global mycount:count=0;
event connection_state_remove(c: connection)
    {
        if (mycount>=0)
        {
            print " ";
            print " ";
    	    print "lmao",c$id$orig_h, c$id$orig_p, c$id$resp_h, c$id$resp_p, c$orig$num_pkts, c$resp$num_pkts;
        }
        
        else
            print "lmao";
        mycount=mycount+1;
    }
# event new_connection( c:connection)
# {
    
# }