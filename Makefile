all:
	docker build -t ses .
run:
	docker run --detach=true --env-file=env --name ses --publish=25:25 ses
clean:
	docker stop ses && docker rm ses
debug:
	docker run -i -t --volumes-from ses ses tail -f /var/log/mail.log
