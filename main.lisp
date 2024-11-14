(in-package :cl-user)
(defpackage :cl-tutorial
  (:use :cl)
  (:export
   :main))
(in-package :cl-tutorial)
(hunchentoot:define-easy-handler (root-route :uri "/") (name)
				 (format nil "Hey~@[ ~A~]!" name))
(defvar *server* (make-instance 'hunchentoot:easy-acceptor :port 6789))


(defun main ()
  (hunchentoot:start *server*)
  (loop))
