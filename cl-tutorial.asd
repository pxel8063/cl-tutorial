(defsystem "cl-tutorial"
  :version "0.0.1"
  :author "antarcticafalls"
  :license "MIT"
  :description "a minimal web server as a tutorial"
  :depends-on (:hunchentoot)
  :components ((:module "./."
		:components
		((:file "main")))))
