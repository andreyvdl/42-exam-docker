FROM ubuntu:20.04

ARG YOUR_LOGIN

ENV TZ=America/Sao_Paulo USER=${YOUR_LOGIN}

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
'1. Mantenha esse container rodando\n\
2. Abra esse contaienr em outra janela/aba com o seguinte comando:\n\
\tdocker exec -it $(docker ps | grep exam | awk '"'"'{print $1}'"'"') bash\n\
3. Volte a primeira janela/aba e rode esse comando:\n\
\tbash -c "$(curl https://grademe.fr)"\n\
Agora a primeira janela/aba tem o exame e a segunda seu ambiente de código.\n\
Se for a segunda vez que você vai fazer o simulado entre na pasta 42_EXAM e \
rode make 2 vezes (na primeira ele vai recriar o executavel, na segunda \
iniciar o simulado).\n\
Anyway, boa sorte, divirta-se :)'

WORKDIR /home/${YOUR_LOGIN}

RUN git clone https://github.com/JCluzet/42_EXAM.git

ENTRYPOINT [ "bash" ]
