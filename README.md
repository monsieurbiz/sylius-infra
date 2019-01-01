# Sylius Infra Project

## Help

Use `make` or `make help` to get the list of available commands.

## Installation

```
git clone git@github.com:monsieurbiz/sylius-infra.git
cd sylius-infra
rm -rf .git
git init
git add .
git commit -m "Init project with Sylius infra"
make coffee
```

Enjoy ☕️

You'll find:

- Your website at `http://localhost`.
- Admin panel at `http://localhost/admin` (Login : `sylius`, password: `sylius`).
- Your mails at `http://localhost:1080`.

## Setup with `docker-sync`

### Install `docker-sync`

https://github.com/EugenMayer/docker-sync/wiki/1.-Installation

### Up containers

`make up SYNC=1`

### Down containers

`make down SYNC=1`

### Improvements ?

On a fresh Sylius setup, you will see no differences. But when you add your custom bundles and plugins, the platform can be slow on Mac OS.
To avoid that docker-sync help you to improve the speed of your customized Sylius platform.

## Change Sylius folder dir

You can to change the target dir (`apps/sylius` by default):

```
make SYLIUS_FOLDER=foo coffee
```

This command will create your Sylius shop in `apps/foo`.

You should also:

- Change the `infra/dev/php/files/vhost.conf` to define your own entry point.
- Change the `infra/dev/docker-compose.yml` if you want to add some ports to `php` container.
- Run `make build up` command to update the stack.
