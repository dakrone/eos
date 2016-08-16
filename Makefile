# Directory where this Makefile exists (the dotfiles directory)
EOS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

el-modules = eos-core.el \
						 eos-helm.el \
						 eos-ido.el \
						 eos-appearance.el \
						 eos-navigation.el \
						 eos-notify.el \
						 eos-develop.el \
						 eos-es.el \
						 eos-org.el \
						 eos-writing.el \
						 eos-dired.el \
						 eos-remote.el \
						 eos-java.el \
             eos-clojure.el \
             eos-web.el \
             eos-shell.el \
             eos-mail.el \
             eos-irc.el \
             eos-distributed.el \
             eos-rss.el \
             eos-twitter.el \
             eos-leisure.el \
             eos-music.el \
             eos.el

sh-modules = out/zshrc \
						 out/zshenv

all: init $(el-modules) $(sh-modules)

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
	zsh initialize.sh

out/zshrc: zsh.org
	bin/tangle zsh.org
out/zshenv: zsh.org
	bin/tangle zsh.org

%.el: %.org
	bin/tangle $<

byte-compile-all: all
	for f in *.el; do \
		bin/byte-compile $$f; \
	done

run: all
	for f in sh/*.sh; do \
		echo "Running: $$f"; \
		zsh -l $$f; \
	done

install: run-init run install.sh
	zsh -l install.sh
