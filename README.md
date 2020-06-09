This docker image allow Big Data Service users have Zeppelin notebook on their Big Data Service.
In order to satrt using it, provision some Linux node on OCI and run follow commands:

1) `yum install -y git docker-engine`

2)  `wget https://packagecloud.io/github/git-lfs/packages/el/7/git-lfs-2.11.0-1.el7.x86_64.rpm/download -O git-lfs-2.11.0-1.el7.x86_64.rpm`

3) `rpm -Uhv git-lfs-2.11.0-1.el7.x86_64.rpm`
 
4) `git clone https://github.com/filanovskiy/docker-zeppelin-bds`

5) `cd docker-zeppelin-bds`

6) `sudo service docker start`

7) `docker build .`
