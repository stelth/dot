(require 'package)
(add-to-list 'package-archives
	     '( "melpa" . "http://melpa.org/packages/") t)
(package-initialize)

;; Set theme to badwolf
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(set-cursor-color "#0A9DFF")
(provide 'init-themes)
(load-theme 'badwolf t)

;; Disable cursor blinking
(blink-cursor-mode 0)

;; Don't show messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; Don't let emacs hurt your ears
(setq visible-tell t)

(setq inhibit-startup-echo-area-message "coxj")

;; Break the walls
(scroll-bar-mode 0)

(tool-bar-mode 0)
(menu-bar-mode 0)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-inhibited t)
(setq auto-save-default nil)

(defconst packagelist
  '(anzu
    company
    duplicate-thing
    ggtags
    helm
    helm-projectile
    helm-gtags
    helm-swoop
    function-args
    clean-aindent-mode
    comment-dwim-2
    dtrt-indent
    ws-butler
    iedit
    yasnippet
    smartparens
    sml-mode
    projectile
    volatile-highlights
    undo-tree
    zygospore))

(defun install-packages ()
  "Install all required packages"
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package packagelist)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

;; This variable must be set before loading helm-gtags
(setq helm-gtags-prefix-key "\C-cg")

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-helm)
(require 'setup-helm-gtags)
(require 'setup-cedet)
(require 'setup-editing)

(windmove-default-keybindings)

;; function-args
(require 'function-args)
(fa-config-default)
(define-key c-mode-map [(tab)] 'moo-complete)
(define-key c++-mode-map [(tab)] 'moo-complete)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(delete 'company-semantic company-backends)
(define-key c-mode-map [(control tab)] 'company-complete)
(define-key c++-mode-map [(control tab)] 'company-complete)

;; company-c-headers
(add-to-list 'company-backends 'company-c-headers)
(setq company-c-headers-path-system (list "/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4"))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

(setq c-default-style "linux" ;; set style to "linux"
 )

(global-set-key (kbd "RET") 'newline-and-indent) ; automatically indent when pressing RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unnecessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 8)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
			       (interactive)
			       (setq-local compilation-read-command nil)
			       (call-interactively 'compile)))

;; set GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; Package: projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)

;; Package zygospore
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "-std=c++11" "-stdlib=libc++" "-xc++" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/x86_64-pc-linux-gnu/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/backward/." "-I/usr/local/include/." "-I/usr/lib/clang/3.5.0/include/." "-I/usr/include/libusb-1.0/." "-I/usr/include/gtk-2.0/." "-I/usr/include/." "-I./src/stealth/src/." "-I./src/common/." "-I/usr/include/bullet/." "-I/usr/include/opencv/." "-I/usr/include/opencv2/." "-I/usr/include/crypto++/.")
     (company-clang-arguments "-std=c++11" "-stdlib=libc++" "-xc++" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/x86_64-pc-linux-gnu/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/backward/." "-I/usr/local/include" "-I/usr/lib/clang/3.5.0/include/." "-I/usr/include/libusb-1.0/." "-I/usr/include/gtk-2.0/." "-I/usr/include" "-I./src/stealth/src/." "-I./src/common/." "-I/usr/include/bullet/." "-I/usr/include/opencv/" "-I/usr/include/opencv2" "-I/usr/include/crypto++/.")
     (company-clang-arguments "-std=c++11" "-stdlib=libc++" "-xc++" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/x86_64-pc-linux-gnu/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/backward/." "-I/usr/local/include" "-I/usr/lib/clang/3.5.0/include/." "-I/usr/include/libusb-1.0/." "-I/usr/include/gtk-2.0/." "-I/usr/include" "-I./src/stealth/src" "-I./src/common" "-I/usr/include/bullet/." "-I/usr/include/opencv/" "-I/usr/include/opencv2" "-I/usr/include/crypto++/.")
     (company-clang-arguments "-std=c++11" "-stdlib=libc++" "-xc++" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/x86_64-pc-linux-gnu/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/backward/." "-I/usr/local/include" "-I/usr/lib/clang/3.5.0/include/." "-I/usr/include/libusb-1.0/." "-I/usr/include/gtk-2.0/." "-I/usr/include" "-Isrc/stealth/src" "-Isrc/common" "-I/usr/include/bullet/." "-I/usr/include/opencv/" "-I/usr/include/opencv2" "-I/usr/include/crypto++/.")
     (company-clang-arguments "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4" "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/x86_64-pc-linux-gnu/." "-I/usr/lib/gcc/x86_64-pc-linux-gnu/4.9.2/include/g++-v4/backward/." "-I/usr/local/include" "-I/usr/lib/clang/3.5.0/include/." "-I/usr/include/libusb-1.0/." "-I/usr/include/gtk-2.0/." "-I/usr/include" "-Isrc/stealth/src" "-Isrc/common" "-I/usr/include/bullet/." "-I/usr/include/opencv/" "-I/usr/include/opencv2" "-I/usr/include/crypto++/.")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
