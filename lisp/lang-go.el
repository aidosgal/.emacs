(use-package go-mode
  :hook (go-mode . lsp-deferred)
  :config
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t)
  (setq lsp-gopls-staticcheck t
        lsp-gopls-complete-unimported t
        lsp-gopls-use-placeholders t))

(use-package go-eldoc
  :hook (go-mode . go-eldoc-setup))

(provide 'lang-go)
