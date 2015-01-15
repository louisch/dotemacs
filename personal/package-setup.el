;;; -*- lexical-binding: t -*-

;;; Packages

;; Initialise el-get
(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path
             (concat user-emacs-directory "el-get-user/recipes"))
(setq el-get-verbose t)

(require 'el-get)
(require 'el-get-elpa)
;; Build the El-Get copy of the package.el packages if we have not
;; built it before.  Will have to look into updating later ...
(unless (file-directory-p el-get-recipe-path-elpa)
  (el-get-elpa-build-local-recipes))
;; Required packages:
(setq my-packages
      (append
       '(ace-jump-mode
         aggressive-indent-mode
         anzu
         auctex
         company-mode
         evil
         evil-leader
         evil-paredit
         fill-column-indicator
         flx-ido
         flycheck
         function-args
         git-timemachine
         god-mode
         golden-ratio
         helm
         jazz-theme
         linum-relative
         magit
         org-trello
         paredit
         projectile
         smartparens
         volatile-highlights
         w3m
         writegood-mode
         yasnippet

         csharp-mode
         clojure-mode
         cider
         elm-mode
         haskell-mode
         lua-mode
         markdown-mode)
       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

(el-get 'sync my-packages)
