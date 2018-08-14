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

read -p "--> sudo crictl exec -i -t $CTR sh"
sudo crictl exec -i -t $CTR sh
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

read -p "--> cp index.html $mnt"
sudo cp index.html $mnt
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

#read -p "--> sudo buildah from my-mongoose"
#ctr=$(sudo buildah from my-mongoose)
#echo $ctr
#echo ""

read -p "--> sudo podman run -td my-mongoose"
contID=$(sudo podman run -td my-mongoose)
echo ""

read -p "--> sudo podman inspect $contID"
sudo podman inspect $contID
ipAddress=$(sudo podman inspect $contID | awk -F  ":" '/IPAddress\"/ {print $2}' | sed 's/"//g' | sed 's/,//g')
echo ""

read -p "--> curl $ipAddress:8080"
curl $ipAddress:8080
echo ""

read -p "--> cleanup"
sudo crictl stopp my-mongoose
sudo crictl rmp my-mongoose
echo ""

# Buildah inside a container
read -p "Buildah inside a container"
echo ""

read -p "--> sudo buildah from fedora"
ctr=$(sudo buildah from fedora)
echo $ctr
echo ""

read -p "--> sudo buildah run --volume $PWD/myvol:/myvol:z $ctr sh"
sudo buildah run --volume $PWD/myvol:/myvol:z $ctr sh
echo ""

read -p "--> cleanup"
sudo crictl stopp $ctr
sudo crictl rmp $ctr
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

# read -p "--> sudo podman run --uidmap=0:10000:7000 --gidmap=0:200000:7000 fedora cat /proc/self/uid_map"
# sudo podman run --rm --uidmap=0:10000:7000 --gidmap=0:200000:7000 fedora cat /proc/self/uid_map
# echo ""

# read -p "--> podman run --uidmap=0:11111:7000 --gidmap=0:200000:7000 fedora sh -c 'id - u; sleep 10'"
# sudo podman run --rm --uidmap=0:10000:7000 --gidmap=0:200000:7000 fedora sh -c 'id - u; sleep 10'
# echo ""

# Rootless podman
read -p "Podman as rootless"
echo ""

read -p "--> podman pull alpine"
podman pull alpine
echo ""

read -p "--> podman images"
podman images
echo ""

read -p "--> podman cgroup-manager cgroupfs run alpine ls"
podman --cgroup-manager cgroupfs run --rm alpine ls
echo ""

# Skopeo inspect a remote image
read -p "Inspect a remote image using skopeo"
echo ""

read -p "--> skopeo inspect docker://quay.io/umohnani8/alpine"
skopeo inspect docker://quay.io/umohnani8/alpine
echo ""

read -p "End of Demo"
echo "Thank you!"
