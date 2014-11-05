;;; -*- lexical-binding: t -*-

;;; Mode-specific:

;; ANTLR
(setq auto-mode-alist
      (append '(("\\.g4$" . antlr-mode)) auto-mode-alist))

;; C
(setq c-basic-offset 2)
(add-to-list 'c-default-style '(other . "k&r"))

;; C Sharp
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(setq c-default-style '((csharp-mode . "c#")))
(add-to-list 'ac-modes 'csharp-mode)

;; Clojure
(add-hook 'clojure-mode-hook 'evil-paredit-mode)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
