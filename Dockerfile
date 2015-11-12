FROM ruby
MAINTAINER gecko655 <aqwsedrft1234@yahoo.co.jp>

WORKDIR /root/4min-faith
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y dist-upgrade \
    && apt-get -y autoremove \
    && apt-get -y install rsyslog vim \
    && apt-get -y install ocl-icd-libopencl1 \
    && apt-get -y install libopencv-dev

RUN touch /tmp/cronlog.log

COPY cascade cascade

COPY secretenv .
RUN (crontab -l; cat secretenv) | crontab
RUN rm secretenv

COPY Gemfile .
RUN bundle config build.ruby-opencv --with-opencv-dir=/usr/OpenCV/build/bin \
    && bundle install 
COPY test test
COPY Rakefile .

COPY crontab.config .
RUN (crontab -l; cat crontab.config ) | crontab

COPY src src
    
CMD rsyslogd && cron && tail -f /var/log/syslog /tmp/cronlog.log
