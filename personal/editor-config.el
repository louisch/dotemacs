;;; -*- lexical-binding: t -*-

;;; Editor Configuration

;; Support functions
(defun find-file-command (a-file)
  "Return a command that will find the given file."
  (lambda () (interactive) (find-file a-file)))


;; Appearance

;; Turn off toolbar and scrollbar
;; Menu bar is left on just in case
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Line length of 79
(setq-default fill-column 79)

;; Custom theme
(load-theme 'solarized-dark t)

;; Set frames to have width 84 (enough space to display 80 characters), and full
;; screen height.
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(width . 84))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; Turn column numbers on in the modeline
(setq column-number-mode t)

;; Show trailing whitespace
(setq show-trailing-whitespace t)


;; Behaviour

;; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq-default tab-width 2)
;; Require newline at end of files
(setq require-final-newline t)

;; Backup directory
(setq backup-directory-alist
      (list (cons "." (concat user-emacs-directory "backups"))))

;; help apropos will show everything, including functions
(setq apropos-do-all t)

;; Make emacs confirmation dialogs shorter
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; Save emacs' state upon closing
(setq desktop-save-mode 1)

;; Enable debug information on error
(setq debug-on-error t)

;; Coding system
(prefer-coding-system 'utf-8)


;; Keybindings
(evil-leader/set-key
  "s" (lambda () (interactive)
        (progn (delete-trailing-whitespace) (save-buffer)))
  "e" 'helm-find-files
  "b" 'helm-mini
  "w" 'delete-trailing-whitespace
  "i" (find-file-command user-init-file)
  "%" 'split-window-right
  "\"" 'split-window-below)
