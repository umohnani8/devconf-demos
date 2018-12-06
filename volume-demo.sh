read -p "Podman volume Demos!"
echo ""

read -p "The podman volume subcommands are used to create named volumes, which are stored under /var/lib/containers/storage/volumes."
echo ""

# Create volumes
read -p "Create a volume without giving it a name. Podman will generate a unique name for it instead."
echo ""

read -p "--> sudo podman volume create"
sudo podman volume create
echo ""

read -p "Create a volume with a name."
echo ""

read -p "--> sudo podman volume create myvol"
sudo podman volume create myvol
echo ""

read -p "Create a volume with labels."
echo ""

read -p "--> sudo podman volume create --label=foo labelvol"
sudo podman volume create --label=foo labelvol
echo ""

# List volumes
read -p "List all available volumes."
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

read -p "List all available volumes in JSON format."
echo ""

read -p "--> sudo podman volume ls --format json"
sudo podman volume ls --format json
echo ""

read -p "List all available volumes using a Go template."
echo ""

read -p "--> sudo podman volume ls --format \"table {{.Name}} {{.MountPoint}}\""
sudo podman volume ls --format "table {{.Name}} {{.MountPoint}}"
echo ""

read -p "Filter list of volumes based on label. Can be filtered based on name, driver, scope, label, and opt"
echo ""

read -p "--> sudo podman volume ls --filter label=foo"
sudo podman volume ls --filter label=foo
echo ""

# Inspect volumes
read -p "Inspect a named volume."
echo ""

read -p "--> sudo podman volume inspect labelvol"
sudo podman volume inspect labelvol
echo ""

read -p "Inspect a named volume using Go template as format."
echo ""

read -p "--> sudo podman volume inspect --format {{.MountPoint}} labelvol"
sudo podman volume inspect --format {{.MountPoint}} labelvol
echo ""

read -p "Can inspect all volumes with --all flag."
echo ""

read -p "--> sudo podman volume inspect --all"
sudo podman volume inspect --all
echo ""

# Remove volumes
read -p "Can remove one or more named volumes."
echo ""

read -p "--> sudo podman volume rm myvol"
sudo podman volume rm myvol
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

read -p "Can remove all named volumes using --all flag."
echo ""

read -p "--> sudo podman volume rm --all"
sudo podman volume rm --all
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

# Create a container that creates and uses a named volume called foo
read -p "Can create a named volume when creating/running a container."
echo ""

read -p "--> sudo podman create -name ctr-with-vol --volume foo:/foo alpine ls"
sudo podman create --volume foo:/foo alpine ls
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

# Try to remove the volume being used by the container
read -p "Now, if we try to remove volume foo, we will get an error that it is being used by ctr-with-vol."
echo ""

read -p "--> sudo podman volume rm foo"
sudo podman volume rm foo
echo ""

read -p "We can force remove volume foo using the --force flag."
echo ""

read -p "--> sudo podman volume rm -f foo"
sudo podman volume rm -f foo
echo ""

# Create container using named volumes so we can show how podman volume prune only removes unused volumes
read -p "Creating a named volume called myvol"
echo ""

read -p "--> sudo podman volume create myvol"
sudo podman volume create myvol
echo ""

read -p "Can create/run a container using an existing named volume."
echo ""

read -p "--> sudo podman create -name myctr --volume myvol:/myvol alpine ls"
sudo podman create --volume myvol:/myvol alpine ls
echo ""

read -p "Creating another named volume called anothervol."
echo ""

read -p "--> sudo podman volume create anothervol."
sudo podman volume create anothervol
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

read -p "We can remove all unused volumes using the podman volume prune command."
echo ""

read -p "--> sudo podman volume prune"
sudo podman volume prune
echo ""

read -p "We still have myvol as that is being used by container myctr"
echo ""

read -p "--> sudo podman volume ls"
sudo podman volume ls
echo ""

read -p "To bypass the confirmation prompt give by podman volume prune, just set the --force flag."
echo ""

read -p "--> sudo podman volume prune --force"
sudo podman volume prune --force
echo ""

# Show that the podman volume commands work in rootless mode as well
read -p "We can run podman volume in rootless mode as well. Notice that the following commands will not be using sudo."
echo ""

read -p "--> podman volume create foo"
podman volume create foo
echo ""

read -p "--> podman volume ls"
podman volume ls
echo ""

read -p "--> podman volume inspect foo"
podman volume inspect foo
echo ""

read -p "--> podman volume rm foo"
podman volume rm foo
echo ""

read -p "End of Demo"
echo "Thank you!"
