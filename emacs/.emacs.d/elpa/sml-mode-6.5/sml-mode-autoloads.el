;;; sml-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "sml-mode" "../../../../../.emacs.d/elpa/sml-mode-6.5/sml-mode.el"
;;;;;;  "93ab7c97f6172316858de35b6563a85b")
;;; Generated autoloads from ../../../../../.emacs.d/elpa/sml-mode-6.5/sml-mode.el

(defalias 'run-sml 'sml-run)

(autoload 'sml-run "sml-mode" "\
Run the program CMD with given arguments ARG.
The command is run in buffer *CMD* using mode `inferior-sml-mode'.
If the buffer already exists and has a running process, then
just go to this buffer.

If a prefix argument is used, the user is also prompted for a HOST
on which to run CMD using `remote-shell-program'.

\(Type \\[describe-mode] in the process's buffer for a list of commands.)

\(fn CMD ARG &optional HOST)" t nil)

(add-to-list 'auto-mode-alist '("\\.s\\(ml\\|ig\\)\\'" . sml-mode))

(autoload 'sml-mode "sml-mode" "\
\\<sml-mode-map>Major mode for editing Standard ML code.
This mode runs `sml-mode-hook' just before exiting.
See also (info \"(sml-mode)Top\").
\\{sml-mode-map}

\(fn)" t nil)

(add-to-list 'completion-ignored-extensions ".cm/")

(add-to-list 'auto-mode-alist '("\\.cm\\'" . sml-cm-mode))

(autoload 'sml-cm-mode "sml-mode" "\
Major mode for SML/NJ's Compilation Manager configuration files.

\(fn)" t nil)

(autoload 'sml-lex-mode "sml-mode" "\
Major Mode for editing ML-Lex files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.grm\\'" . sml-yacc-mode))

(autoload 'sml-yacc-mode "sml-mode" "\
Major Mode for editing ML-Yacc files.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("../../../../../.emacs.d/elpa/sml-mode-6.5/sml-mode-autoloads.el"
;;;;;;  "../../../../../.emacs.d/elpa/sml-mode-6.5/sml-mode.el")
;;;;;;  (21696 13541 68698 448000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; sml-mode-autoloads.el ends here
