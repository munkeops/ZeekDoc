
# PROBLEM: portscans or os scan are used to detect the status of available ports on the device. There are various port status that can inferred depending on the tool used. In the case of this example i have used nmap to perform portscans. 
#These can be done by attackers to maybe find and attack open links to your device.

#SOLUTION: using zeek , the solution described here is that we maintain a fixed size table of incoming ips to simulate the concept of a window frame. it encapsulates time as a dimension/feature for detection purposes. 
#Basicaly a predefined set of ips are stored in the table along with info such as which ports it has already encountered and how many in total. 
#Next every time a new connection is made it will check if it exists in these 10 ips and if so check if it is a port that this ip has already accessed before.
# If its been accessed before nothing happens cause it could be a large file strasnfer making mulitple connection. If its a new port the count of ports will be incremented and the port will be added to the visited ports. 
#If in the case the ip dosent exist in the table of 10 ips, we pick the one with the lowest no of ports visited and replace that. and so if there is something like a portscan then the no. ports value for that given ip increases rapidly with every new connection. 
#For this program i have put a cap at 100 visits, after which a message will be printed to notify the user.

#NOTE: 
# 1.storing info of all the ports visited and retrieving that information to check leads to heavy computation and delays, hence that idea has been kept on hold.
# 2. ports scan can be conducted from a subnet hence deceiving and getting past the checks of this program. to solve this problem we could couple this code with the other zeek code to check subnets as shown in the example insideOut.zeek. this was realised after i ran my code to test on the kitsune os scan data set.
# 3. this may not be the best algorithm, but for now it displays the use of zeek to perform computation tasks.




 #declaring a global user defined type record - very similar to structures and objects
 #declaring a record that can hold the incoming connections ip,ports and no. of ports encountered by the same ip
 type MyRec: record {
    ip: addr;
    ports: port; 
    noofports: count;
};

#global declaration of a table , very similar to arrays/lists of the user defined type MyRec
global slots : table[count] of MyRec;


#initialisation event
event zeek_init()
{
    # declaring a local temp rec value to initialise the table
    # note: tables are not accessed synchronously i.e they needs not appear in order of index
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
}


#event for every new connection
event new_connection(c: connection)
{
    # local initialisation of mimimum which stores the minimum number of ports visited by any of the ips in the table for comaprison ,minimumPos which will store the index in the table that holds the minimum number of ports visited
    local minimum:count=10000;
    local minimumPos:count=9;

    # flag is used to detect if there was a hit or a miss from the table of ips. If flag is 0 means a miss , so then we need to find the ip with the lowest ports visited number and replace it.
    local flag:count=0;

    #loops to visit each value in the table and update if a hit
    for (i in slots)
    {
         if(slots[i]$noofports>100)
            {
                
                print fmt("possible porstscan detected from ip :%s",slots[i]$ip);
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

                #i have modified the code here to store only the last ip and only update the counter and not change the ip stored for efficiency purposes now.
                
                ++slots[i]$noofports;#=slots[i]$noofports+1;
                # slots[i]$ports=c$id$orig_p;
            }
            flag=1;
            break;
        }
        else
        {
            if(slots[i]$noofports<minimum)
            {
                minimum=slots[i]$noofports;
                minimumPos=i;
            }
        }
        
    }

    if(flag==0)
    { 
        local rec=MyRec(
        $ip=c$id$orig_h,
        $ports= c$id$orig_p,
        $noofports=1);

        slots[minimumPos]=rec;
    }
}
