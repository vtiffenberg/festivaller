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

### Restore backups

```
$ docker-compose exec app rake db:drop db:create
$ docker-compose exec db bash
   # pg_restore --no-privileges --no-owner -U postgres -d festivaller_development -1 /src/backupDBfestivaller
```

Note: If the `backup.sql` is stored in this project folder, then `/src/backup.sql` is the path to use.

## Release

```
$ docker build . -t bcardiff/festivaller:<tag>
$ docker push bcardiff/festivaller:<tag>
```
