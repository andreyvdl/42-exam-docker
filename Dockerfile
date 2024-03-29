FROM ubuntu:20.04

ARG YOUR_LOGIN

ENV TZ=America/Sao_Paulo \
  USER=${YOUR_LOGIN}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -y \
  build-essential \
  clang \
  vim \
  nano \
  emacs \
  curl \
  libreadline-dev \
  git \
  wget \
  && apt clean

RUN mkdir /home/${YOUR_LOGIN} && \
 /usr/bin/echo -e > /home/${YOUR_LOGIN}/instructions.txt \
'1. Mantenha esse container rodando\n\
2. Abra esse container em outra janela/aba com o seguinte comando:\n\
\tmake enter\n\
3. Volte a primeira janela/aba e rode esse comando:\n\
\tbash -c "$(curl https://grademe.fr)"\n\
Agora a primeira janela/aba tem o exame e a segunda seu ambiente de código.\n\n\
PS. se for rodar o vscode do container, abra um terminal e digite fora do container:\n\
\txhost +\n\
uma mensagem parecida com essa deve aparecer:\n\
\t"access control disabled, clients can connect from any host"\n\n\
Anyway, boa sorte, divirta-se :)'

WORKDIR /home/${YOUR_LOGIN}

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    apt-transport-https \
    libx11-xcb1 \
    libxtst6 \
    libasound2 \
    libxkbfile1 \
    --no-install-recommends

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
  | \
  gpg --dearmor > microsoft.asc.gpg \
  && \
  install -o root -g root -m 644 microsoft.asc.gpg \
    /usr/share/keyrings/visual-studio-code-archive-keyring.gpg \
  && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/visual-studio-code-archive-keyring.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list \
  && \
  apt-get update && apt-get install -y code --no-install-recommends \
  && \
  rm -fr microsoft.asc.gpg \
  && \
  # bash -c 'exit' \
  # && \
  echo >> /root/.bashrc \
"alias code='code --no-sandbox --user-data-dir=/root'"
ENTRYPOINT [ "bash" ]
