(use-package magit
  :config
  (setq magit-repository-directories
        '(("~/Documents" . 4)
          ("~/Dropbox/projects/" . 4)))
  (global-set-key (kbd "s-p") 'magit-status)
  (global-set-key (kbd "s-g") 'magit-status))

(provide 'core-git)
