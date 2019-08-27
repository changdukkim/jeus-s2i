FROM registry.bastion.ocpnh.com:5000/jeus7:0.5

LABEL io.k8s.description="Platform for serving static files" \
      io.k8s.display-name="Jeus" \
      io.openshift.expose-services="8088:http" \
      io.openshift.tags="builder,http,webtob"

LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i

COPY files/s2i/ /usr/local/s2i

RUN chmod 775 /usr/local/s2i/* \
  && chmod -R 775 /home/tmax \
  && chown -R tmax:root /home/tmax 

# 8088 포트를 오픈한다.
EXPOSE 8088

USER 1000
# 실행명령
CMD ["/home/tmax/jeus7/domains/jeus_domain/bin/startManagedServer -domain jeus_domain -server server1 -u administrator -p jeusadmin --verbose"]
