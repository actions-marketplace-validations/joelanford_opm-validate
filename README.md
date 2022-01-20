# opm-validate

Validate an operator catalog with `opm validate` from [operator-framework/operator-registry](https://github.com/operator-framework/operator-registry).

For more information about the Operator Lifecycle Manager and its related projects, see the [documentation](https://olm.operatorframework.io/)

## GitHub Action

### Inputs

#### `version`

Version of `opm` to use (default: `latest`)

#### `catalog`

The catalog to validate (must be a catalog container image or directory; required)

### Outputs

_(none)_

### Example usage

```yaml
name: opm-validate
on: [ pull_request ]
jobs:
  opm-validate-image:
    runs-on: ubuntu-latest
    steps:
    - uses: joelanford/opm-validate
      with:
        catalog: quay.io/joelanford/example-operator-index:0.2.0
  opm-validate-directory:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: joelanford/opm-validate
      with:
        catalog: ./path/to/catalog/dir/in/repo
```
```
