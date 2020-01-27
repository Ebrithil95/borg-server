FROM alpine:latest

#Install Borg & SSH
RUN apk add openssh sshfs borgbackup supervisor --no-cache
RUN adduser -D -u 1000 borg && \
    mkdir /backups && \
    chown borg.borg /backups && \
    sed -i \
        -e 's/^#PasswordAuthentication yes$/PasswordAuthentication no/g' \
        -e 's/^PermitRootLogin without-password$/PermitRootLogin no/g' \
        /etc/ssh/sshd_config

COPY supervisord.conf /etc/supervisord.conf
COPY docker-entrypoint.sh /

RUN passwd -u borg

VOLUME [ "/etc/ssh", "/home/borg/.ssh" ]

EXPOSE 22

ENTRYPOINT [ "/docker-entrypoint.sh" ]
