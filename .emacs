;;; Basic UI settings
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(global-visual-line-mode 1)
(show-paren-mode 1)
(global-display-line-numbers-mode 1)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; Start with *scratch* buffer
(setq initial-buffer-choice t)

;; Set the initial scratch message to empty or a custom message
(setq initial-scratch-message nil)

;;; Package management setup
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;; Font configuration
(defun get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka-20")
   ((eq system-type 'darwin) "Iosevka-20")))

(add-to-list 'default-frame-alist `(font . ,(get-default-font)))

;;; Theme
(load-theme 'gruber-darker t)

;;; Make sure PATH is correctly set up
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x))
  :config
  (exec-path-from-shell-initialize))

;; Navigate to projects with Cmd+Shift+P
(defun magit-status-with-prefix-arg ()
  "Call `magit-status` with a prefix."
  (interactive)
  (let ((current-prefix-arg '(4)))
    (call-interactively #'magit-status)))

(use-package magit
  :config
  (setq magit-repository-directories '(("~/Documents" . 4) ("~/Dropbox/projects/" . 4)))
  (global-set-key (kbd "s-p") 'magit-status-with-prefix-arg)
  (global-set-key (kbd "s-g") 'magit-status))

(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings)
  (global-set-key (kbd "M-p") 'move-text-up)
  (global-set-key (kbd "M-n") 'move-text-down))

(use-package fzf
  :ensure t)

;;; LSP Mode configuration
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-on-type-formatting t)
  (setq lsp-lens-enable t)
  (setq lsp-modeline-diagnostics-enable t)
  (setq lsp-completion-provider :capf)
  ;; Remove the top bar
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  ;; Performance optimizations
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 1024))
  (setq lsp-idle-delay 0.500))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-sideline-enable t)
  (setq lsp-ui-sideline-show-diagnostics t))

;;; Go mode configuration
(use-package go-mode
  :hook (go-mode . lsp-deferred)
  :config
  ;; Format on save
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)

  ;; Enable automatic imports
  (setq lsp-go-import-shortcut "Both")
  (setq lsp-go-add-missing-imports t)
  (setq lsp-gopls-staticcheck t)
  (setq lsp-gopls-complete-unimported t)
  (setq lsp-gopls-use-placeholders t))

;; Additional Go tools
(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))

;;; TypeScript & TSX Configuration
(use-package typescript-mode
  :mode ("\\.ts\\'" . typescript-mode)
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2)
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package web-mode
  :mode ("\\.tsx\\'" . web-mode)
  :hook (web-mode . (lambda ()
                      (when (string-equal "tsx" (file-name-extension buffer-file-name))
                        (lsp-deferred))))
  :config
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

;; Ensure TypeScript LSP server is properly configured for TSX
(use-package lsp-mode
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("typescript-language-server" "--stdio"))
                    :major-modes '(web-mode)
                    :server-id 'typescript-tsx
                    :activation-fn (lambda (file-name major-mode)
                                     (and (string= major-mode 'web-mode)
                                          (string-match "\\.tsx\\'" file-name)))
                    :priority -3)))

;;; Auto-completion and Snippets
(use-package company
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(use-package yasnippet
  :config
  (yas-global-mode 1))

;; Enable Auto Imports in TypeScript
(setq lsp-completion-provider :capf)
(setq lsp-typescript-auto-imports t)
(setq lsp-eslint-auto-fix-on-save t)

;;; Flycheck for syntax checking
(use-package flycheck
  :init (global-flycheck-mode))

;;; Magit for Git integration
(use-package magit
  :bind (("C-x g" . magit-status)))

;;; Project management
(use-package projectile
  :config
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map))

;;; Enable line numbers globally
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; Backup and auto-save settings
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;;; Enable whitespace visualization
;; (use-package whitespace
;;   :config
;;   (setq whitespace-style '(face tabs tab-mark trailing))
;;   (global-whitespace-mode 1))

;;; Parenthesis management
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))

;;; Helpful key bindings
(global-set-key (kbd "C-c g f") 'lsp-find-definition)
(global-set-key (kbd "C-c g r") 'lsp-find-references)
(global-set-key (kbd "C-c g a") 'lsp-execute-code-action)
(global-set-key (kbd "C-c g i") 'lsp-organize-imports)
(global-set-key (kbd "C-c g h") 'lsp-describe-thing-at-point)

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus))))

;;; Save customizations to a separate file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
  (load custom-file))

;;; Final message
(message "Configuration loaded successfully!")
