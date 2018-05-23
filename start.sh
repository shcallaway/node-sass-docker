docker build . -t node-sass-docker-bug
docker create node-sass-docker-bug | \
xargs -I {} sh -c 'docker start {}; docker exec {} node /start.js'
