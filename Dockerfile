FROM alpine:latest
MAINTAINER laurdawn@gmail.com

ENV frps_DIR=/usr/local/frps
ENV	frps_filename=frp_0.22.0_linux_amd64
COPY ./frps.ini /frp/
COPY ./frp_0.22.0_linux_amd64.tar.gz ${frps_DIR}/
RUN set -ex && \
	apk add --no-cache pcre bash && \
	apk add --no-cache --virtual TMP tar && \
	cd ${frps_DIR} && \
	tar xzf ${frps_filename}.tar.gz && \
	mv ${frps_DIR}/${frps_filename}/frps ${frps_DIR}/frps && \
	apk --no-cache del --virtual TMP && \
	rm -rf /var/cache/apk/* ~/.cache ${frps_DIR}/${frps_filename} ${frps_DIR}/${frps_filename}.tar.gz
ENTRYPOINT ["/usr/local/frps/frps", "-c", "/frp/frps.ini"]