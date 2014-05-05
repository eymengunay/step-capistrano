step-capistrano
=============

A wercker step to execute a `capistrano` task. The step has support for multiple stages and tasks.

More information:
- http://capistranorb.com/

# Included extensions

* [composer](https://github.com/capistrano/composer)

# Options

* `tasks` (optional, default: `deploy`) The tasks which will be run.
* `stage` (optional, default: `production`) The stage which will be used for the deployment.

# Basic example

``` yaml
deploy:
  steps:
    - eymengunay/capistrano@0.0.2
```

# Changing default task or stage

You can change the default task to be executed by setting the `WERCKER_CAPISTRANO_TASKS` environment variable.
Instead for stage setting you can use `WERCKER_CAPISTRANO_STAGE` environment variable. 


# License

The MIT License (MIT)