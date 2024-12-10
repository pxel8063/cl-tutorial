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
(defvar fail nil)
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

(defun tesst (src)
  (cond ((> (length src) 0 )
	 (cons (char src 0) (tesst (subseq src 1))))
	(t nil)))

(defun build-coordinate (seq y)
  (loop for i from 0 to (- (length seq) 1)
	when (char/= #\. (char seq i)) collect (list (char seq i) i y)))

(defun make-coordinate (k x y)
  "Make coordinate as a list of (k x y) from x y ignoring #\."
  (if (char= k #\.)
      nil
      (list k x y)))

(defun adve8 ()
  (let* ((in (open "/tmp/8a.txt"))
	 (aa (when in
	       (loop for line = (read-line in nil)
		     for y = 0 then (+ y 1)
		     while line
		     append (build-coordinate line y)))))
    (close in)
    aa))


(defun coord-x (a)
  (first a))

(defun coord-y (a)
  (second a))

(defun antenna-letter (a)
  (first a))


(defun antinode (a b)
  "return antinode, unless a and b is the same"
  (if (some #'/= a b)
      (let ((p        (list (- (* 2 (coord-x a)) (coord-x b)) (- (* 2 (coord-y a)) (coord-y b)))))
	(if (on-map-p p)
	    (list p)
	    nil))			; a - b -> 2 * a -b
      nil))

(remove-duplicates (mapcar #'antenna-letter (adve8)))

(defun identify-antinode (cp)
  "Cp cross-product"
  (antinode (first cp) (second cp)))

(defun antinode-set (position-list)
  "return atinode-set from position-list"
  (let ((cp (cross-product #'list position-list position-list)))
    (remove-duplicates (mappend #'identify-antinode cp)
		       :test #'(lambda (x y) (not (some #'/= x y))))))

;;(loop for i in (remove-duplicates (mapcar #'antenna-letter (adve8)))
(remove-if-not #'(lambda (x) (char= #\0 x)) (adve8) :key #'antenna-letter)

(defun on-map-p (a)
  "cordinate on the map?"
  (every #'(lambda (x)
	     (and (> x -1) (< x 50)))
	 a))
  
(defun mappend (fn the-list)
  "Apply fn to each element of list and append the results."
  (apply #'append (mapcar fn the-list)))

(defun cross-product (fn xlist ylist)
  "Return a list of all (fn x y) values."
  (mappend #'(lambda (y)
	       (mapcar #'(lambda (x) (funcall fn x y)) xlist))
	   ylist))

(defun sssss (state)
  "return the function which returns position list takes letter "
  #'(lambda (k)
      (mapcar #'rest
	      (remove-if #'(lambda (x)
			     (char= (first x) k)) state))))
  
(defun count-antinode ()
  (let ((state)
	(letter)
	(antinode))
    (setf state (adve8))
    (setf letter (remove-duplicates (mapcar #'antenna-letter state)))
    (setf antinode (mappend #'antinode-set (mapcar (sssss state) letter)))
    (count-if #'on-map-p (remove-duplicates antinode :test #'(lambda (x y) (not (some #'/= x y)))))))
    

    
    ;(setf letter (remove-duplicates (mapcar #'antenna-letter state))
    

