(global-company-mode t)
(push 'company-robe company-backends)
(add-hook 'company-mode-hook
          (lambda () (local-set-key (kbd "M-<right>") #'company-complete)))
