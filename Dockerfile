FROM nginx
EXPOSE 80
RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y curl && \
  apt-get install -y python2.7 && \
  cd /tmp && \
  curl -O https://bootstrap.pypa.io/get-pip.py && \
  python2.7 get-pip.py && \
  pip install awscli && \
  rm -rf /tmp/* && \
  rm -rf /var/lib/apt/lists/*
COPY ./default.conf /etc/nginx/conf.d/default.conf
COPY ./index.html /usr/share/nginx/html/index.html
COPY ./app.js /usr/share/nginx/html/app.js
COPY ./init.sh /init.sh
CMD  /bin/bash /init.sh && nginx -g "daemon off;"
