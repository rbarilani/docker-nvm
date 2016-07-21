FROM registry.opensource.zalan.do/stups/node:5.4-3 
MAINTAINER Ruben Barilani <ruben.barilani.dev@gmail.com>

# Replaces default command interpreter from sh to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install base software
RUN apt-get update && \
	apt-get install -qy \
	build-essential \
	libssl-dev git \
	man \
	curl 
	
# Install extra software
RUN apt-get install -qy python python-dev \
	ruby-full \
	vim	

# Manually install NVM globally
RUN git clone https://github.com/creationix/nvm.git /opt/nvm
RUN mkdir /usr/local/nvm
COPY nvm.sh /etc/profile.d/	
RUN chmod ug=rwx /etc/profile.d/nvm.sh
RUN echo "source /etc/profile.d/nvm.sh" >> /etc/bash.bashrc

# Install node versions with NVM
RUN source /etc/profile.d/nvm.sh && \
	nvm install 0 && \
	nvm install 4 && \
	nvm install 5 && \
	nvm install 6 && \
	nvm alias default 5

# update NVM folder permissions
RUN chmod ugo=rwx -R /usr/local/nvm

ENTRYPOINT ["/bin/bash", "--login", "-i", "-c"]
CMD ["bash"]