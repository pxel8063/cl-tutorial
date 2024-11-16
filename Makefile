LISP ?= sbcl

build:
	HOME=$(pwd) $(LISP) --non-interactive \
		--eval '(load (sb-ext:posix-getenv "ASDF"))' \
		--eval '(pushnew (truename "./.") asdf:*central-registry*)' \
		--eval '(asdf:load-system :cl-tutorial)' \
		--eval '(asdf:make :cl-tutorial)' \
		--eval '(quit)'
