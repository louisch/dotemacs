;;; -*- lexical-binding: t -*-

(require 'toggle-window-split)

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
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Theme
(load-theme 'jazz t)

;; Force vertical split
(setq split-width-threshold 0)


;; Behaviour

;; Startup screen
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

;; Default mode
(setq-default initial-major-mode 'org-mode)
(setq-default major-mode 'org-mode)

;; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq-default tab-width 4)
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

;; Enable debug information on error
(setq debug-on-error t)

;; utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; Keybindings
(define-key evil-normal-state-map "," 'universal-argument)
(global-set-key (kbd "C-c i") (find-file-command user-init-file))
(global-set-key (kbd "C-c %") 'split-window-right)
(global-set-key (kbd "C-c \"") 'split-window-below)
(evil-leader/set-key
  "w" 'delete-trailing-whitespace)
