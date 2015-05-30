;;; -*- lexical-binding: t -*-

;;; Mode-specific:

;; ANTLR
(setq auto-mode-alist
      (append '(("\\.g4$" . antlr-mode)) auto-mode-alist))

;; C
(require 'cc-mode)
(setq-default c-basic-offset 4)
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

;; Erlang
(require 'erlang-start)

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))
(require 'speedbar)
(speedbar-add-supported-extension ".hs")

;; Markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Writegood
(require 'writegood-mode)

;; Web Mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
