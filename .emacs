
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(put 'upcase-region 'disabled nil)

(server-start)

;; Use a hbar cursor when mark is active and a region exists.
(defun th-activate-mark-init ()
  (setq cursor-type 'hbar))
(add-hook 'activate-mark-hook 'th-activate-mark-init)

(defun th-deactivate-mark-init ()
  (setq cursor-type 'box))
(add-hook 'deactivate-mark-hook 'th-deactivate-mark-init)


;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; This from a japanese individual.  I hope it works.
(setq buffer-file-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE
(set-clipboard-coding-system 'utf-16le-dos)


;;;;;;;;;;;;;;;;;;;;;
;; setup package archives
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

;; create a backup file directory
(defun make-backup-file-name (file)
  (concat "~/.emacs.backups/" (file-name-nondirectory file) "~"))

(defconst console-p (eq (symbol-value 'window-system) nil)
  "Are we running in a console (non-X) environment?")

;; highlight the current line unless we're running on the console
(if (not console-p)
    (progn (global-hl-line-mode 1)   ;; To customize the background color
           (set-face-background 'hl-line "#222")))

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; hitting delete will delete the highlighted region
(pending-delete-mode 1)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
(cond (window-system
       (mwheel-install)
       ))

;; force visible bell, 'cause every hates the system bell
(setq ring-bell-function (lambda nil (message "")))
(setq visible-bell nil)

;;;;;;;; Don't truncate, wrap, or fold lines of split windows ;;;
(setq truncate-partial-width-windows nil)
(setq truncate-lines nil)

;;;; The MODE Line ;;;;
(load "time") (display-time)
(column-number-mode 1)

;; title bar shows name of current buffer ;;
(setq frame-title-format '("emacs: %*%+ %b"))

;; don't show the startup message every time, I know I'm using emacs
(setq inhibit-startup-message t)

;;;; use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Show matching paren or bracket when cursor is on or after it
(show-paren-mode 1)
(setq blink-matching-paren-distance nil)

(ido-mode t)

(let ((default-directory "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")
(setq my-packages
      '(cl-lib coffee-mode color-theme company-mode dash el-get epl f flycheck haml-mode helm helm-company helm-projectile inf-ruby inflections let-alist package pkg-info projectile projectile-rails rake rbenv robe-mode rubocop s sass-mode scss-mode seq yaml-mode))
(el-get 'sync my-packages)

(mapc 'load (file-expand-wildcards "~/.emacs.d/autoload/*.el"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (inflections))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
