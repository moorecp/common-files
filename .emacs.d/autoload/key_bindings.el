(global-unset-key "\M-g") ;;remove current ridiculous binding on alt-g
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-;" 'comment-or-uncomment-region)
(global-set-key [delete] 'delete-char) ;;delete key work on regular kb
(global-set-key [kp-delete] 'delete-char) ;;delete key work on keypad
(global-set-key [f4] 'revert-buffer)    ; F4
