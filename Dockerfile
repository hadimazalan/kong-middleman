FROM kong:0.14.1-centos
LABEL maintainer="Hadi Mazalan"

RUN mkdir -p /usr/local/kong/plugins
COPY plugins /usr/local/kong/plugins
RUN yum install git -y \
    && yum install zip -y \
    && yum install vim -y \
    && cd /usr/local/kong/plugins/middleman \
    && /usr/local/bin/luarocks make *.rockspec make *.rockspec \
    && cd /usr/local/kong/plugins/kong-plugin-jwt-claims-headers \
    && /usr/local/bin/luarocks make *.rockspec make *.rockspec 

#  add bundled & middleman plugins
ENV KONG_PLUGINS "bundled,middleman,jwt-claims-headers"
