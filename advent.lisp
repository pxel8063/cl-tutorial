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

(defun tree-search (states goal-p successors combiner)
  "Find a state that satisfies goal-p.  Start with states,
  and search according to successors and combiner."
  (dbg :search "~&;; Search: ~a" states)
  (cond ((null states) fail)
        ((funcall goal-p (first states)) (first states))
        (t (tree-search
             (funcall combiner
                      (funcall successors (first states))
                      (rest states))
             goal-p successors combiner))))

(defun depth-first-search (start goal-p successors)
  "Search new states first until goal is reached."
  (tree-search (list start) goal-p successors #'append))

(defun binary-tree (x) (list (* 2 x) (+ 1 (* 2 x))))

(defun is (value) #'(lambda (x) (eql x value)))

(defun prepend (x y) "Prepend y to start of x" (append y x))

(defun breadth-first-search (start goal-p successors)
  "Search old states first until goal is reached."
  (tree-search (list start) goal-p successors #'prepend))

;;;; The Debugging Output Facility:

(defvar *dbg-ids* nil "Identifiers used by dbg")

(defun dbg (id format-string &rest args)
  "Print debugging info if (DEBUG ID) has been specified."
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (apply #'format *debug-io* format-string args)))

(defun debug1 (&rest ids)
  "Start dbg output on the given ids."
  (setf *dbg-ids* (union ids *dbg-ids*)))

(defun undebug1 (&rest ids)
  "Stop dbg on the ids.  With no ids, stop dbg altogether."
  (setf *dbg-ids* (if (null ids) nil
                      (set-difference *dbg-ids* ids))))

;;; ==============================

(defun dbg-indent (id indent format-string &rest args)
  "Print indented debugging info if (DEBUG ID) has been specified."
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (dotimes (i indent) (princ "  " *debug-io*))
    (apply #'format *debug-io* format-string args)))
