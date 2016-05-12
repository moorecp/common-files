(setq auto-mode-alist (append '(
        ("\\.rabl$" . ruby-mode)
        ("\\.opal$" . ruby-mode)
          ) auto-mode-alist))

(add-hook 'ruby-mode-hook
	  (function (lambda ()
		      (local-set-key (kbd "<tab>") 'indent-according-to-mode)
		      )))

(setq ruby-insert-encoding-magic-comment nil)
