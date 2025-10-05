(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-indentation t
        lsp-enable-on-type-formatting t
        lsp-lens-enable t
        lsp-modeline-diagnostics-enable t
        lsp-completion-provider :capf
        gc-cons-threshold 100000000
        read-process-output-max (* 1024 1024)
        lsp-idle-delay 0.5))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-show-with-cursor t
        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t))

(use-package flycheck
  :init (global-flycheck-mode))

(use-package company
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(provide 'core-lsp)
