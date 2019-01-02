# my cheat sheet
## docker

    docker pull yysaki/nanoc
    docker run -i -t -v ./:/blog -v ~/.gitconfig:/root/.gitconfig -v ~/.ssh/id_rsa:/root/.ssh/id_rsa -p 8080:3000 yysaki/nanoc:latest /bin/bash

## nanoc
### bundle

    bundle install --path vendor/bundler
    bundle update

### foundation(by npm/bower)

    npm install
    npm run bower

### commands

    cd $DIR
    bundle exec nanoc // compile
    bundle exec nanoc view -o 0.0.0.0 // http://localhost:3000/

### guard

    bundle exec guard init nanoc
    guard // autocompile

## deploy

    rmdir -rf output
    mkdir output
    cd output
    git clone git@github.com:yysaki/yysaki.github.io.git
    cd ../
    bundle exec nanoc
    bundle exec nanoc deploy
