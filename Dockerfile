FROM scottatron/vagrant-ruby19-mysql

ENV HOME /root
CMD ["/sbin/my_init"]

ADD . /build/
RUN export LC_ALL=C &&\
    export DEBIAN_FRONTEND=noninteractive &&\
    apt-get -y update &&\
    echo " ---> Installing PHP" &&\
    apt-get install -y php5-cli php5-mysql php5-memcache php-pear libyaml-dev php5-dev &&\
    pecl install yaml &&\
    rsync -r /build/php/etc / &&\
    php5enmod yaml memcache-sessions &&\
    echo " ---> Installing Memcached" &&\
    apt-get install -y memcached &&\
    rsync -r /build/memcached/etc / &&\
    echo " ---> Install Node.js" &&\
    apt-get install -y nodejs &&\
    echo " ---> Cleaning up" &&\
    apt-get clean && rm -rf /build /var/lib/apt/lists/* /tmp/* /var/tmp/*
