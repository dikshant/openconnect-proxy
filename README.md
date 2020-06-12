# openconnect + microsocks

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

Optionally set a multi factor authentication code:

	OPENCONNECT_MFA_CODE=<Multi factor authentication code>

# Run container in foreground

To start the container in foreground run:

	docker run -it --rm --privileged --env-file=.env \
	  -p 8888:8888 -p 8889:8889 openconnect:latest

The proxies are listening on ports 8888 (http/https) and 8889 (socks). Either use `--net host` or `-p <local port>:8888 -p <local port>:8889` to make the proxy ports available on the host.

Without using a `.env` file set the environment variables on the command line with the docker run option `-e`:

	docker run … -e OPENCONNECT_URL=vpn.gateway.com/example \
	-e OPENCONNECT_OPTIONS='<Openconnect Options>' \
	-e OPENCONNECT_USER=<Username> …

# Run container in background

To start the container in daemon mode (background) set the `-d` option:

	docker run -d -it --rm …

In daemon mode you can view the stderr log with `docker logs`:

	docker logs `docker ps|grep "openconnect"|awk -F' ' '{print $1}'`

Set the environment variables for _openconnect_ in the `.env` file again (or specify another file) and 
map the configured ports in the container to your local ports if you want to access the VPN 
on the host too when running your containers. Otherwise only the docker containers in the same
network have access to the proxy ports.

# ssh through the proxy

You need nc (netcat), corkscrew or something similar to make this work.

Unfortunately some git clients (e.g. Gitkraken) don't use the settings from ssh config
and you can't pull/push from a repository that's reachable (DNS resolution) only through VPN.

## nc (netcat, ncat)

Set a `ProxyCommand` in your `~/.ssh/config` file like

	Host <hostname>
		ProxyCommand            nc -x 127.0.0.1:8889 %h %p

or (depending on your ncat version)

	Host <hostname>
		ProxyCommand            ncat --proxy 127.0.0.1:8889 --proxy-type socks5 %h %p

and your connection will be passed through the proxy.
The above example is for using git with ssh keys.

## corkscrew 

An alternative is _corkscrew_ (e.g. install with `brew install corkscrew` on mac OS)

	Host <hostname>
		ProxyCommand            corkscrew 127.0.0.1 8888 %h %p

# Build

You can build the container yourself with

	docker build -f build/Dockerfile -t openconnect ./build



