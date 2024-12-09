(defvar *col1* nil)
(defvar *col2* nil)

(defun adve ()
  (let ((in (open "/tmp/4.txt"))
	(aa nil)
	(bb nil))
    (when in
      (loop for line = (read-line in nil)
	    while line
	    do (let ((my (cl-ppcre:split "\\s+" line)))
		 (push (read-from-string (first my)) aa)
		 (push (read-from-string (first (rest my))) bb))))
    (setf *col1* (sort aa #'>))
    (setf *col2* (sort bb #'>))))



(defun sss (c1 c2)
  (if c1
      (+ (abs (- (first c1) (first c2)))
	 (sss (rest c1) (rest c2)))
      0))
