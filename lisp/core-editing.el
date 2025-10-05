(use-package move-text
  :config
  (move-text-default-bindings))

(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-global-mode 1))

(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

(provide 'core-editing)
