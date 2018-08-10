read -p "DevConf Demos!!!!!!!"
echo ""

# CRI-O read-only mode
read -p "CRI-O read-only mode"
echo ""

read -p "--> sudo vi /etc/crio/crio.conf"
sudo vi /etc/crio/crio.conf
echo ""

read -p "--> sudo systemctl restart crio"
sudo systemctl restart crio
echo ""

read -p "--> sudo crictl runp sandbox_config.json"
POD=$(sudo crictl runp sandbox_config.json)
echo ""

read -p "--> sudo crictl create $POD container_demo.json sandbox_config.json"
CTR=$(sudo crictl create $POD container_demo.json sandbox_config.json)
echo ""

read -p "--> sudo crictl start $CTR"
sudo crictl start $CTR
echo ""

read -p "--> sudo crictl exec --sync $CTR dnf install buildah"
sudo crictl exec --sync $CTR dnf install buildah
echo ""

read -p "--> cleanup"
sudo crictl stopp $POD
sudo crictl rmp $POD
echo ""

# Modifying capabilities in CRI-O
read -p "Modifying capabilities in CRI-O"
echo ""

read -p "--> sudo vim /etc/crio/crio.conf"
sudo vim /etc/crio/crio.conf
echo ""

read -p "--> sudo systemctl restart crio"
sudo systemctl restart crio
echo ""

read -p "--> sudo crictl runp sandbox_config.json"
POD=$(sudo crictl runp sandbox_config.json)
echo ""

read -p "--> sudo crictl create $POD container_demo.json sandbox_config.json"
CTR=$(sudo crictl create $POD container_demo.json sandbox_config.json)
echo ""

read -p "--> sudo crictl start $CTR"
sudo crictl start $CTR
echo ""

read -p "--> sudo crictl exec --sync $CTR capsh --print"
sudo crictl exec --sync $CTR capsh --print
echo ""

read -p "--> sudo cat /run/containers/storage/overlay-containers/$POD/userdata/config.json"
sudo cat /run/containers/storage/overlay-containers/$POD/userdata/config.json
echo ""

read -p "--> cleanup"
sudo crictl stopp $POD
sudo crictl rmp $POD
echo ""

# Buildah from scratch - minimal images
read -p "Buildah from scratch - building minimal images"
echo ""

read -p "--> sudo buildah from scratch"
ctr=$(sudo buildah from scratch)
echo $ctr
echo ""

read -p "--> sudo buildah mount $ctr"
mnt=$(sudo buildah mount $ctr)
echo $mnt
echo ""

read -p "--> sudo dnf install -y --installroot=$mnt mongoose --releasever=27 --disablerepo=* --enablerepo=fedora --enablerepo=updates"
sudo dnf install -y --installroot=$mnt mongoose --releasever=27 --disablerepo=* --enablerepo=fedora --enablerepo=updates
echo ""

read -p "--> sudo dnf clean all --installroot=$mnt"
sudo dnf clean all --installroot=$mnt
echo ""

read -p "--> sudo buildah unmount $ctr"
sudo buildah unmount $ctr
echo ""

read -p "--> sudo buildah config --entrypoint=/usr/bin/mongoose $ctr"
sudo buildah config --entrypoint=/usr/bin/mongoose $ctr
echo ""

read -p "--> sudo buildah commit $ctr my-mongoose"
sudo buildah commit $ctr my-mongoose
echo ""

read -p "--> sudo podman run my-mongoose ping"
sudo podman run my-mongoose ping
echo ""

read -p "--> sudo podman run my-mongoose python"
sudo podman run my-mongoose python
echo ""

read -p "--> cleanup"
sudo buildah rm -a
sudo podman rm -a -f
echo ""

# Buildah inside a container
read -p "Buildah inside a container"
echo ""

# Already built an image with buildah installed in it
# and made buildah the entrypoint
read -p "--> cat Dockerfile"
cat Dockerfile
echo ""

read -p "--> sudo podman run -v $PWD/myvol:/myvol:Z -v /var/lib/mycontainer:/var/lib/containers:Z buildah-ctr --storage-driver vfs bud -t myimage --isolation chroot /myvol"
sudo podman run -v $PWD/myvol:/myvol:Z -v /var/lib/mycontainer:/var/lib/containers:Z buildah-ctr --storage-driver vfs bud -t myimage --isolation chroot /myvol
echo ""

read -p "--> sudo podman run -v $PWD/myvol:/myvol:Z -v /var/lib/mycontainer:/var/lib/containers:Z buildah-ctr --storage-driver vfs bud --isolation chroot /myvol"
sudo podman run -v $PWD/myvol:/myvol:Z -v /var/lib/mycontainer:/var/lib/containers:Z buildah-ctr --storage-driver vfs bud --isolation chroot /myvol
echo ""

read -p "--> cleanup"
sudo podman rm -a -f
echo ""

# Rootless podman
read -p "Podman as rootless"
echo ""

read -p "--> podman pull alpine"
podman pull alpine
echo ""

read -p "--> podman images"
podman images
echo ""

read -p "--> podman run alpine ls"
podman run --rm alpine ls
echo ""

# Podman Fork/Exec model
read -p "Podman Fork/Exec Model"
echo ""

read -p "--> sudo podman run -ti fedora bash -c \"cat /proc/self/loginuid; echo\""
sudo podman run -ti fedora bash -c "cat /proc/self/loginuid; echo"
echo ""

read -p "--> sudo docker run -ti fedora bash -c \"cat /proc/self/loginuid; echo\""
sudo docker run -ti fedora bash -c "cat /proc/self/loginuid; echo"
echo ""

read -p "--> cat /proc/self/loginuid"
cat /proc/self/loginuid
echo ""

# Podman user namespace - need to get this working
# read -p "Podman User Namespace Support"
# echo ""

# read -p "--> cat /proc/self/uid_map"
# cat /proc/self/uid_map
# echo ""

# read -p "--> sudo podman run --uidmap=0:100000:70000 fedora cat /proc/self/uid_map"
# sudo podman run --rm --uidmap=0:100000:70000 fedora cat /proc/self/uid_map
# echo ""

# read -p "--> podman run --uidmap=0:11111:70000 fedora sh -c 'id - u; sleep 10'"
# sudo podman run --rm --uidmap=0:10000:70000 --gidmap=0:200000:7000 fedora sh -c 'id - u; sleep 10'
# echo ""

# Podman top commands
read -p "Podman top features"
echo ""

read -p "--> sudo podman run -d fedora sleep 1000"
sudo podman run -d fedora sleep 1000
echo ""

read -p "--> sudo podman top --latest"
sudo podman top --latest
echo ""

read -p "--> sudo podman top --latest label"
sudo podman top --latest label
echo ""

read -p "--> sudo podman top --latest seccomp"
sudo podman top --latest seccomp
echo ""

read -p "--> sudo podman run -d --security-opt seccomp=unconfined fedora sleep 1000"
sudo podman run -d --security-opt seccomp=unconfined fedora sleep 1000
echo ""

read -p "--> sudo podman top --latest seccomp"
sudo podman top --latest seccomp
echo ""

read -p "--> sudo podman top --latest pid hpid"
sudo podman top --latest pid hpid
echo ""

read -p "--> sudo podman top --latest capbnd"
sudo podman top --latest capbnd
echo ""

read -p "--> sudo podman top --latest capeff"
sudo podman top --latest capeff
echo ""

read -p "--> sudo podman run -d --user 1 sleep 1000"
sudo podman run -d --user 1 fedora sleep 1000
echo ""

# shows you have processes with no capabilities, but with sudo you can become root and get the effective capabilities
read -p "--> sudo podman top --latest capbnd capeff"
sudo podman top --latest capbnd capeff
echo ""

read -p "--> sudo podman run -d --user 1 --cap-drop all fedora sleep 1000"
sudo podman run -d --user 1 --cap-drop all fedora sleep 1000
echo ""

read -p "--> sudo podman top --latest capbnd capeff"
sudo podman top --latest capbnd capeff
echo ""

# Skopeo inspect a remote image
read -p "Inspect a remote image using skopeo"
echo ""

read -p "--> skopeo inspect docker://docker.io/fedora"
skopeo inspect docker://docker.io/fedora
echo ""

read -p "End of Demo"
echo "Thank you!"
