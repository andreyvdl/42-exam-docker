FROM ubuntu:20.04

# install compilers for c and c++ and basic editors like vim and emacs
RUN apt update && apt install -y \
  build-essential \
  clang \
  vim \
  nano \
  curl \
  wget \
  readline-common \
  && apt clean
#   emacs \

ENTRYPOINT [ "bash" ]