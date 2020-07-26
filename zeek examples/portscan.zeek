
 type MyRec: record {
    ip: addr;
    ports: port; 
    noofports: count;
};

global slots : table[count] of MyRec;
# global 


event new_connection(c: connection)
{
    # print fmt("newconnection : %s",c$id$orig_h);
    local minimum:count=10000;
    local minimumPos:count=9;
    local flag:count=0;
    for (i in slots)
    {
        # print(i);
         if(slots[i]$noofports>100)
            {
                
                print fmt("possible porstscan detected from ip :%s",slots[i]$ip);
                # print fmt("ports scanned :");
                # print(slots[i]$ports );
                local rec2=MyRec(
                    $ip=slots[i]$ip,
                    $ports= 22/tcp,
                    $noofports=0);
                slots[i]=rec2;


            }
        
        if( c$id$orig_h == slots[i]$ip)
        {
            if(c$id$orig_p != slots[i]$ports)
            {
                ++slots[i]$noofports;#=slots[i]$noofports+1;
                
                # print( slots[i]$ip);
                # print "before";
                # print(slots[i]$ports);
                # slots[i]$ports=c$id$orig_p;
                # print "after";
                # print(slots[i]$ports);
                # print slots[i]$noofports;
            }
            # minimum=0;
            flag=1;
            # print fmt("1 : %s",c$id$orig_h);
            break;
        }
        else
        {
            # print("2");
            # print fmt(" min val : %d",minimum);
            # print fmt(" slot val : %d",slots[i]$noofports);
           
            if(slots[i]$noofports<minimum)
            {
                # print "3";
                minimum=slots[i]$noofports;
                minimumPos=i;
                # print fmt("mini mum pos : %d",minimumPos);
            }
        }
        
    }
    if(flag==0)
    { 
        # print fmt("added new ip at pos : %d",minimumPos);
        # print "before";
        # print(slots);
        # print(" ");
        # local val2 =slots[minimumPos]$ports;
        # local noofports2= 
        # add val2[c$id$orig_p];

        
        local rec=MyRec(
        $ip=c$id$orig_h,
        $ports= c$id$orig_p,
        $noofports=1);

        # slots[minimumPos]$ip = c$id$orig_h;
        # slots[minimumPos]$noofports = 1;

        slots[minimumPos]=rec;
    }
    # print "after";
    # print(slots);
    # print " ";
}
event zeek_init()
{
    local rec=MyRec(
        $ip=192.168.30.10 ,
        $ports= 22/tcp,
        $noofports=0);
    
    slots[0]=rec;
    slots[1]=rec;
    slots[2]=rec;
    slots[3]=rec;
    slots[4]=rec;
    slots[5]=rec;
    slots[6]=rec;
    slots[7]=rec;
    slots[8]=rec;
    slots[9]=rec;


    # local ip:addr = 192.168.30.10;
    # for (i in slots)
    # {
    #     print i;
    # }
    # print ip in slots;
    # print slots;
    
}