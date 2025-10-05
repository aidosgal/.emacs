(global-set-key (kbd "C-c g f") 'lsp-find-definition)
(global-set-key (kbd "C-c g r") 'lsp-find-references)
(global-set-key (kbd "C-c g a") 'lsp-execute-code-action)
(global-set-key (kbd "C-c g i") 'lsp-organize-imports)
(global-set-key (kbd "C-c g h") 'lsp-describe-thing-at-point)

(provide 'core-keys)
