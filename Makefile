# Directory where this Makefile exists (the dotfiles directory)
EOS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

el-modules = eos-core.el \
						 eos-notify.el \
						 eos-develop.el \
						 eos-org.el \
						 eos-dired.el \
						 eos-java.el \
             eos-clojure.el \
             eos-web.el \
             eos-shell.el \
             eos-mail.el \
             eos-irc.el \
             eos-rss.el \
             eos-twitter.el \
             eos-leisure.el \
             eos.el

all: init $(el-modules)

clean:
	rm -fv *.el
	rm -fv *.elc
	rm -fv sh/*.sh

init: initialize.sh
initialize.sh: eos.org
	bin/tangle eos.org
install.sh: eos.org
	bin/tangle eos.org
run-init: init
	bash initialize.sh

%.el: %.org
	bin/tangle $<

byte-compile-all: all
	for f in *.el; do \
		bin/byte-compile $$f; \
	done

run: all
	for f in sh/*.sh; do \
		echo "Running: $$f"; \
		bash -l $$f; \
	done

install: run-init run install.sh
	echo "I don't quite work yet..."
	bash -l install.sh
