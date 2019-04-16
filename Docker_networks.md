Version:0.9 StartHTML:00000141 EndHTML:00001124 StartFragment:00000175 EndFragment:00001088 SourceURL:https://docs.docker.com/network/
## Docker network
### 1 Network driver summary
  - **User-defined bridge networks** are best when you need multiple containers to communicate on the same Docker host.
  - **Host networks** are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated.
  - **Overlay networks** are best when you need containers running on different Docker hosts to communicate, or when multiple applications work together using swarm services.
  - **Macvlan networks** are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address.
  - **Third-party network plugins** allow you to integrate Docker with specialized network stacks.
### 2 User-defined bridge networks
a bridge network uses a software bridge which allows containers connected to the same bridge network to communicate, while providing isolation from containers which are not connected to that bridge network. The Docker bridge driver automatically installs rules in the host machine so that containers on different bridge networks cannot communicate directly with each other.

Bridge networks apply to containers running on the same Docker daemon host. For communication among containers running on different Docker daemon hosts, you can either manage routing at the OS level, or you can use an overlay network.
#### 2.1 Differences between user-defined bridges and the default bridge
##### 2.1.1 User-defined bridges provide better isolation and interoperability between containerized applications.
Containers connected to the same user-defined bridge network automatically expose all ports to each other, and no ports to the outside world.
If you run the same application stack on the default bridge network, you need to open both the web port and the database port, using the -p or --publish flag for each. **it means all container's network is isolated with each other for default bridge** 
##### 2.1.2 User-defined bridges provide automatic DNS resolution between containers.
Containers on the default bridge network can only access each other by IP addresses, unless you use the --link option, which is considered legacy. On a user-defined bridge network, containers can resolve each other by name or alias.
##### 2.1.3 Containers can be attached and detached from user-defined networks on the fly.
##### 2.1.4 Each user-defined network creates a configurable bridge.
##### 2.1.5 Linked containers on the default bridge network share environment variables.
Originally, the only way to share environment variables between two containers was to link them using the --link flag. This type of variable sharing is not possible with user-defined networks