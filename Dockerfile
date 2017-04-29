FROM ubuntu:16.04
MAINTAINER G.B. "cardocuco@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install software-properties-common -y

RUN add-apt-repository ppa:x2go/stable
RUN apt-get update


RUN apt-get install openssh-server -y
RUN apt-get install xfce4 xfce4-terminal firefox -y
RUN apt-get install x2goserver x2goserver-xsession pwgen sudo -y
RUN apt-get install ipython -y
RUN apt-get install python-pip -y
RUN pip install selenium 
WORKDIR /usr/bin

RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.16.1/geckodriver-v0.16.1-linux64.tar.gz
RUN tar -xvzf  geckodriver-v0.16.1-linux64.tar.gz
RUN rm geckodriver-v0.16.1-linux64.tar.gz
RUN chmod +x geckodriver
RUN cp geckodriver wires
RUN apt-get -y install python2.7 python-pip python-dev


RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

RUN mkdir /var/run/dbus

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
ADD make_test.sh /make_test.sh 

ADD test.py /test.py
RUN chmod +x /*.sh


EXPOSE 22

CMD ["/run.sh"]
