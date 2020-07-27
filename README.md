# ZeekDoc

## Try Zeek Online 

Zeek has an interactive web editor to try and learn.
<br> link : Try.zeek.org

## Zeek Installation

There are multiple ways to install/use zeek for analysis.


### Linux/Mac:
The ways i encountered during my experience were either to install the binaries provided on the zeek documentation or make it from source from the github repo.
After following the steps as shown in the below link, either temporarily export the zeek binaries to path every time or add the export command to the bash/profile file. One way to is to add manually copy of the bin folder in zeek to the /usr/bin. This will add all the zeek binaries as system binaries.
<br> download link : https://zeek.org/get-zeek/
<br> src files : https://docs.zeek.org/en/current/install/install.html
<br> Note: while installing, do not forget to use sudo when required as many of these commands require to create directories and hence require enhanced permission.
### Windows :
Theres no official build for windows as such, since its an open source software. One way to install it would be use the WSL/WSL2. Installation on WSL/WSL2 will follow the same procedure as the Linux way. 
<br> Note: WSL/WSL2 commands like make/cmake run much slower and the installation might take longer than usual.
### Security Onion VM/OS
Another third way that comes as a package deal with many other software that help with zeek analysis is to install the SecurityOnion Linux Distro. It comes pre installed and configured with zeek and the elastic kibana stack that can be used to perform some data visualisation. It is easily installable on vm with configuration to listen on the host. <br>Note: to run it smoothly, it is a very resource draining process hence minimum requirement would be to use it with atleast 8gb ram allocated to it. 4GB ram will work too for simple programs and learner, but 8gb is optimal for deployment.


## Zeek Architecture

Zeek is single threaded, hence very often we set up a cluster mechanism where incoming traffic is split into multiple nodes.
![Zeek Architecture](/Documentation/zeekarchitecture.png)


## Zeek command line tools

The zeek command must be used with various options for various purposes. Some usual commands used are as below: 
```
zeek -i enp0s3
zeek -i enp0s8 
zeek -i any
```
The i helps us choose an interface. Interfaces may include the wifi, ethernet, bluetooth etc. Also VMs may have an additional source of having to listen to the host<br>
Note : !most common new system of labeling for internet interfaces have changed from eth0 to enp0s for linux system. To understand more view the below link -<br>
https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0

<br><br> zeek can also be used with pre recorded packet captures. Various tools to perform packet capture are : wireshark and tcpdump.

### ZeekCut
zeek cut is a tool provided by zeek it is very helpful in dealing with quick manual analysis. It efficiently helps u slice out information from the logs you might want to view.

eg  :

cat conn.log | zeek-cut id.orig_h id.orig_p id.resp_h duration

cat conn.log |zeek-cut -d ts uid host uri < conn.log

### ZeekCTL
