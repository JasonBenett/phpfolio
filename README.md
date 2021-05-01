# PHPFolio

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Introduction
This project provides a useful toolbox to build a portfolio website faster. It's a project created for the
[What The Fabrik](https://opensource.org/licenses/MIT) Community as a training.

## Contribute
### Docker & Docker Compose
This project is provided with a docker compose config to execute the tests, use composer and share the same dev
environment between all developers. Feel free to use/improve it!
The following examples are using `Make`, run `make help` to get more information.

#### Running the tests:
```shell
make docker-start
make test-php74
make test-php80
make docker-stop
```

or

```shell
make test
```