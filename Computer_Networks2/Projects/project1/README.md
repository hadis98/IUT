# Introduction to Mininet Simulator

### What I learned In This Project
- Installed and Used mininet on Virtual machine.
- Worked with different topologies in mininet.
- Worked with [Mininet Topology Visualizer](http://demo.spear.narmox.com/app/?apiurl=demo#!/mininet) which is an amzaing tool for visualizing the network topology.

### What Is Mininet
- It is a network emulator which creates a network of virtual hosts, switches, controllers, and links.
- It is mainly used for developing and testing software-defined networks (SDN).
- Provides a simple and inexpensive network testbed for developing OpenFlow applications.
- Enables complex topology testing, without the need to wire up a physical network
- Supports arbitrary custom topologies, and includes a basic set of parametrized topologies
- Mininet allows you to create and experiment with different network topologies and scenarios without the need for physical hardware. 
- Includes a CLI that is topology-aware and OpenFlow-aware, for debugging or running network-wide tests.
- It Provides a straightforward and extensible Python API for network creation and experimentation

### Commands in Mininet
- **Mininet>help**
    - This command show various options which we can write on Mininet CLI.
- **Mininet>nodes**
    - This command shows the nodes available in the current network of Mininet.
- **Mininet>dump**
    - This command shows the dump information about all nodes available in the current Mininet network.
- **Mininet> h1 ping h2**
    - This command tests the connectivity between host h1 and h2. 
    - This command will keep checking the connectivity between hosts until we stop the command.
- **Mininet> h1 ping -c1 h2**
    - This command checks for the connection between host h1 and h2 for one packet.
- **Mininet> h1 ifconfig -a**
    - This command shows us the host’s h1-eth0 and loopback (lo) interfaces.
    - The interface h1-eth0 is not seen by the main Linux system, when we run the ifconfig command.
    - Because it is specific to host of network.
- **Mininet>pingall**
    -This command checks the connectivity/reachability among all hosts in the network.

### Topologies in Mininet
* **Minimal Topology**
    - It is the most basic topology with two hosts and one switch.
    - To run minimal topology we use the **Sudo mn --topo minimal** command in terminal.
        - <img width="500px" src="https://i.postimg.cc/7hHt6Hjz/image.png"/>
* **Single Topology**
    - It is the simple topology with one switch and N hosts.
    - To run this topology we use the **Sudo mn --topo single,3** command in terminal.    
        - <img width="500px"  src="https://i.postimg.cc/DwB8SnmT/image.png"/>

    - execution of **nodes** command
        - <img  width="500px"  src="https://i.postimg.cc/9fLFQp8F/image.png"/>

    - execution of **net** command
        - <img width="500px"  src="https://i.postimg.cc/pdQkhs38/image.png"/>

    - execution of **dump** command
        - <img width="500px"  src="https://i.postimg.cc/PrzmMCSs/image.png"/>
    
    - network in **topology visualizer**
        - <img width="500px"  src="https://i.postimg.cc/9QDggPKw/image.png"/>
* **Reversed Topology**
    - It is similar to the single connection but order of connection between hosts and switch is reversed.
    - To run this topology we use the **Sudo mn --topo reversed,3** command in terminal.
        - <img width="500px"  src="https://i.postimg.cc/RZgt5ML8/image.png"/>
    
    - network in **topology visualizer**
        - <img width="500px"  src="https://i.postimg.cc/mrsH0Bhf/image.png"/>
* **Linear Topology**
    - It is the connection between the N hosts and N switches.
    - To run this topology we use the **Sudo mn --topo linear,3** command in terminal.
        - <img width="500px" src="https://i.postimg.cc/m2bhbvkG/image.png"/>
    - executing **links** and **dump** commands
    - <img width="500px" src="https://i.postimg.cc/2y8JGsnn/image.png"/>

    - network in **topology visualizer**
        - <img width="500px" src="https://i.postimg.cc/bv5sqPww/image.png"/>
* **Tree Topology**
    - A tree topology is a multilevel topology with N levels and two hosts per switch.
    - To run this topology we use the **Sudo mn –-topo tree,3** command in terminal.


## References
- [mininet](https://mininet.org/overview/)
- [Experimentation with Mininet Topologies](https://indjst.org/download-article.php?Article_Unique_Id=INDJST7990&Full_Text_Pdf_Download=True#:~:text=In%20mininet%20we%20have%20various,%2C%20linear%2C%20tree%20topology%20etc.&text=We%20have%20run%20various%20topologies,two%20hosts%20and%20one%20switch.)

## License
- This project is licensed under [MIT License]. 
- You can use it for personal or educational purposes as long as you give credit to its author.

## Author
* This project was created by Hadis Ghafouri as first project for Computer Network2 course at IUT.
* You can contact me by email at hadisghafouri@gmail.com.
