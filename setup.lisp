(load (sb-ext:posix-getenv "ASDF"))
(pushnew (truename "./.") asdf:*central-registry*)
(declaim (optimize (speed 0) (space 0) (debug 3)))
(asdf:load-system :cl-tutorial)
