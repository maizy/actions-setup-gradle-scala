Use [eskatos/gradle-command-action](https://github.com/marketplace/actions/gradle-command) & [action/cache](https://github.com/marketplace/actions/cache) instead.

Ex:
```
name: unit tests

on:
  push:
  schedule:
    - cron:  '0 10 */7 * *'

jobs:
  unittests:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - uses: actions/setup-java@v1
      with:
        java-version: 8.0.232
    - uses: actions/cache@v1
      with:
        path: ~/.gradle/caches
        key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle') }}
        restore-keys: |
          ${{ runner.os }}-gradle-
    - uses: eskatos/gradle-command-action@v1
      with:
        arguments: test --no-daemon
        gradle-version: 6.2.2
```

-----


# ~~Image for GitHub Actions with gradle & scala~~

Also could be used to build java project.

## Usage

_TODO_

## DockerHub tags

* `8u212-scala-2.13.1-gradle-5.6.3-v1`
* `8u212-scala-2.13.1-gradle-4.10.3-v1`
* `8u212-scala-2.12.10-gradle-5.6.3-v1`
* `8u212-scala-2.12.10-gradle-4.10.3-v1`

## GitHub Actions tags

_TODO_

## License

Apache License Version 2.0


