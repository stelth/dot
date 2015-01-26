; Allow pasting selection outside of Emacs
(setq x-select-enable-clipboard t)

; Auto refresh buffers
(global-auto-revert-mode 1)

; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

; Show keystrokes in progress (TODO: WTF?)
(setq echo-keystrokes 0.1)

; Move files to trash when deleting
(setq delete-by-moving-to-trash t)

;; Real emacs knights don't use shift to mark things
;(setq shift-select-mode nil)

;; Disable auto save and backup
(setq backup-inhibited t)
(setq auto-save-default nil)

; Answering just 'y' or 'n' will do
(defalias 'yes-or-no-p 'y-or-n-p)

;; UTF-8 please
;; (setq locale-coding-system 'utf-8) ; pretty
;; (set-terminal-coding-system 'utf-8) ; pretty
;; (set-keyboard-coding-system 'utf-8) ; pretty
;; (set-selection-coding-system 'utf-8) ; please
;; (prefer-coding-system 'utf-8) ; with sugar on top

;; ;; Show active region
;; (transient-mark-mode 1)
;; (make-variable-buffer-local 'transient-mark-mode)
;; (put 'transient-mark-mode 'permanent-local t)
;; (setq-default transient-mark-mode t)

; Remove text in active region if inserting text
(delete-selection-mode 1)

; Always display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

; Screens are wide enough these days
(setq-default fill-column 100)

; Save a list of recent files visited. (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ;; just 20 is too recent

;; ;; Undo/redo window configuration with C-c <left>/<right>
;; (winner-mode 1)

; Never insert tabs
(setq-default indent-tabs-mode nil)

; Show me empty lines after buffer end
(setq-default indicate-empty-lines t)

;; enable some really cool extensions like C-x C-j(dired-jump)
(require 'dired-x)

;; Don't break lines for me, please
;(setq-default truncate-lines t)

;; ;; Keep cursor away from edges when scrolling up/down
;; (require 'smooth-scrolling)

;; ;; Represent undo-history as an actual tree (visualize with C-x u)
;; (setq undo-tree-mode-lighter "")
;; (require 'undo-tree)
;; (global-undo-tree-mode)

;; ;; Sentences do not need double spaces to end. Period.
;; (set-default 'sentence-end-double-space nil)

;; Add parts of each file's directory to the buffer name if not unique
(require 'uniquify)
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Always reuse buffers across frames if visible:
(setq display-buffer-base-action '(nil (reusable-frames . visible)))

;; ;; A saner ediff
;; (setq ediff-diff-options "-w")
;; (setq ediff-split-window-function 'split-window-horizontally)
;; (setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.
;; (setq eval-expression-print-level nil)

;; ;; When popping the mark, continue popping until the cursor actually moves
;; ;; Also, if the last command was a copy - skip past all the expand-region cruft.
;; (defadvice pop-to-mark-command (around ensure-new-position activate)
;;   (let ((p (point)))
;;     (when (eq last-command 'save-region-or-current-line)
;;       ad-do-it
;;       ad-do-it
;;       ad-do-it)
;;     (dotimes (i 10)
;;       (when (= p (point)) ad-do-it))))

(provide 'init/sane-defaults)
