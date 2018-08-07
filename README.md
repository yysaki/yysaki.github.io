# my cheat sheet
## docker

    docker pull yysaki/nanoc
    docker run -i -t -v ~/repositories/blog:/blog -v ~/.gitconfig:/root/.gitconfig -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -p 8080:3000 yysaki/nanoc:latest /bin/bash

## nanoc
### bundle

    bundle install --path vendor/bundler
    bundle update

### commands

    cd $DIR
    bundle exec nanoc // compile
    bundle exec nanoc view -o 0.0.0.0 // http://localhost:3000/

### guard

    bundle exec guard init nanoc
    guard // autocompile

## Bootstrap

    git submodule add git://github.com/twitter/bootstrap.git bootstrap
    sudo yum install -y npm
    sudo npm install -g grunt-cli
    cd $DIR
    grunt dist // compile

## Foundation

    sudo npm install -g bower
    bower install

## deploy

    git clone git@github.com:yysaki/yysaki.github.io.git deploy
    bundle exec rake deploy
