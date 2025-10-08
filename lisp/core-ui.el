;; Basic UI settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-visual-line-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-buffer-choice t
      initial-scratch-message nil)

;; macOS settings
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta
        mac-option-modifier 'super))

;; Font setup
(defun get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka-20")
   ((eq system-type 'darwin) "JetBrainsMono Nerd Font-13")))

(add-to-list 'default-frame-alist `(font . ,(get-default-font)))

(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; (use-package zenburn-theme
;;  :config
;;  (load-theme 'zenburn t))

(use-package solarized-theme)
(provide 'core-ui)
