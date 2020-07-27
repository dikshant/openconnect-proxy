# Openconnect + TinyProxy

# Requirements

You can set env vars using the docker run option `-e`:

	docker run … -e OPENCONNECT_URL=vpn.gateway.com/example \
	-e OPENCONNECT_OPTIONS='<Openconnect Options>' \
	-e OPENCONNECT_USER=<Username> …


If you don't want to set the environment variables on the command line
set the environment variables in a `.env` file:

	OPENCONNECT_URL=<Gateway URL>
	OPENCONNECT_USER=<Username>
	OPENCONNECT_PASSWORD=<Password>
	OPENCONNECT_OPTIONS=--authgroup <VPN Group> \
		--servercert <VPN Server Certificate> --protocol=<Protocol> \
		--reconnect-timeout 86400

_Don't use quotes around the values!_

See the [openconnect documentation](https://www.infradead.org/openconnect/manual.html) for available options. 

Either set the password in the `.env` file or leave the variable `OPENCONNECT_PASSWORD` unset, so you get prompted when starting up the container.

# Run container

To start the container in background run:

	docker run -it -d --privileged --env-file=.env \
	  -p 8888:8888 --name=openconnect openconnect:latest

The proxy is listening on 8888 and can accept both HTTP/HTTPS traffic. SSH can also be tunneled over it by setting a ProxyCommand in your ssh config:


```
Host somehost
    User username
    HostName vm.example.dev
    ProxyCommand /usr/bin/nc -X connect -x 127.0.0.1:1080 %h %p
```

# Build

You can build the container yourself with

	docker build -f build/Dockerfile -t openconnect ./build



