
# simple code to detect whether each connection is coming from within a given specified local subnet or not also to detect flagged ips.


# define the subnets you wish to check
global local_subnets: set[subnet] = { 192.168.29.0/20,[2405:201:814:4733:31e0:4f14:5462:9de0]/64 }; 
#define the list of flagged ips
global blocked_ips: set[addr]={192.168.29.10};
global my_count = 0;
global inside_networks: set[addr]; 
global outside_networks: set[addr]; 
# global blocked_ips_detected: set[addr]; 

global sshval: port = 22/tcp;


event new_connection(c: connection)
{
    ++my_count;
    if ( my_count >=0 )
	{
        print fmt("The connection %s from %s on port %s to %s on port %s started at %s.", c$uid, c$id$orig_h, c$id$orig_p, c$id$resp_h, c$id$resp_p, strftime("%D %H:%M", c$start_time));
    }
    if ( c$id$orig_h in local_subnets)
    {
        add inside_networks[c$id$orig_h];
    }
    else
    {
        add outside_networks[c$id$orig_h];
    }
	    
    if ( c$id$resp_h in local_subnets)
    {
        add inside_networks[c$id$resp_h];
    }
    else
        add outside_networks[c$id$resp_h];
    


    if ( c$id$orig_h in blocked_ips)
    {
        print "blocked ip detected";
        print fmt("The connection %s from %s on port %s to %s on port %s started at %s.", c$uid, c$id$orig_h, c$id$orig_p, c$id$resp_h, c$id$resp_p, strftime("%D %H:%M", c$start_time));

        # add blocked_ips_detected[c$id$orig_h]
    }

    if ( c$id$resp_p == sshval)
    {
        print "ssh detected";
        print fmt("The connection %s from %s on port %s to %s on port %s started at %s.", c$uid, c$id$orig_h, c$id$orig_p, c$id$resp_h, c$id$resp_p, strftime("%D %H:%M", c$start_time));

    }

}

event connection_state_remove(c: connection)
    {
    # if ( my_count <= 10 )
    	# {
    	print fmt("Connection %s took %s seconds", c$uid, c$duration);
    	# }
    }

event zeek_done()
    {
        #prints a summary of the connections encountered while this program was running

        print fmt("Saw %d new connections", my_count);
        print "These IPs are considered local";
        for (a in inside_networks)
            {
            print a;
            }
        print "These IPs are considered external";
        for (a in outside_networks)
            {
            print a;
            }
    }
