# Node-Sass Bug

> Node Sass could not find a binding for your current environment

This reproduces a bug where, when running inside a container, node-sass cannot find the correct binding for the container architecture. The bug is especially problematic when the Dockerfile adds node_modules directly to the container filesystem (as it does here), or when node_modules are being mounted into the filesystem with docker-compose.

## To Reproduce

1. Run `./container.sh`. This will create a container and tell you how to start a shell within it.
2. Start a shell within the container. 
3. Within the container, run `start.sh`. This is a simple JS file that attempts to include node-sass. It will result in the error: "Node Sass could not find a binding for your current environment".

## Proposed Fix
