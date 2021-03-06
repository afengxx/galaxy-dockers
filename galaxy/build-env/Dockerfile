FROM ubuntu:16.04

COPY ./sources.list /etc/apt/sources.list
COPY ./version /version

RUN set -ex \
    && apt-get update --fix-missing \
    && apt-get install -y \
    libpcre3-dev \
    libssl-dev \
    libxslt1-dev libgd-dev \
    libgeoip-dev libpam0g-dev \
    gcc make subversion openssh-server \
    && mkdir -p /var/run/sshd \
    && echo 'root:123' | chpasswd \
    && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    # SSH login fix. Otherwise user is kicked off after login
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

#    && apt-get install -y \
#    libpcre3 \
#    libssl1.0.0 \
#    libxslt1.1 libgd3 \
#    libgeoip1 libpam0g \
#    make \
#    && svn co svn://192.168.68.196/EZ_Remote/nginx-1.10.3/trunk /tmp/nginx --username kwang --password kwang --non-interactive \
#    && cd /tmp/nginx/nginx-1.10.3 \
#    && chmod +x ./configure \
#    && ./configure --with-cc-opt='-g -O2 -fPIE -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now' --prefix=/usr --conf-path=/etc/nginx/nginx.conf --http-log-path=/home/nginx/var/log/nginx/access.log --error-log-path=/home/nginx/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-debug --with-pcre-jit --with-ipv6 --with-http_ssl_module --with-http_stub_status_module --with-http_realip_module --with-http_auth_request_module --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_v2_module --with-http_sub_module --with-http_xslt_module --with-stream --with-stream_ssl_module --with-mail --with-mail_ssl_module --with-threads --add-module=../ngx_http_auth_pam_module --add-module=../nginx-dav-ext-module --add-module=../echo-nginx-module --add-module=../nginx-upstream-fair --add-module=../ngx_http_substitutions_filter_module --add-module=../ngx_devel_kit --add-module=../set-misc-nginx-module \
#    && make -j4 \
#    && make install \
#    && cp -rf /tmp/nginx/nginx_service /lib/systemd/system/nginx.service \
#    && chmod +r /lib/systemd/system/nginx.service \
#    && mkdir -p /var/lib/nginx/ \
#    && mkdir -p /var/lib/nginx/body \
#    && rm -f /tmp/nginx \
#    && apt-get remove --purge --auto-remove -y \
#    libpcre3-dev \
#    libssl1.0-dev \
#    libxslt1-dev libgd-dev \
#    libgeoip-dev libpam0g-dev \
#    gcc make subversion \
#    && apt-get autoremove \
#    && apt-get install -y \
#    libpcre3 \
#    libssl1.0.0 \
#    libxslt1.1 libgd3 \
#    libgeoip libpam0g \
#    && apt-get autoclean \
#    && systemctl daemon-reload \
#    && systemctl enable nginx.service \
#    && systemctl restart nginx.service

EXPOSE 22

STOPSIGNAL SIGTERM
#
CMD ["/usr/sbin/sshd", "-D"]