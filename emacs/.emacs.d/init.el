;; Overall structure, much code, and several ideas copied shamelessly from https://github.com/magnars/.emacs.d

(defvar user-lisp-directory
  (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path user-lisp-directory)

;; Set up appearance early to avoid momentary display
(require 'init/appearance)

					; Set up lisp, exec, info paths
(require 'init/paths)

;; require-soft macro stolen from http://www.emacswiki.org/emacs/LocateLibrary
(defmacro require-soft (feature &optional file)
  "*Try to require FEATURE, but don't signal an error if `require' fails."
  `(require ,feature ,file 'noerror))

;; Lets start with a smattering of sanity
(require 'init/sane-defaults)

					; Favourite modes
(require 'init/semantic)
(require 'init/ede)
(require 'init/c++)
(require 'init/cmake)
(require 'init/flycheck)
(require 'init/tramp)
(require 'init/smartparens)
(require 'init/company)
(require 'init/ibuffer)
(require 'init/markdown)
(require 'init/org)
(require 'init/projectile)
(require 'init/ido)

;; Setup key bindings
(require 'init/key-bindings)

;; Map files to modes
(require 'init/mode-mappings)

;; Start session mode - TODO: redundant?
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; Load local stuff here
(let ((f (expand-file-name "local.el" user-lisp-directory)))
  (when (file-readable-p f)
    (load f)))

;;
;; All custom variables live in here
;;
;; Put this last so that we can customise variables defined by modes loaded above
;;
(load custom-file t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(set-cursor-color "#0A9DFF")
(provide 'init-themes)
(load-theme 'badwolf t)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
