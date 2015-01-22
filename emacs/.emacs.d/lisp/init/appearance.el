;; Turn off this stuff = we don't need it
(unless (equal system-type 'darwin) (menu-bar-mode -1))
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Highlight matching parentheses when the point is on them.
(show-paren-mode t)

;; Frame title format
(setq frame-title-format
      '("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
							(abbreviate-file-name (buffer-file-name))
						      "%b")) "[%*]"))

;; Add watchwords when coding
(defun add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
	  1 font-lock-warning-face t))))
(add-hook 'prog-mode 'add-watchwords)

;; Make zooming affect frame instead of buffers
;; (require 'zoom-frm)
(provide 'init/appearance)
