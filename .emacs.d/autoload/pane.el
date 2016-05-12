(set-frame-parameter (selected-frame) 'alpha '(94 50))
(add-to-list 'default-frame-alist '(alpha 94 50))

;; arg >= 1 enable the menu bar. Menu bar is the File, Edit, Options,
;; Buffers, Tools, Emacs-Lisp, Help
(menu-bar-mode 0)

;; With numeric ARG, display the tool bar if and only if ARG is
;; positive.  Tool bar has icons document (read file), folder (read
;; directory), X (discard buffer), disk (save), disk+pen (save-as),
;; back arrow (undo), scissors (cut), etc.
(if (boundp 'tool-bar-mode) (tool-bar-mode 0))

;; hide the scroll bar no matter what
(if (boundp 'scroll-bar-mode) (scroll-bar-mode -1))


(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))

(defun my-set-mac-font (name  size)
  (interactive
   (list (completing-read "font-name: "
                          (mapcar (lambda (p) (list (car p) (car p)))
                                  (x-font-family-list)) nil t)
         (read-number "size: " 12)))
  (set-face-attribute 'default nil
                      :family name
                      :slant  'normal
                      :weight 'normal
                      :width  'normal
                      :height (* 10 size))
  (frame-parameter nil 'font))

(defun arrange-frame (w h &optional nosplit)
  "Rearrange the current frame to a custom width and height and split unless prefix."
  (let ((frame (selected-frame)))
    (when (equal 'mac (framep frame))
      (delete-other-windows)
      (set-frame-position frame 5 25)
      (set-frame-size frame w h)
      (if (not nosplit)
          (split-window-horizontally)))))

(defun medium (&optional nosplit)
  "Create a two-pane window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "Inconsolata" 16)
  (arrange-frame 170 45 nosplit))

(mac-toggle-max-window)
(medium)
(split-window-horizontally)
