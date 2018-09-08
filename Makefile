.PHONY: all sync commit push

all: sync commit push

sync:
	@sh snapshot.sh
	rm zsh/custom/*.16.sh

commit:
	@git add -A
	@git commit -m "$$(date +'%Y-%m-%d %X')"

push:
	git push
