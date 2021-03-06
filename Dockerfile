
FROM centos:7

COPY ./kea-1.5.0-adevur0-amd64.tar.gz.part1 /kea.tar.gz.part1

COPY ./kea-1.5.0-adevur0-amd64.tar.gz.part2 /kea.tar.gz.part2

RUN (cat /kea.tar.gz.part* > /kea.tar.gz) \
  && rm -f /kea.tar.gz.part*

RUN yum clean all -y \
  && yum update -y \
  && yum install -y epel-release \
  && yum install -y log4cplus openssl boost \
  && yum autoremove -y \
  && yum clean all -y \
  && tar xzf /kea.tar.gz -C /usr/local \
  && rm -f /kea.tar.gz

CMD ["/usr/local/kea/sbin/kea-dhcp4", "-c", "/usr/local/kea/etc/kea/kea-dhcp4.conf"]
