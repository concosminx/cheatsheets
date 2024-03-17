# Invoice Ninja

```bash
git clone https://github.com/invoiceninja/dockerfiles.git
mv dockerfiles invoiceninja
cd invoiceninja
cp env env.bak
cp docker-compose.yml docker-compose.yml.bak
# create a key
docker run --rm -it invoiceninja/invoiceninja php artisan key:generate --show
# permissions
chmod 755 docker/app/public
sudo chown -R 1500:1500 docker/app
# run the stack
docker compose up -d && docker compose logs -f
```