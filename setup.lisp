(load (sb-ext:posix-getenv "ASDF"))
(pushnew (truename "./.") asdf:*central-registry*)
(asdf:load-system :cl-tutorial)
