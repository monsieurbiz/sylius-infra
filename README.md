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

- Your website at `http://sylius-store.wip`.
- Admin panel at `http://sylius-store.wip/admin` (Login : `sylius`, password: `sylius`).
- Your mails at `http://localhost:1080`.

### Up containers

`make up`

### Down containers

`make down`

## Change Sylius folder dir

You can to change the target dir (`apps/sylius` by default):

```
make SYLIUS_FOLDER=foo coffee
```

This command will create your Sylius shop in `apps/foo`.
