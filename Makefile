build:
	bundle exec nanoc

dev:
	bundle exec nanoc view -o 0.0.0.0

watch:
	bundle exec guard

deploy: build
	bundle exec nanoc deploy
