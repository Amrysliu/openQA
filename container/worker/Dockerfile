#!BuildTag: openqa_worker
FROM opensuse/leap:15.2
LABEL maintainer Jan Sedlak <jsedlak@redhat.com>, Josef Skladanka <jskladan@redhat.com>, wnereiz <wnereiz@eienteiland.org>, Sergio Lindo Mansilla <slindomansilla@suse.com>
LABEL version="0.3"

# hadolint ignore=DL3037
RUN zypper ar -p 95 -f http://download.opensuse.org/repositories/devel:openQA/openSUSE_Leap_15.2 devel_openQA && \
    zypper ar -p 90 -f http://download.opensuse.org/repositories/devel:openQA:Leap:15.2/openSUSE_Leap_15.2 devel_openQA_Leap && \
    zypper --gpg-auto-import-keys ref && \
    zypper in -y ca-certificates-mozilla curl gzip && \
    zypper in -y openQA-worker qemu-arm qemu-ppc qemu-x86 qemu-tools && \
    zypper in -y kmod && \
    (zypper in -y qemu-ovmf-x86_64 ||:) && \
    (zypper in -y qemu-uefi-aarch64 ||:) && \
    zypper clean

RUN mkdir -p /root/qemu
COPY kvm-mknod.sh /root/qemu/kvm-mknod.sh
COPY run_openqa_worker.sh /run_openqa_worker.sh
# ensure executability in case we loose file permissions, e.g. within open
# build service when downloading files into the container build project
RUN chmod +x /root/qemu/kvm-mknod.sh && \
    chmod a+x /run_openqa_worker.sh && \
    # set-up shared data and configuration
    rm -rf /etc/openqa/client.conf /etc/openqa/workers.ini && \
    mkdir -p /var/lib/openqa/share && \
    ln -s /data/conf/client.conf /etc/openqa/client.conf && \
    ln -s /data/conf/workers.ini /etc/openqa/workers.ini && \
    ln -s /data/factory /var/lib/openqa/share/factory && \
    ln -s /data/tests /var/lib/openqa/share/tests && \
    # set proper ownership and file modes
    chown -R _openqa-worker /usr/share/openqa/script/worker /var/lib/openqa/cache /var/lib/openqa/pool && \
    chmod -R ug+rw /usr/share/openqa/script/worker /var/lib/openqa/cache /var/lib/openqa/pool && \
    find /usr/share/openqa/script/worker /var/lib/openqa/cache /var/lib/openqa/pool -type d -exec chmod ug+x {} \;

ENTRYPOINT ["/run_openqa_worker.sh"]
