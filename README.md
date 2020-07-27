# ZeekDoc

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

### ZeekCut
zeek cut is a tool provided by zeek it is very helpful in dealing with quick manual analysis. It efficiently helps u slice out information from the logs you might want to view.

eg  :

cat conn.log | zeek-cut id.orig_h id.orig_p id.resp_h duration

cat conn.log |zeek-cut -d ts uid host uri < conn.log

### ZeekCTL
