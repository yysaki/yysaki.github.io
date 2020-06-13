build:
	bundle exec nanoc && npm run build

dev:
	bundle exec nanoc view -o 0.0.0.0

lint:
	bundle exec rubocop

new:
	bundle exec rake new
