# 10大网络接口配置的“IP”命令

> 原文链接：[10 Useful “IP” Commands to Configure Network Interfaces](https://www.tecmint.com/ip-command-examples/)  
> 译者：moqilintong <moqilintong@foxmail.com>

在这篇文章中，我们将回顾如何设置**静态 IP 地址**，**静态路由**，**默认网关**等等。使用 **IP** 命令可以即刻设置 IP 地址。**Linux** 中，[<font color="red">IFCONFIG 命令</font>](https://www.tecmint.com/ifconfig-command-examples/)是过时的并被 **IP** 命令取代的命令。然而，在大多数 Linux 发行版中，**IFCONFIG** 命令仍然工作并可以使用。

**提示：** 在进行任何修改前请对配置文件进行备份

## 如何配置静态 IP 地址（IPv4）

为了配置静态 IP 地址，你需要更新或编辑网络配置文件来为系统分配静态 IP 地址。你必须从终端或命令提示符使用`su`（switch user）成为超级用户。

<font size="5"><strong>对于 RHEL/CentOS/Fedora</strong></font>

用你熟悉的编辑器打开并<font size="3">编</font>辑`eth0`或`eth1`的网络配置文件。比如，下面是给`eth0`接口分配IP地址。

```bash
[root@tecmint ~]# vi /etc/sysconfig/network-scripts/ifcfg-eth0
```

**示例输出：**

```
DEVICE="eth0"
BOOTPROTO=static
ONBOOT=yes
TYPE="Ethernet"
IPADDR=192.168.50.2
NAME="System eth0"
HWADDR=00:0C:29:28:FD:4C
GATEWAY=192.168.50.1
```

<font size="5"><strong>对于 Ubuntu/Debian/Linux Mint</strong></font>

通过编辑配置文件`/etc/network/interfaces`来给`eth0`接口分配静态IP地址，如下所示：

```
auto eth0
iface eth0 inet static
address 192.168.50.2
netmask 255.255.255.0
gateway 192.168.50.1
```

接下来，使用下列命令重启网络服务：

```bash
# /etc/init.d/networking restart
```

```bash
$ sudo /etc/init.d/networking restart
```

## 命令1：如何为特定接口分配IP地址

使用接下来的命令立即给特定接口（`eth1`）分配IP地址。

```bash
# ip addr add 192.168.50.5 dev eth1
```

```bash
$ sudo ip addr add 192.168.50.5 dev eth1
```

**提示：** 所有的设置会在系统重启之后丢失。

## 命令2：如何查看IP地址

为了获取关于网络接口的详细信息，像 IP 地址，MAC 地址信息，使用下面演示的命令。

```bash
# ip addr show
```

```bash
$ sudo ip addr show
```

**示例输出：**

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 1000
    link/ether 00:0c:29:28:fd:4c brd ff:ff:ff:ff:ff:ff
    inet 192.168.50.2/24 brd 192.168.50.255 scope global eth0
    inet6 fe80::20c:29ff:fe28:fd4c/64 scope link
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN qlen 1000
    link/ether 00:0c:29:28:fd:56 brd ff:ff:ff:ff:ff:ff
    inet 192.168.50.5/24 scope global eth1
    inet6 fe80::20c:29ff:fe28:fd56/64 scope link
       valid_lft forever preferred_lft forever
```

## 命令3：如何移除IP地址

接下来的命令会从给定的接口上（`eth1`）移除分配的 IP 地址。

```bash
# ip addr del 192.168.50.5/24 dev eth1
```

```bash
$ sudo ip addr del 192.168.50.5/24 dev eth1
```

## 命令4：如何启用网络接口

带有接口名称（`eth1`）的“up”标识会启动网络接口。如接下来的命令会激活`eth1`网络接口。

```bash
# ip link set eth1 up
```

```bash
$ sudo ip link set eth1 up
```

## 命令5：如何禁用网络接口

带有接口名称（`eth1`）的“down”标识会禁用网络接口。如接下来的命令会禁用`eth1`网络接口。

```bash
# ip link set eth1 down
```

```bash
$ sudo ip link set eth1 down
```

## 命令6：如何查看路由表

键入以下命令来查看系统的路由表信息。

```bash
# ip route show
```

```bash
$ sudo ip route show
```

**示例输出：**

```
10.10.20.0/24 via 192.168.50.100 dev eth0
192.168.160.0/24 dev eth1  proto kernel  scope link  src 192.168.160.130  metric 1
192.168.50.0/24 dev eth0  proto kernel  scope link  src 192.168.50.2
169.254.0.0/16 dev eth0  scope link  metric 1002
default via 192.168.50.1 dev eth0  proto static
```

## 命令7：如何添加静态路由

为什么你需要添加静态路由或手工路由？因为流量不必非得经过默认网关。我们需要添加静态路由以通过最佳的路径传输流量到目的地。

```bash
# ip route add 10.10.20.0/24 via 192.168.50.100 dev eth0
```

```bash
$ sudo ip route add 10.10.20.0/24 via 192.168.50.100 dev eth0
```

## 命令8：如何移除静态路由

键入以下命令即可移除静态路由。

```bash
# ip route del 10.10.20.0/24
```

```bash
$ sudo ip route del 10.10.20.0/24
```

## 命令9：如何添加持久的静态路由

系统重启后，以上所有路由均会丢失。为了添加持久的静态路由，编辑文件`/etc/sysconfig/network-scripts/route-eth0`（我们将为`eth0`添加静态路由），添加下列各行，保存并退出。默认情况下，`route-eth0`文件不存在，需要创建。

<font size="5">对于 RHEL/CentOS/Fedora</font>

```bash
# vi /etc/sysconfig/network-scripts/route-eth0
```

```
10.10.20.0/24 via 192.168.50.100 dev eth0
```

<font size="5">对于 Ubuntu/Debian/Linux Mint</font>

打开文件`/etc/network/interfaces`，在末尾添加静态路由。所示 IP 地址可能与你的环境中的不同。

```bash
$ sudo vi /etc/network/interfaces
```

```bash
auto eth0
iface eth0 inet static
address 192.168.50.2
netmask 255.255.255.0
gateway 192.168.50.100
#########{Static Route}###########
up ip route add 10.10.20.0/24 via 192.168.50.100 dev eth0
```

接下来，键入下列命令以重启网络服务

```bash
# /etc/init.d/networking restart
```

```bash
$ sudo /etc/init.d/networking restart
```

## 命令10：如何添加默认网关

默认网关可以指定为全局性的，也可以是在特定接口的配置文件中。如果我们的系统中有不止一个 NIC（网络接口控制器）存在，默认网关的优势是显而易见的。你可以通过以下命令添加默认网关。

```bash
# ip route add default via 192.168.50.100
```

```bash
$ sudo ip route add default via 192.168.50.100
```

----------

如有舛错，欢迎指正。请通过终端/命令提示符使用`man ip`查看参考手册以获取更多关于 IP 命令的内容。