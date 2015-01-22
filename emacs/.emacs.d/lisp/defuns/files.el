(defun recur-list-files (dir re)
  "Returns a list of files in directory matching a given regex"
  (when (file-accessible-directory-p dir)
    (let ((files (directory-files dir t))
	  matched)
      (dolist (file files matched)
	(let ((fname (file-name-nondirectory file)))
	  (cond
	   ((or (string= fname ".")
		(string= fname "..")) nil)
	   ((and (file-regular-p file)
		 (string-match re fname))
	    (setq matched (cons file matched)))
	   ((file-directory-p file)
	    (let ((tfiles (recur-list-files file re)))
	      (when tfiles (setq matched (append matched tfiles)))))))))))

(defun remote-buffer-p ()
  (and buffer-file-name (file-remote-p buffer-file-name)))
