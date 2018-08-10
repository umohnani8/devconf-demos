FROM fedora
RUN dnf install -y --enablerepo=updates-testing buildah
ENTRYPOINT ["buildah"]