step-capistrano
=============

A wercker step to execute a `capistrano` task. The step has support for multiple stages and tasks.

More information:
- http://capistranorb.com/

# Options

* `tasks` (optional, default: `deploy`) The tasks which will be run.
* `stage` (optional) The stage which will be used for the deployment. Requires [multistage extension](http://capistrano.org/cookbook/using-the-multistage-extension.html).

# Example

``` yaml
deploy:
  steps:
    - eymengunay/capistrano@0.0.1
```

# License

The MIT License (MIT)