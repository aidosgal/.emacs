;;; init.el --- Emacs main initialization file -*- lexical-binding: t; -*-

;; Add ~/.emacs.d/lisp to the load path
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Load core modules
(require 'core-packages)
(require 'core-ui)
(require 'core-git)
(require 'core-lsp)
(require 'lang-go)
(require 'lang-typescript)
(require 'core-editing)
(require 'core-keys)

;; Load saved customizations separately
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(message "✅ Configuration loaded successfully!")

(provide 'init)
;;; init.el ends here
