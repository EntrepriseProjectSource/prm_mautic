
INSTALL = docker-compose exec engine-mao bash -c 'composer install'
CLEAN_RIGHT = docker-compose exec engine-mao bash -c 'chmod -R 777 var/cache var/logs var/sessions'
BD_INSTALL = docker-compose exec engine-mao bash -c 'bin/console doctrine:database:create'
BD_SCHEMA_UPDATE = docker-compose exec engine-mao bash -c 'bin/console doctrine:schema:update --dump-sql -f'

install:
	${INSTALL}
	${CLEAN_RIGHT}

bd-install:
	${BD_SCHEMA_UPDATE}

clean:
	rm -rf var/cache/dev
	docker-compose exec engine-mao bash -c 'bin/console cache:warmup'

update:
	docker-compose exec engine-mao bash -c 'composer update'

db-diff:
	docker-compose exec engine-mao bash -c 'bin/console doctrine:migration:diff'

db-migrate:
	docker-compose exec engine-mao bash -c 'bin/console doctrine:migration:migrate  --no-interaction'

db-rollback:
	docker-compose exec engine-mao bash -c 'bin/console doctrine:migration:migrate  --no-interaction $(version)'
