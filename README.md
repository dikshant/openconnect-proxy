# Openconnect + sslh

# Requirements

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

# Run container in foreground

To start the container in foreground run:

	docker run -it --rm --privileged --env-file=.env \
	  -p 7777:7777 --name=openconnect openconnect:latest

The proxy is listening on 7777 and can accept both HTTP/HTTPS proxy traffic and SSH traffic over the same port (7777) and multiplex it to the instance of SSH daemon and tiny proxy running inside the container depending on the type of traffic.

Without using a `.env` file set the environment variables on the command line with the docker run option `-e`:

	docker run … -e OPENCONNECT_URL=vpn.gateway.com/example \
	-e OPENCONNECT_OPTIONS='<Openconnect Options>' \
	-e OPENCONNECT_USER=<Username> …

# Build

You can build the container yourself with

	docker build -f build/Dockerfile -t openconnect ./build



