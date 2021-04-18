# ubuntu vagrant 免密集群

## ubuntu vagrant 免密集群
### 三个节点node1 node2 node3

- 安装vagrant
- 安装virtualbox(现在virtualbox 与hyper-v共存了) 

```bash
vagrant up 
```

- 登录到node1,下面的作用是ssh免密登录

```bash
vagrant ssh node1
./ssh_ip.sh
pscp -h ip.txt  ~/ssh_ip.sh /home/vagrant 
pssh -h ip.txt -i bash ~/ssh_ip.sh
```

 




