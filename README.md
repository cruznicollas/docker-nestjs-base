<p align="center">
  <a href="http://nestjs.com/" target="blank"><img src="https://nestjs.com/img/logo-small.svg" width="200" alt="Nest Logo" /></a>
</p>

# Descrição

Estrutura NestJs criada com Docker Multi-stage builds

Você terá um desempenho muito melhor na construção das imagens se habilitar o BuildKit, veja como fazer isso em
https://docs.docker.com/build/buildkit/#getting-started


## Instalação

```
$ git clone git@github.com:jacksonbicalho/docker-nestjs-base.git && cd docker-nestjs-base
```

```
$ cp exemple.env .env
```

### variáveis de ambiente
#### Configure as variáveis de ambiente no arquivo .env

- NODE_ENV=development | production

- SERVER_PORT= Default-[3000]


  Defina um nome para imagem que será criada automaticamente se você usar o docker-compose.

- IMAGE_TAG=dev

  Defina uma tag para versionar sua imagem

  Você pode verificar o padrão usado para nomear e images em https://docs.docker.com/engine/reference/commandline/images/#filtering

## Criando uma nova aplicação
A forma mais fácil de você criar uma nova aplicação é como no exemplo a seguir
```
NODE_ENV=builder docker-compose run --rm nest make new name="app-dev"
```
builder é o unico stage que não tem dependências locais. Então crie o app definindo NODE_ENV e depois build o container com o stage que quiser.


É importante você saber que a aplicação é criada usando os seguintes parâmetros:

- name *obrigatório
- --skip-git
- --package-manager [yarn]
- --directory=. (Será sempre usado o diretório raíz da aplicação)
- --skip-git
- --language TS

Você pode entender melhor sobre esses parâmetros em
https://docs.nestjs.com/cli/usages#nest-new


## Instale as dependências
```
$ docker-compose run --rm nest make setup
```
  #### Voce também pode usar o comando
 ```
  $ docker-compose run --rm nest make setup-check
  ```

  Referência:

  https://classic.yarnpkg.com/lang/en/docs/cli/install/#toc-yarn-install-check-files


## Apagando a aplicação
```
$ docker-compose run --rm nest make destroy
```


