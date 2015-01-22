;;
;; Editing/movement commands - bound to keys later on
;;

(defun back-to-indentation-or-beginning ()
  (interactive)
  (if (= (point) (save-excursion (back-to-indentation) (point)))
      (beginning-of-line)
    (back-to-indentation)))

;;
;; Functions to delete words without adding to the kill ring (bound to
;; M-backspace further down)
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word-arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

;; Recognize these are movement functions os that shift-<key> works properly
(dolist (cmd
	 '(back-to-indentation-or-beginning delete-word backward-delete-word))
  (put cmd 'CUA 'move)
)
