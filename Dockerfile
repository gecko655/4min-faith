FROM ruby
MAINTAINER gecko655 <aqwsedrft1234@yahoo.co.jp>

WORKDIR /usr/
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get -y autoremove \
    && apt-get -y install rsyslog vim

RUN apt-get install -y ocl-icd-libopencl1 libopencv-dev

RUN touch /tmp/cronlog.log
COPY secretenv /usr/
RUN (crontab -l; cat secretenv) | crontab
RUN rm secretenv
COPY Gemfile /usr/
RUN bundle config build.ruby-opencv --with-opencv-dir=/usr/OpenCV/build/bin \
    && bundle install 
COPY test /usr/test
COPY Rakefile /usr/
COPY crontab.config /usr/
RUN (crontab -l; cat crontab.config ) | crontab
COPY src /usr/src
    
CMD rsyslogd && cron && tail -f /var/log/syslog /tmp/cronlog.log
