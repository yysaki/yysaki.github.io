# my cheat sheet
## nanoc
### bundle

    bundle install --path vendor/bundler
    bundle update

### commands

    cd $DIR
    bundle exec nanoc // compile
    bundle exec nanoc view // http://localhost:3000/

### guard

    bundle exec guard init nanoc
    guard // autocompile

## Bootstrap

    git submodule add git://github.com/twitter/bootstrap.git bootstrap
    sudo yum install -y npm
    sudo npm install -g grunt-cli
    cd $DIR
    grunt dist // compile

