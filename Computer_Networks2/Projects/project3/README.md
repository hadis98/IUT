## Analyze Openflow With Mininet emulator & Create Custom Topology With Python

### What is Floodlight controller
- It is a type of software-defined networking (SDN) controller.
- It uses the OpenFlow protocol to orchestrate traffic flows in a network.
- OpenFlow is a standard that defines how a controller can communicate with switches and routers to modify their forwarding behavior.
- It is developed by an open community of developers.
- It is written in Java and supports REST APIs for programming and interfacing with the product.
- It can work with both physical and virtual OpenFlow-compatible switches
- It can integrate with OpenStack for cloud networking .
- It offers developers the ability to easily adapt software and develop applications.

### What is SDN
- Software-defined networking (SDN) is a network management method that supports dynamic programmable network configuration.
- it improves network performance and management efficiency
- On a traditional network, network devices can be divided into the management plane, control plane, and forwarding plane.
- Management plane: orchestrates services and formulates policies.
- Control plane: controls operating system running and calculates using various algorithms.
- Forwarding plane: forwards and receives data packets.
- The concept of SDN is to decouple the control and forwarding functions of network devices
- so the control plane of network devices can be directly programmed and network services can be abstracted from underlying hardware devices.

The following figure shows the comparison between the SDN architecture and the traditional network architecture.

- <img width="600px"  src="https://i.postimg.cc/T36J58qY/image.png"/>

### SDN Architecture

- In traditional SDN architecture, there are three layers:
- Application layer
  - This is where the applications will run and decide how the traffic should move in a network.
  - For example, routing protocols like OSPF, BGP, Firewall application, etc.
- Control Layer

  - This is where the controller resides.
  - The controller acts as a bridge between the application and the switches.
  - It relays the information from the application and converts them into network “flows” that are entered in the switch’s “flow table.”

- Data/Infrastructure layer:
  - This is the forwarding plane that has the actual hardware devices.
  - These devices refer to the flow entries in their flow table to forward packets through the network.
- <img width="600px"  src="https://i.postimg.cc/dtK5rTJY/image.png"/>

### What is OpenFlow

- OpenFlow is a network communication protocol used between controllers and forwarders in an SDN architecture.
- The core idea of SDN is to separate the forwarding plane from the control plane.
- To achieve this, a communication standard must be built between controllers and forwarders to allow the controllers to directly access and control the forwarding plane of forwarders.
- OpenFlow introduces the concept of flow table, based on which forwarders forwards data packets.
- Controllers deploy flow tables on forwarders through OpenFlow interfaces.

### Project Explaination

- create a network of 12 hosts and 11 switches in mininet with python

  - <img width="700px"  src="https://i.postimg.cc/nhw9FHNj/image.png"/>

- created network in **Topology Visualizer**

  - <img width="700px"  src="https://i.postimg.cc/WbFQWSjB/image.png"/>

- created network in **Floodlight**

  - <img width="500px"  src="https://i.postimg.cc/5yVW8CQH/image.png"/>

- Test the connection between hosts

  - <img width="700px"  src="https://i.postimg.cc/SNnw14cQ/image.png"/>

- execute **nodes** command

  - <img width="700px"  src="https://i.postimg.cc/6pvTXDxt/image.png"/>

- Check the status of network links using the iperf command in the Mininet environment

  - <img width="700px"  src="https://i.postimg.cc/6pvTXDxt/image.png"/>

- Define three desired paths in the topology so that:

  - these three paths have the least intersection with each other
  - the source and destination nodes are at the farthest points of the network from each other.
  - Path1 = h12->s8->s1->s2->s3->s4->s5->h8
    - <img width="400px"  src="https://i.postimg.cc/k5d4Sp9n/image.png"/>
  - Path2 = h5->s3->s10->s2->s9->s1->s8->s7->h10
    - <img width="400px"  src="https://i.postimg.cc/TY7wsrSn/image.png"/>
  - Path3 = h6->s4->s0b->s6->s9->s8->h12
    - <img width="400px"  src="https://i.postimg.cc/yYMqWx3w/image.png"/>


- Executing flow.py in terminal:
  - The two hosts that we specified in path1 got an IP address in the topology
  - <img width="600px"  src="https://i.postimg.cc/y8X28H4K/image.png"/>
  - <img width="300px"  src="https://i.postimg.cc/3xbCB0Yw/image.png"/> <img width="300px"  src="https://i.postimg.cc/437vF4xQ/image.png"/>
  
- Test connectivity between hosts 
    - <img width="600px"  src="https://i.postimg.cc/3xwFmFM6/image.png"/>

- State of Switches

  - State of Switch8 **before** running flow.py file
    - <img width="400px"  src="https://i.postimg.cc/5tNq55ZT/image.png"/>
  - State of Switch8 **after** running flow.py file
    - <img width="800px"  src="https://i.postimg.cc/5yNVbRGp/image.png"/>
    - The input and output ports are also shown from the flow table, which includes two sections, match and action.
    - For example, in flow0, the action that is performed is exit from port 2.
    - The number of packets sent from the sender to the receiver is also specified, which is equal to the number of packets in flow 1,      where the source and destination have been changed.
    - Eth_dest, eth_src are the MAC addresses of the source and destination hosts
    - Because we are using ping command, the icmp protocol sends a request to the destination from the sender's side and the destination must reply.
    - So two flows are created, in first flow: the origin of which is 10.0.0.12 and the destination is 10.0.0.8.
    - in second flow: the origin of which is 10.0.0.8 and the destination is 10.0.0.12.

## References
- [mininet walkthrough](https://mininet.org/walkthrough/)
- [Experimentation with Mininet Topologies](https://indjst.org/download-article.php?Article_Unique_Id=INDJST7990&Full_Text_Pdf_Download=True#:~:text=In%20mininet%20we%20have%20various,%2C%20linear%2C%20tree%20topology%20etc.&text=We%20have%20run%20various%20topologies,two%20hosts%20and%20one%20switch.)
- [SDN](https://info.support.huawei.com/info-finder/encyclopedia/en/SDN.html)

## License
- This project is licensed under [MIT License].
- You can use it for personal or educational purposes as long as you give credit to its author.

## Author
- This project was created by Hadis Ghafouri as first project for Computer Network2 course at IUT.
- You can contact me by email at hadisghafouri@gmail.com.
