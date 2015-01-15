;;; -*- lexical-binding: t -*-

;;; Editor Configuration

;; Appearance

;; Turn off toolbar and scrollbar
;; Menu bar is left on just in case
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Line length of 80
(setq-default fill-column 80)

;; Turn column numbers on in the modeline
(setq column-number-mode t)

;; Set frames to have width 84 (enough space to display 80 characters), and full
;; screen height.
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(width . 84))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))

;; Theme
(load-theme 'jazz t)

;; Behaviour

;; Startup screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Default mode
(setq-default initial-major-mode 'org-mode)
(setq-default major-mode 'org-mode)

;; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq-default tab-width 2)
;; Require newline at end of files
(setq require-final-newline t)

;; Echo keystroke with a shorter delay
(setq echo-keystrokes 0.1)

;; Automatically revert files when they are changed externally
(global-auto-revert-mode t)

;; Disable autosave and backups
(setq make-backup-files nil)
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))

;; help apropos will show everything, including functions
(setq apropos-do-all t)

;; Make emacs confirmation dialogs shorter
(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)

;; Save emacs' state upon closing
(setq desktop-save-mode 1)

;; Enable debug information on error
(setq debug-on-error t)

;; utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))


;; Keybindings
(define-key evil-normal-state-map "," 'universal-argument)
(evil-leader/set-key
  "s" (lambda () (interactive)
        (progn (delete-trailing-whitespace) (save-buffer)))
  "e" 'helm-find-files
  "b" 'helm-mini
  "w" 'delete-trailing-whitespace
  "i" (find-file-command user-init-file)
  "%" 'split-window-right
  "\"" 'split-window-below)
