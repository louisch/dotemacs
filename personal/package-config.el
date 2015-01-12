;;; -*- lexical-binding: t -*-

;;; Package configuration:

;; NOTE: Evil must be placed before anything else because the evil variables
;; need to be set before any call to an evil function is made.
;; Evil-leader/set-key is included in this requirement.
;;
;; Evil
;; Provide vim keybindings to emacs
;; The following variables should be set before evil is loaded via require
(setq-default evil-search-module 'evil-search
              evil-want-C-u-scroll t
              evil-want-C-w-in-emacs-state t)
(require 'evil)
;; Enable evil-leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
;; Fine grained undo
(setq evil-want-fine-undo t)
;; < and > shift width
(setq-default evil-shift-width 2)
;; Configure searching
(setq evil-regex-search t)
(setq evil-search-wrap t)
;; Use C-u for scrolling
(setq evil-want-C-u-scroll t)
;; Rebind C-h h so that HELLO buffer doesn't get opened accidentally
(define-key evil-normal-state-map (kbd "C-h h") 'evil-backward-char)

;; Ace Jump Mode
(evil-leader/set-key "<SPC>" 'ace-jump-mode)

;; Ack-and-a-half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; Aggressive Indent
(global-aggressive-indent-mode 1)
;; List of modes to not use aggressive indent in.
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)
(add-to-list 'aggressive-indent-excluded-modes 'org-mode)
(add-to-list 'aggressive-indent-excluded-modes 'haskell-mode)

;; Anzu
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t) ; Use pdfs rather than dvi files

;; Company Mode
(global-company-mode)

;; ERC
;; Load ERC
(require 'erc)
;; Modules
(setq erc-modules'(autojoin button completion dcc fill irccontrols list match
                            menu move-to-prompt netsplit networks noncommands
                            notifications readonly ring services smiley stamp
                            track))
(defvar rizon-username "louisch"
  "The username to use for connecting to Rizon.")
(defvar rizon-nickserv-password ""
  "The password to use for authenticating with Rizon nickserv.")
;; Load authentication info from an external source.  Put sensitive
;; passwords and the like in here.
(load (concat user-emacs-directory "erc-auth.el"))
;; Load nickserv data
(setq erc-nick rizon-username)
(setq erc-nickserv-passwords
      `((rizon ((,rizon-username . ,rizon-nickserv-password)))))
(setq erc-prompt-for-nickserv-password nil)
;; This causes ERC to connect to the Rizon network upon hitting C-c e f.
(global-set-key (kbd "C-c e r") (lambda () (interactive)
                                  (erc :server "irc.rizon.net" :port "6667"
                                       :nick rizon-username)))
;; Channels to autojoin
(setq erc-autojoin-channels-alist
      '(("irc.rizon.net" "#horriblesubs" "#nipponsei")))
;; Interpret mIRC-style color commands in IRC chats
(setq erc-interpret-mirc-color t)

;; Fill Column Indicator
(require 'fill-column-indicator)
(add-hook 'org-mode-hook 'fci-mode)
(add-hook 'markdown-mode-hook 'fci-mode)
(add-hook 'prog-mode-hook 'fci-mode)

;; flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;; Function Args
(require 'cc-mode)
(require 'function-args)
(fa-config-default)
(define-key c-mode-map (kbd "C-<tab>") 'moo-complete)
(define-key c++-mode-map (kbd "C-<tab>") 'moo-complete)
(define-key c-mode-map (kbd "M-o") 'fa-show)
(define-key c++-mode-map (kbd "M-o") 'fa-show)

;; God Mode
(require 'god-mode)
(global-set-key (kbd "<escape>") 'god-local-mode)

;; Helm
;; Save files in an index, as projects
(require 'helm-config)
;; Enable helm from the get-go
(helm-mode 1)
(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
;; Reverse the bindings of persistent action and select action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
;; Replace default commands with helm alternatives
(define-key evil-normal-state-map (kbd ";") 'helm-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
;; Use more convenient binding for helm's kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; Rebind helm's google suggest to a more convenient binding
(global-set-key (kbd "C-x c g") 'helm-google-suggest)
(evil-leader/set-key "g" 'helm-google-suggest)

;; Linum
;; Display line numbers
(require 'linum)
(require 'linum-relative)
(add-hook 'find-file-hook (lambda ()
                            (hl-line-mode)
                            (linum-mode)))

;; Magit
;; Provide an interface to git from emacs
(evil-leader/set-key "m" 'magit-status)

;; Paredit
;; Provide extra functionality for manipulating parentheses
(require 'evil-paredit)

;; Powerline
(require 'powerline)
(powerline-evil-center-color-theme)
(require 'powerline-evil)

;; Projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

;; Saveplace
;; Save the location of point when closing the file
(require 'saveplace)
(setq-default saveplace t)
;; Change the default save location to be in the user emacs directory
(setq save-place-file (concat user-emacs-directory "places"))

;; Semantic
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

;; Smartparens
;; Provide several features for manipulating delimiter pairs, including parens
(smartparens-global-mode t)
(require 'smartparens-config)
;; Show matching pairs when cursor is on one of them
(show-smartparens-global-mode t)
(setq sp-show-pair-from-inside t)
;; Consider strings as sexps in smartparens in the following modes:
(nconc sp-navigate-consider-stringlike-sexp
       '(emacs-lisp-mode csharp-mode python-mode))
;; Keybindings for Smartparens, for evil
(define-key evil-normal-state-map (kbd "C-M-f") 'sp-forward-sexp)
(define-key evil-normal-state-map (kbd "C-M-b") 'sp-backward-sexp)
(define-key evil-normal-state-map (kbd "C-M-d") 'sp-down-sexp)
(define-key evil-normal-state-map (kbd "C-M-a") 'sp-backward-down-sexp)
(define-key evil-normal-state-map (kbd "C-S-a") 'sp-beginning-of-sexp)
(define-key evil-normal-state-map (kbd "C-S-d") 'sp-end-of-sexp)
(define-key evil-normal-state-map (kbd "M-<backspace>") 'sp-unwrap-sexp)

;; TRAMP
(require 'em-tramp)
(setq eshell-prefer-lisp-functions t)
(setq eshell-prefer-lisp-variables t)
(setq password-cache t)
(setq password-cache-expiry 60)

;; Uniquify
;; When two buffers have the same name, distinguish them by their containing
;; directories
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Volatile Highlights
(require 'volatile-highlights)
(volatile-highlights-mode t)
(vhl/define-extension 'yank 'evil-paste-after 'evil-paste-before)

;; YASnippet
;; Provides snippets like Textmate. Use certain keywords and press TAB to expand
;; into oft-used programming constructs.
(require 'yasnippet)
(yas-global-mode 1)
