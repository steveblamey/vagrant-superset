# A Vagrant file and shell provisioner for Apache Superset

[Apache Superset](https://superset.incubator.apache.org) is a modern, enterprise-ready business intelligence web application.

## Requires

* [Vagrant](https://www.vagrantup.com)

## Features

* Uses ubuntu/bionic64 base box
* Uses postgresql db back-end
* Remote connect to postgres db on localhost:4000
* No demo data loaded

## Default usernames/passwords

* Superset admin user: admin/admin
* Superset db role: superset/superset

## Make it work

```
$ git clone https://github.com/steveblamey/vagrant-superset.git

$ cd vagrant-superset
$ vagrant up

$ vagrant ssh
$ source env/bin/activate
$ superset runserver
```
Point your browser to `localhost:8088` and log-in to superset.
