FROM scottatron/vagrant-ruby19-mysql

ENV HOME /root
CMD ["/sbin/my_init"]

ADD . /build/
RUN export LC_ALL=C &&\
    export DEBIAN_FRONTEND=noninteractive &&\
    export minimal_apt_get_install='apt-get install -y --no-install-recommends' &&\
    apt-get -y update &&\
    echo " ---> Installing PHP" &&\
    $minimal_apt_get_install -y php5-cli php5-mysql php5-memcache php-pear libyaml-dev php5-dev &&\
    pecl install yaml &&\
    rsync -r /build/php/etc / &&\
    php5enmod yaml memcache-sessions &&\
    echo " ---> Installing Memcached" &&\
    $minimal_apt_get_install -y memcached &&\
    rsync -r /build/memcached/etc / &&\
    echo " ---> Install Node.js" &&\
    $minimal_apt_get_install -y nodejs &&\
    echo " ---> Cleaning up" &&\
    apt-get clean && rm -rf /build /var/lib/apt/lists/* /tmp/* /var/tmp/*
