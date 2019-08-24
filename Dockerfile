FROM ktakase00/rubypg-learn:uv-201907
ARG APP_NAME=web
RUN mkdir -p ${HOME}/repo/apps
ADD --chown=ubuntu:ubuntu apps/web /home/ubuntu/repo/apps/web
ADD --chown=ubuntu:ubuntu ./.pgpass /home/ubuntu
RUN mkdir ${HOME}/cabin && \
  cd ${HOME}/repo/apps/${APP_NAME} && \
  ${HOME}/.anyenv/envs/rbenv/shims/bundle install --path=${HOME}/cabin/${APP_NAME}/vendor/bundler && \
  yarn install --modules-folder ${HOME}/cabin/web/node_modules && \
  cp -pR ${HOME}/repo/apps/${APP_NAME}/.bundle ${HOME}/cabin/${APP_NAME} && \
  cp -p ${HOME}/repo/apps/${APP_NAME}/Gemfile.lock ${HOME}/cabin/${APP_NAME} && \
  cp -p ${HOME}/repo/apps/${APP_NAME}/yarn.lock ${HOME}/cabin/${APP_NAME} && \
  cd ${HOME} && \
  chmod 600 .pgpass && \
  rm -Rf repo
