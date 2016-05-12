(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(global-set-key (kbd "C-M-<left>") 'windmove-left)          ; move to left windnow
(global-set-key (kbd "C-M-<right>") 'windmove-right)        ; move to right window
(global-set-key (kbd "C-M-<up>") 'windmove-up)              ; move to upper window
(global-set-key (kbd "C-M-<down>") 'windmove-down)          ; move to downer window
