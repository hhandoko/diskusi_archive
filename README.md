`diskusi` is a team communication and discussion board inspired by [Slack], primarily a platform for experimentation for learning [Elixir Lang] and [Phoenix Framework].

Feel free to open any Pull Request (PR) or issues if you see things that can be improved or fixed.

## Prerequisites

### Develop and Compile Dependencies

The following binaries / libraries need to be installed in order to compile the web application:
 
  - [Elixir Lang] v1.2
  - [Phoenix Framework] v1.1.x 

### Services (Database) Dependencies

The following applications need to be installed in order to provision an Ubuntu guest VM (1 core, 1GB RAM) which will contain the necessary services: 

  * [Oracle VM VirtualBox] v5.x
  * [Vagrant] v1.8.x

Vagrant is used to provision the services, and the following will be setup automatically as part of the provisioning script:

  * [PostgreSQL] v9.5.x
  
*NOTE: PostgreSQL will be available on localhost on port 15432. It is setup as such (via port forwarding) to avoid conflict with existing PostgreSQL installation.*
  
The following Vagrant plugins are not mandatory, but help speed up box provisioning by caching common packages and update Guest Additions to the latest version automatically:

  * [vagrant-cachier]
  * [vagrant-vbguest]

## Setup

  - Configure the services with `vagrant up`
  - Install dependencies with `mix deps.get`
  - Install npm dependencies with `npm install`
  - Create database with `mix ecto.create`
  - Migrate database with `mix ecto.migrate`
  - Seed the database with `mix run priv/repo/seeds.exs`
  - Run tests with `mix test`
  - Start application with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Contributing

We follow the "[fork-and-pull]" Git workflow.

  1. Fork the repo on GitHub
  1. Commit changes to a branch in your fork
     - For new features, use `feature/` prefix followed by the feature name, e.g. `feature/feature_name`
     - For bug fixes, use `bug/` prefix followed by the short description, e.g. `bug/fix_this_bug`
  1. Rebase or merge from "upstream"
  1. Submit a PR "upstream" with your changes

Please read [CONTRIBUTING] for more details.

## License

`diskusi` is released under the MIT License. See the [LICENSE] file for further details.

[CONTRIBUTING]: CONTRIBUTING.md
[Elixir Lang]: http://elixir-lang.org
[fork-and-pull]: https://help.github.com/articles/using-pull-requests
[LICENSE]: LICENSE.txt
[Oracle VM VirtualBox]: https://www.virtualbox.org/
[Phoenix Framework]: http://www.phoenixframework.org
[PostgreSQL]: http://www.postgresql.org/download/
[Slack]: https://slack.com
[Vagrant]: https://www.vagrantup.com/
[vagrant-cachier]: https://github.com/fgrehm/vagrant-cachier
[vagrant-vbguest]: https://github.com/dotless-de/vagrant-vbguest