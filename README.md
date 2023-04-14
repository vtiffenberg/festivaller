# Festivaller

## Docker development environment

Install docker and docker-compose.

Run:

```
$ ./dev-setup.sh
$ docker-compose up
```

Open `http://localhost:3000`.

### Rails console

`$ docker-compose exec app rails console`

### Running specs

To run specs `$ docker-compose exec app rspec`.
