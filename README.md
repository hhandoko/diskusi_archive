`diskusi` is a team communication and discussion board inspired by [Slack], primarily a platform for experimentation for learning [Elixir Lang], [Phoenix Framework], and [Elm Lang].

Feel free to open any Pull Request (PR) or issues if you see things that can be improved or fixed.

Visit [Diskusi Trello board] for its development roadmap.

## Prerequisites

### Develop and Compile Dependencies

The following binaries / libraries need to be installed in order to compile the web application:
 
  - [Elixir Lang] v1.2
  - [Elm Lang] v0.16
  - [Phoenix Framework] v1.1.x
  - [Node.js] v4.3.x
  - [npm] v3.8.x
  - [Ruby] v2.2.x
  - [Sass] v3.4.x

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

  1. Configure the services:
     1. Run `vagrant up`
  1. Install dependencies:
     1. Install Phoenix dependencies with `mix deps.get`
     1. Install npm dependencies with `npm install`
     1. Install Elm dependencies with `elm package install`
  1. Data store setup:
     1. Create database with `mix ecto.create`
     1. Migrate database with `mix ecto.migrate`
     1. Seed the database with `mix run priv/repo/seeds.exs`
  1. Run tests:
     1. Start PhantomJs webdriver server with `npm run phantomjs`
     1. Run Elixir tests with `mix test`
  1. Start application with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

*NOTE: Run `mix docs` to generate doc-comment documentation.*

## Contributing

We follow the "[fork-and-pull]" Git workflow.

  1. Fork the repo on GitHub
  1. Commit changes to a branch in your fork (use `snake_case` convention):
     - For technical chores, use `chore/` prefix followed by the short description, e.g. `chore/do_this_chore`
     - For new features, use `feature/` prefix followed by the feature name, e.g. `feature/feature_name`
     - For bug fixes, use `bug/` prefix followed by the short description, e.g. `bug/fix_this_bug`
  1. Rebase or merge from "upstream"
  1. Submit a PR "upstream" with your changes

Please read [CONTRIBUTING] for more details.

## License

`diskusi` is released under the MIT License. See the [LICENSE] file for further details.

[CONTRIBUTING]: CONTRIBUTING.md
[Diskusi Trello board]: https://trello.com/b/ZwfyfjkG/diskusi-web-application
[Elixir Lang]: http://elixir-lang.org
[Elm Lang]: http://elm-lang.org
[fork-and-pull]: https://help.github.com/articles/using-pull-requests
[LICENSE]: LICENSE.txt
[Node.js]: https://nodejs.org
[npm]: https://www.npmjs.com
[Oracle VM VirtualBox]: https://www.virtualbox.org
[Phoenix Framework]: http://www.phoenixframework.org
[PostgreSQL]: http://www.postgresql.org/download/
[Ruby]: https://www.ruby-lang.org
[Sass]: http://sass-lang.com
[Slack]: https://slack.com
[Vagrant]: https://www.vagrantup.com
[vagrant-cachier]: https://github.com/fgrehm/vagrant-cachier
[vagrant-vbguest]: https://github.com/dotless-de/vagrant-vbguest