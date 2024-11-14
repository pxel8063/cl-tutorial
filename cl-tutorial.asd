(defsystem "cl-tutorial"
  :version "0.0.1"
  :author "antarcticafalls"
  :license "MIT"
  :depends-on (:hunchentoot
	       :djula)
  :components ((:module "./."
                :components
                ((:file "main"))))
  :description ""
  :build-operation "program-op" ;; leave as is
  :build-pathname "cl-tutorial"
  :entry-point "cl-tutorial:main")
