;;; -*- lexical-binding: t -*-

;;; Editor Configuration

;; Support functions
(defun find-file-command (a-file)
  "Return a command that will find the given file."
  (lambda () (interactive) (find-file a-file)))


;; Appearance

;; Turn off toolbar and scrollbar
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

;; Coding system
(prefer-coding-system 'utf-8)


;; Behaviour

;; Set an absolute backup directory, placing it in the emacs config dir
(setq backup-directory-alist
      (list (cons "." (concat user-emacs-directory "backups"))))

;; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq tab-width 4
      c-basic-offset 4)

;; Add custom plugins directory to load-path
(add-to-list 'load-path (concat user-emacs-directory "custom"))

;; apropos will show everything, including functions
(setq apropos-do-all t)

;; Rebind several common operations to use the leader key
;; Replace yes-or-no with y-or-n prompt
(fset 'yes-or-no-p 'y-or-n-p)

;; Do not confirm when file or buffer does not exist
(setq confirm-nonexistent-file-or-buffer nil)

;; Save emacs' state upon closing
(setq desktop-save-mode 1)

;; Enable debug information on error
(setq debug-on-error t)


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
