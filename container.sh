echo CREATING A NEW CONTAINER
echo
docker build . -t node-sass-test && \
docker create node-sass-test | \
xargs -I {} sh -c 'docker start {}; echo; echo "RUN THIS COMMAND:"; echo "docker exec -ti {} bash"'
