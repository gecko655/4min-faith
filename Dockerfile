FROM ruby
MAINTAINER gecko655 <aqwsedrft1234@yahoo.co.jp>

RUN apt-get update && apt-get -y upgrade && apt-get -y install rsyslog vim
WORKDIR /usr/
RUN touch /tmp/cronlog.log
COPY secretenv /usr/
RUN (crontab -l; cat secretenv) | crontab
RUN rm secretenv
COPY Gemfile /usr/
RUN bundle install
COPY test /usr/test
COPY Rakefile /usr/
COPY crontab.config /usr/
RUN (crontab -l; cat crontab.config ) | crontab
COPY src /usr/src
    
CMD rsyslogd && cron && tail -f /var/log/syslog /tmp/cronlog.log
