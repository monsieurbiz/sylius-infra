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
