(setq flycheck-ruby-rubocop-executable "/Users/moorecp/bin/rubocop_shim")
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
    '(progn
      (set-face-attribute 'flycheck-error nil :background "red4")))
