;;; -*- lexical-binding: t -*-

;;; Mode-specific:

;; ANTLR
(setq auto-mode-alist
      (append '(("\\.g4$" . antlr-mode)) auto-mode-alist))

;; C
(require 'cc-mode)
(setq c-basic-offset 2)
(add-to-list 'c-default-style '(other . "k&r"))

;; C++
(require 'cc-mode)
(add-hook 'c-mode-common-hook 'semantic-mode)

(setq gdb-many-windows t
      gdb-show-main t)

;; C Sharp
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(setq c-default-style '((csharp-mode . "c#")))

;; Clojure
(add-hook 'clojure-mode-hook 'evil-paredit-mode)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))
(require 'speedbar)
(speedbar-add-supported-extension ".hs")

;;; Keybindings
(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)

;; Markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
