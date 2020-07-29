# ZeekDoc
 
 <p align="center">
  <img src=/Documentation/zeekLogo.png width=100>
 </p>
 

## Bro/Zeek 

### What is Zeek?

Zeek is a network analysis and IDS tool. It is an alternative to various other tools such as Snort, Suricata and OSSEC. While Snort,Suricata and Zeek to quite an extent are majorly used to perform Netwprk based IDS(NIDS) tools like OSSEC are used for Host based IDS(HIDS- such as antivirus, firewall etc).further more most IDS are generally broadly categorized into two types. The signature type or the anomaly detection type, are the two primary detection techniques. The signature type's strategy is to analyse the network traffic for predefined patterns or signatures and then raises alerts when detected where as the anomaly detection type works on listening to the network carefully and detecting any strange behaviour. The chances of a false positive are much higher in anomaly based detection but also conversely leaves room for newer attacks to happen without the signature based IDS even knowing. 

### Why Zeek?

Unlike many other IDS such as Snort and Suricata, Zeek is a hybrid of both anomaly and rule based techniques. Zeek engine structure is indeed very efficient and useful as it creates incoming traffic into a series of events which can be either treated or left as is. An event could be anything like a a new connection , a new ssh connection or anything. The real power of Zeek comes with the Policy Script interpreter. This engine has its own scripting language (Bro/Zeek scripts eg anomaly.zeek) which comes with its own custom made data types and data structures tailored for the use of dealing with network data. Hence Zeek is able to give huge control and power to the user to be able to analyse the data in ways which would have proven very difficult before making it a decent choice to be used as an HIDS too. The user can now generate custom rules and notifications for any particular scenario and so doesent have to rely on predefined rules. Zeek can mimic anything that the conventional rules based IDS such as Snort and Suricata can do with the added advantage of customisability. A network activity in one subnet may be deemed illegal while not in another, this is where Zeek plays its trump card.
<br><br>
Now Zeek is not just merely an IDS, due to its powerful scripting nature it can be used to perform various complex tasks such as incident response, forensics, file extraction, and hashing among other capabilities. Due to its Policy engine we can provide custom scripts to performs certain operations on incoming traffic at any time. Zeek is a logging based IDS, that means it provides log files with well documented extracted data from the network activiity which can be used for forensics in the term that some activity occured. The user can also right custom scripts to log additional informations based only any sort of patterm detections etc.
<br><br>
Further useful links to know more about zeek:
<br>https://zeek.org/
<br>https://www.admin-magazine.com/Archive/2014/24/Network-analysis-with-the-Bro-Network-Security-Monitor
<br>https://bricata.com/blog/what-is-bro-ids/ (very informative website with further links)
<br>http://www.iraj.in/journal/journal_file/journal_pdf/3-27-139087836726-32.pdf <br>a research paper that displays a brief comparison and uses of various IDS


## Zeek Architecture

Zeek is single threaded, hence very often we set up a cluster mechanism where incoming traffic is split into multiple nodes.<br>
<p align=center>
  <img src="/Documentation/zeekarchitecture.png">
</p>


## Try Zeek Online 

Zeek has an interactive web editor to try and learn. It goes a through a wide range of examples to give a good feel on the language and its native data types and structures.
<br> link : https://try.bro.org

## Zeek Installation

There are multiple ways to install/use zeek for analysis.


### Linux:
The ways i encountered during my experience were either to install the binaries provided on the zeek documentation or make it from source from the github repo. Follow the fallowing steps to install instantly:
#### Dependencies:
dependencies : https://docs.zeek.org/en/current/install/install.html
##### RPM/RedHat
install dependencies
```
sudo yum install cmake make gcc gcc-c++ flex bison libpcap-devel openssl-devel python-devel swig zlib-devel
```
On RHEL/CentOS 6/7, you can install and activate a devtoolset to get access to recent GCC versions. You will also have to install and activate CMake 3. For example:
```
sudo yum install cmake3 devtoolset-8
scl enable devtoolset-7 bash
```
##### DEB/Debian
install all the dependencies:
```
sudo apt-get install cmake make gcc g++ flex bison libpcap-dev libssl-dev python-dev swig zlib1g-dev
```
#### Making From Source

clone the repo files as below
```
git clone --recursive https://github.com/zeek/zeek
```
get into the folder and run the following commands
```
./configure
make
make install
```
Once completed zeek would have created a folder at /usr/local/zeek which will contain sub folders with all executables and other important data.
#### Pre Built Binary Release Packages

bundled source packages : https://zeek.org/get-zeek/
latest dev versions:  https://github.com/zeek

###  Post build generation (either from src or pre built binaries)

After these steps, either temporarily export the zeek binaries to path every time (not recommended obviously) or add the export command to the bash/profile file. One way is to add manually copy of the bin folder in zeek to the /usr/bin. This will add all the zeek binaries as system binaries.
```
cp /usr/local/zeel/bin/* /usr/bin 
```
Note: while installing, do not forget to use sudo if not in root,as many of these commands require to create directories and hence require enhanced permission.
### Windows :
Theres no official build for windows as such, since its an open source software. One way to install it would be use the WSL/WSL2. Installation on WSL/WSL2 will follow the same procedure as the Linux way. 
<br> Note: WSL/WSL2 commands like make/cmake run much slower and the installation might take longer than usual.
### Security Onion VM/OS
Another third way that comes as a package deal with many other software that help with zeek analysis is to install the SecurityOnion Linux Distro. It comes pre installed and configured with zeek and the elastic kibana stack that can be used to perform some data visualisation. It is easily installable on vm with configuration to listen on the host. <br>Note: to run it smoothly, it is a very resource draining process hence minimum requirement would be to use it with atleast 8gb ram allocated to it. 4GB ram will work too for simple programs and learner, but 8gb is optimal for deployment.

### Mac :
Personally I do not have experience working on a mac but i will attach the offcial documentation link below:
<br>https://docs.zeek.org/en/current/install/install.html

## Zeek command line tools

The zeek command must be used with various options for various purposes. Some usual commands used are as below: 
```
zeek -i enp0s3
```
```
zeek -i enp0s8 
```
```
zeek -i any
```
The -i helps us choose an interface. Interfaces may include the wifi, ethernet, bluetooth etc. Also VMs may have an additional source of having to listen to the host<br>
Note : 
<br>in all cases accessing sockets/ports info is a privileged command hence use sudo.
<br>most common new system of labeling for internet interfaces have changed from eth0 to enp0s for linux system. To understand more view the below link -
<br>https://unix.stackexchange.com/questions/134483/why-is-my-ethernet-interface-called-enp0s10-instead-of-eth0
<br> zeek can also be used with pre recorded packet captures. Various tools to perform packet capture are : wireshark and tcpdump.

### ZeekCut
Zeek cut is a tool provided by zeek it is very helpful in dealing with quick manual analysis on logs. It efficiently helps you slice out information from the logs you might want to view.

eg  :
```
cat conn.log | zeek-cut id.orig_h id.orig_p id.resp_h duration
```
```
cat conn.log |zeek-cut -d ts uid host uri < conn.log
````
### ZeekCTL

### Zeek examples

Now we shall see couple examples to support my explanation of the zeek event driven model, logging struture and other such things that will help you get started with Zeek if you already havent tried it out on their official web tutorial. 
<p align="center">
  <img src= "/Documentation/test1.png">
</p>
The example shown in the image above shows three events. The init which is used as an initialisation to what the code has to do. The done event is executed when the code is terminating performing last set of commands at the end. This event can be used to do any sort of statistical analysis on data that must have been collected during the run of the script. Any other event is used to perform tasks or analyse, in this example we use the event on connection that has a parameter c which is a record ( zeek datatype similar to c structures). This record consists of various other nested records within it that hold the information of every aspect of the connection. In this example I have printed out a set of values from all of it. You can even print out the complete record which is generally very huge per connection. Further more we define a global variable of the type count( zeek datatype) that will be used to restrict and print the information only for the first 10 connections as shown by the if condition.


### Zeek with python

### ZAT
