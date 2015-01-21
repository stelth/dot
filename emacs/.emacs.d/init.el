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
