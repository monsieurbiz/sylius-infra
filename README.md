# Sylius Infra Project

A Sylius infra using the Symfony binary.

If you want to know more about the Symfony binary, you can this read this [fantastic article from Jolicode](https://jolicode.com/blog/my-local-server-with-the-symfony-binary)

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
make add-symfony-bin
sudo cp ${HOME}/.symfony/bin/symfony /usr/local/bin/
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
