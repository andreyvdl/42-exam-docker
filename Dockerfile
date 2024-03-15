FROM ubuntu:20.04

ARG YOUR_LOGIN

RUN apt update && apt install -y \
  build-essential \
  clang \
  vim \
  nano \
  curl \
  libreadline-dev \
  git \
  && apt clean
#   emacs \

RUN mkdir /home/${YOUR_LOGIN} && \
 /usr/bin/echo -e > /home/${YOUR_LOGIN}/instructions.txt \
'1. Keep this docker open\n\
2. Open this docker in another tab/window with the following commands:\n\
\t`docker ps | grep exam:latest | awk '"'"'{print $1}'"'"'`\n\
\t`docker exec -it "hash-received-from-the-command-above" bash`\n\
3. Back to the first docker run this command:\n\
\t`bash -c "$(curl https://grademe.fr)"`\n\
Now the first docker has the exam and the second docker is your coding space.'

WORKDIR /home/${YOUR_LOGIN}

ENTRYPOINT [ "bash" ]