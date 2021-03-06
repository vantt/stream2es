LEIN ?= lein
NAME = stream2es
VERSION = $(shell git ver)
BIN = $(NAME)-$(VERSION)
S3HOME = s3://download.elasticsearch.org/$(NAME)

package: target/$(BIN)

install: target/$(BIN)
	cp target/$(BIN) ~/bin/$(NAME)

release: install target/$(BIN)
	s3cmd put -P target/$(BIN) $(S3HOME)/$(BIN)
	s3cmd cp $(S3HOME)/$(BIN) $(S3HOME)/$(NAME)

clean:
	rm -rf target

target/$(BIN):
	mkdir -p etc
	echo $(VERSION) >etc/version.txt
	LEIN_SNAPSHOTS_IN_RELEASE=yes $(LEIN) bin

