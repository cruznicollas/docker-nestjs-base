<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

## Instalação

```
$ git clone git@github.com:jacksonbicalho/docker-nestjs-base.git && cd docker-nestjs-base
```

```
$ cp exemple.env .env
```

### variáveis de ambiente
#### Configure as variáveis de ambiente no arquivo .env

- NODE_ENV=development

- TARGET=builder
  - Mantenha builder para possibilitar que você crie uma nova aplicação pelo próprio -container

- SERVER_PORT=3000

- IMAGE_NAME=jacksonbicalho/docker-nestjs-base
  - Defina um nome para imagem que será criada automaticamente se você usar o docker-compose

- IMAGE_TAG=dev
  - Defina uma tag para versionar sua imagem

## Cria uma nova aplicação

```
$ docker-compose run --rm nest make new name=sua-app
```

## Instale as dependências
```
$ docker-compose run --rm nest make setup
```
- Você tem a opção de instalar com a opção do yarn:
  - https://classic.yarnpkg.com/lang/en/docs/cli/install/#toc-yarn-install-check-files
  ```
  yarn install --check-files
  ```
  Para isso, execute
  ```
  $ docker-compose run --rm nest make setup-check
  ```

## Apagando a aplicação
```
$ docker-compose run --rm nest make destroy
```


