# Use a Debian Image
FROM debian:bullseye-slim

# Update and Upgrade Repo
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean && apt install curl -y

# Install Tailscale
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.gpg | sudo apt-key add -
RUN curl -fsSL https://pkgs.tailscale.com/stable/debian/bullseye.list | sudo tee /etc/apt/sources.list.d/tailscale.list
RUN apt update && apt install tailscale -y

# Install NordVPN
sh <(curl -sSf https://downloads.nordcdn.com/apps/linux/install.sh)

# Enviroment to describe the server from which you want to make an update
ENV TAILSCALEPARAM=""
ENV NORDVPNPARAM=""

# start Tailscale && NORDVPN
CMD ["tailscale up $TAILSCALEPARAM && nordvpn $NORDVPNPARAM"]
