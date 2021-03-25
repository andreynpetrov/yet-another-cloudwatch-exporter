
NAME=yace

build: get_tag
	docker build --no-cache=false -t $(NAME):$(TAG) .

run: get_tag
	docker run \
		-e AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN \
		-e AWS_DEFAULT_REGION \
		--rm \
		-p 5000:5000 \
		--mount type=bind,source=/home/petrov/repo/github/yet-another-cloudwatch-exporter/config.yml,target=/tmp/config.yml \
		 $(NAME):$(TAG) \
		 	--config.file=/tmp/config.yml \
			--debug \
			--floating-time-window=true \
			--decoupled-scraping=true \
			--scraping-interval=60

exec: get_tag
	docker run --rm -it -p 5000:5000 $(NAME):$(TAG) sh

get_tag:
	$(eval TAG := $(shell date +%Y-%m-%d))