FROM alpine:latest

RUN apk update

RUN apk add ca-certificates
RUN apk add git
RUN apk add gcc
RUN apk add make
RUN apk add autoconf
RUN apk add automake
RUN apk add libtool
RUN apk add ncurses-static
RUN apk add ncurses-dev
RUN apk add musl-dev

WORKDIR /tmp
RUN git clone https://github.com/libevent/libevent.git

WORKDIR /tmp/libevent
RUN ./autogen.sh
RUN ./configure --prefix=/usr --disable-shared --enable-static
RUN make install

WORKDIR /tmp
RUN git clone https://github.com/tmux/tmux.git

WORKDIR /tmp/tmux
RUN ./autogen.sh
RUN CFLAGS='-DHAVE___PROGNAME=0' ./configure --enable-static
RUN sed -i '/^am__append.*=.*compat\/forkpty-linux.*/d' Makefile
RUN sed -i '/^am__object.*=.*compat\/forkpty-linux.*/d' Makefile
RUN sed -i '/^am__append.*=.*compat\/setenv.*/d' Makefile
RUN sed -i '/^am__object.*=.*compat\/setenv.*/d' Makefile
RUN make

RUN strip /tmp/tmux/tmux

CMD /bin/sh

# vim:ts=4:sw=4:et:
