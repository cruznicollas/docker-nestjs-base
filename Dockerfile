#############################
# build FOR LOCAL builder
#############################

FROM node:19-alpine As builder
# Set NODE_ENV environment variable
ENV NODE_ENV ${NODE_ENV:-production}
ENV NODE_ENV ${NODE_ENV}

RUN apk --no-cache update \
    && apk add --no-cache --virtual \
        builds-deps \
        build-base \
        python3 \
        bash \
        bash-completion \
        make \
        curl \
        git \
	&& rm -rf /var/cache/apk/* \
	&& curl -sfL RUN curl -sf https://gobinaries.com/tj/node-prune | bash -s -- -b /usr/local/bin/

ENV WORK_DIR ${WORK_DIR:-/app}
ENV WORK_DIR ${WORK_DIR}
WORKDIR ${WORK_DIR}
RUN yarn global add @nestjs/cli

COPY . .

CMD [ "node" ]


FROM builder as development
# Set NODE_ENV environment development
# Set NODE_ENV environment variable
ENV NODE_ENV ${NODE_ENV:-development}
ENV NODE_ENV ${NODE_ENV}

# You MUST specify files/directories you don't want on your final image like .env file, dist, etc. The file .dockerignore at this folder is a good starting point.
COPY . .
RUN ls -l

# install required depedencies for compile related TypeScript/NestJS code
RUN yarn

# lint and formatting configs are commented out
# uncomment if you want to add them into the build process
RUN yarn build

RUN ls /usr/local/bin/

# run node prune
RUN /usr/local/bin/node-prune

# ARG SERVER_PORT
EXPOSE ${SERVER_PORT}
CMD ["yarn", "start:dev"]


FROM node:19-alpine  as production
# Set NODE_ENV environment production
ENV NODE_ENV production
RUN echo ${NODE_ENV}

# get package.json from base stage
COPY --from=builder /app/package.json ./
# get the dist back
COPY --from=development /app/dist/ ./dist/
# get the node_modules from base stage
COPY --from=builder /app/node_modules/ ./node_modules/

# expose application port
ENV SERVER_PORT ${SERVER_PORT:-'3000'}
ENV SERVER_PORT ${SERVER_PORT}
EXPOSE ${SERVER_PORT}
# start
CMD ["yarn", "start:prod"]


