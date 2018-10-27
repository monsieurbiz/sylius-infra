## Help

Use `make` or `make help` to get the list of available commands.

## Installation

```
git clone git@github.com:monsieurbiz/sylius-infra.git
cd sylius-infra
make coffee
```

Enjoy ☕️

You'll find :
- Your website at `http://localhost`
- Admin panel at `http://localhost/admin` (Login : sylius, Password: sylius)
- Your mails at `http://localhost:1080`

## Change Sylius folder dir

You can to change the target dir (apps/sylius by default) : 
```
make SYLIUS_FOLDER=foo coffee
```
This command will create your Sylius shop in `apps/foo`

You have also to :
- Change the `infra/dev/php/files/vhost.conf` to define your entry point.
- Change the `infra/dev/docker-compose.yml` if you want to add some ports to `php` container
- run `make build up` command
