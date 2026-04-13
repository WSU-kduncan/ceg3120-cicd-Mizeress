#! /bin/bash
# Use SSH to call the update script on the servers
# Remember to manually add your PK to the proxy server
servers=("webserv1" "webserv2" "webserv3") # Replace with your SSH config names

for server in "${servers[@]}"; do
    echo "Updating $server..."
    ssh "$server" "/usr/local/bin/DockerSwap -i malliasm/portfolio -c portfolio"
done