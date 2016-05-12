(global-linum-mode 1)

(add-hook 'after-change-major-mode-hook 
          '(lambda ()
             (if (not (equal major-mode 'term-mode))
                 (linum-mode 1))))
