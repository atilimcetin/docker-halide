FROM ubuntu:16.04

MAINTAINER Atilim Cetin <atilim.cetin@gmail.com>

ENV LLVM_CONFIG /tmp/clang/bin/llvm-config
ENV CLANG /tmp/clang/bin/clang

RUN apt-get update && apt-get install -y wget xz-utils git make gcc g++ zlib1g-dev && \
    cd /tmp && \
    wget http://llvm.org/releases/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz && \
    tar xf clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04.tar.xz && \
    mv clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04 clang && \
    git clone https://github.com/halide/Halide.git /tmp/Halide && \
    cd /tmp/Halide && \
    git checkout master && \
    mkdir /root/halide_master && \
    cd /root/halide_master && \
    make -f /tmp/Halide/Makefile && \
    rm -rf /root/halide_master/bin/build && \
    cd /tmp/Halide && \
	git checkout auto_scheduler && \
	mkdir /root/halide_auto_scheduler && \
	cd /root/halide_auto_scheduler && \
	make -f /tmp/Halide/Makefile && \
	rm -rf /root/halide_auto_scheduler/bin/build && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

