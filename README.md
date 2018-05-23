# Node-Sass Docker Bug

> Node Sass could not find a binding for your current environment

This reproduces a bug where, when running inside a container, node-sass cannot find the correct binding for the container architecture. The bug is especially problematic when the Dockerfile adds node_modules directly to the container filesystem (as it does here), or when node_modules are being mounted into the filesystem with docker-compose. It is caused by the fact that you are attempting to use the node-sass binary for macOS within a Linux environment.

## Requirements

* Docker
* NPM or Yarn

## Repro Steps

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

Note that it found bindings for macOS!

## Proposed Fix

WIP
