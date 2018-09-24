# Node-Sass Error in Docker

In this project I reproduce the following node-sass error:

```
Error: Missing binding /node_modules/node-sass/vendor/linux-x64-57/binding.node
Node Sass could not find a binding for your current environment: Linux 64-bit with Node.js 8.x
```

It occurs when node-sass cannot locate the binary for the current architecture. You may have experienced it when mounting node_modules into a container filesystem If the host is running a different operating system than the container, node-sass will not have the correct binding for the container architecture. For example, you might install node-sass on your macOS laptop for development, and mount your node_modules into a Linux container (using docker-compose [volumes](https://docs.docker.com/storage/volumes/)) at runtime.

## Reproduce

You will need the following:

* Docker
* NPM or Yarn

1. Run `yarn` or `npm i` to install the dependencies.
2. Run `./start.sh`. This will create a container that includes Node, as well as everything from the current filesystem. Furthermore, it will attempt to run `node /start.js` within the newly created container.

`start.js` is a simple JS file that attempts to include node-sass. When run from within the Docker container, it will result in the error: 

```
/node_modules/node-sass/lib/binding.js:15
      throw new Error(errors.missingBinary());
      ^

Error: Missing binding /node_modules/node-sass/vendor/linux-x64-57/binding.node
Node Sass could not find a binding for your current environment: Linux 64-bit with Node.js 8.x

Found bindings for the following environments:
  - OS X 64-bit with Node.js 8.x

This usually happens because your environment has changed since running `npm install`.
Run `npm rebuild node-sass --force` to build the binding for your current environment.
    at module.exports (/node_modules/node-sass/lib/binding.js:15:13)
    at Object.<anonymous> (/node_modules/node-sass/lib/index.js:14:35)
    at Module._compile (module.js:652:30)
    at Object.Module._extensions..js (module.js:663:10)
    at Module.load (module.js:565:32)
    at tryModuleLoad (module.js:505:12)
    at Function.Module._load (module.js:497:3)
    at Module.require (module.js:596:17)
    at require (internal/module.js:11:18)
    at Object.<anonymous> (/start.js:1:80)
```

Note that this will only work if your current operating system differs from the container operating system as defined in the Dockerfile!
