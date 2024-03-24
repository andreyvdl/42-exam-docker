FROM ubuntu:20.04

ARG YOUR_LOGIN

ENV TZ=America/Sao_Paulo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y \
  man-db \
  build-essential \
  clang \
  vim \
  nano \
  emacs \
  curl \
  libreadline8 \
  libreadline-dev \
  git \
  wget \
  && apt clean

RUN mkdir /home/${YOUR_LOGIN} && \
 /usr/bin/echo -e > /home/${YOUR_LOGIN}/instructions.txt \
'1. Keep this docker open\n\
2. Open this docker in another tab/window with the following command:\n\
\tdocker exec -it $(docker ps | grep exam | awk '"'"'{print $1}'"'"') bash\n\
3. Back to the first tab/window run this command:\n\
\tbash -c "$(curl https://grademe.fr)"\n\
Now the first tab/window has the exam and the second tab/window is your coding \
space.\n\
\n\
Anyway, good luck, have fun'

WORKDIR /home/${YOUR_LOGIN}

ENTRYPOINT [ "bash" ]
