#############################
# build FOR LOCAL builder
#############################

FROM node:19-alpine As builder

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
