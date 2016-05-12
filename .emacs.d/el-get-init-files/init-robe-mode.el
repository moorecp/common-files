(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'haml-mode-hook
          (lambda () (local-set-key (kbd "M-.") #'robe-jump)))
