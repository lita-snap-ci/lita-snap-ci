# lita-snap-ci

Lita handler, to display the snap-ci pipelines of a project.

| *Service* | Status |
| :---: | :---: |
| Snap-ci | [![Build Status](https://snap-ci.com/groteck/lita-snap-ci/branch/master/build_image)](https://snap-ci.com/groteck/lita-snap-ci/branch/master) |
| CodeClimate | [![Code Climate](https://codeclimate.com/github/groteck/lita-snap-ci/badges/gpa.svg)](https://codeclimate.com/github/groteck/lita-snap-ci) |
| Test Coverage | [![Test Coverage](https://codeclimate.com/github/groteck/lita-snap-ci/badges/coverage.svg)](https://codeclimate.com/github/groteck/lita-snap-ci/coverage) |

## Installation

Add lita-snap-ci to your Lita instance's Gemfile:

``` ruby
gem "lita-snap-ci"
```

## Configuration

Information that you need:

* [api-key from Snap-ci](https://snap-ci.com/settings/api_key)
* snap-ci username
* projects info

Configure your `lita-config.rb`.

Example:

```
  config.handlers.snap_ci.user = "snapUser"
  config.handlers.snap_ci.token = "Snap-ci-api-key"
  config.handlers.snap_ci.projects = [
    {
      owner: 'oneorg',
      repository: 'api',
      branches: ['development', 'staging', 'master']
    },{
      owner: 'oneorg',
      repository: 'front',
      branches: ['staging', 'master']
    },{
      owner: 'otherorg',
      repository: 'websites',
      branches: ['develop' , 'master']
    }
  ]
```

## Usage

### Display the status of your repositories.

Chat input:

`snap-ci report`

Chat output:

```
Project: otherorg/websites:
  develop: failed (Test: failed)
  master: failed (Test: failed)

Project: oneorg/front:
  staging: passed (TEST: passed, deploy_staging: passed)
  master: passed (TEST: passed, deploy_prod: passed)

Project: oneorg/api:
  development: passed (Integration: passed, Brakeman: passed)
  staging: passed (Integration: passed, deploy_staging: passed)
  master: passed (FastFeedback: passed, Integration: passed, deploy_prod: unknown)
```

### Display the status of one repository.

Chat input:

`snap-ci project api` or `snap-ci project oneorg/api`

Chat output:

```
Project: oneorg/api:
  development: passed (Integration: passed, Brakeman: passed)
  staging: passed (Integration: passed, deploy_staging: passed)
  master: passed (FastFeedback: passed, Integration: passed, deploy_prod: unknown)
```

## License

lita-snap-ci is released under the [MIT License](http://www.opensource.org/licenses/MIT).
