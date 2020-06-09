This docker image allow Big Data Service users have Zeppelin notebook on their Big Data Service.
In order to satrt using it, provision some Linux node on OCI and run follow commands:

1) `yum install -y git docker-engine`

2) `git clone https://github.com/filanovskiy/docker-zeppelin-bds`

3) `cd docker-zeppelin-bds`

4) `sudo service docker start`

5) `docker build .`
