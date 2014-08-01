;;; Packages

(require 'cl)
(require 'package)
; List of package archives
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

; Initialise packages
(package-initialize)
(package-refresh-contents)


; Functions for installing and managing packages taken from Emacs Prelude
(defun packages-installed-p ()
  "Check if all packages in `my-packages' are installed."
  (every #'package-installed-p my-packages))
(defun require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package my-packages)
    (add-to-list 'my-packages package))
  (unless (package-installed-p package)
    (package-install package)))
(defun require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'require-package my-packages))
(defun install-packages ()
  "Install all packages listed in `my-packages'."
  (unless (packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Now refreshing package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (require-packages my-packages)))

;; Required packages:
(defvar my-packages
  '(ace-jump-mode
    ack-and-a-half
    anzu
    auto-complete
    evil
    evil-leader
    evil-paredit
    flx-ido
    flycheck
    git-timemachine
    gitignore-mode
    helm
    helm-projectile
    linum-relative
    magit
    paredit
    projectile
    saveplace
    smartparens
    solarized-theme
    yasnippet

    csharp-mode

    clojure-mode
    clojure-test-mode
    cider

    haskell-mode

    markdown-mode)
  "A list of packages to ensure are installed at launch")
; Install all above packages
(install-packages)


;; Package configuration:

; NOTE: Evil must be placed before anything else because the evil variables need
; to be set before any call to an evil function is made. Evil-leader/set-key is
; included in this requirement.

; Evil
; Provide vim keybindings to emacs
; The following variables should be set before evil is loaded via require
(setq-default evil-search-module 'evil-search
              evil-want-C-u-scroll t
              evil-want-C-w-in-emacs-state t)
(require 'evil)
(evil-mode 1)
; Enable evil-leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

; Ace Jump Mode
(evil-leader/set-key "<SPC>" 'ace-jump-mode)

; Ack-and-a-half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

; Anzu
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

; Auto-Complete
; Provide auto-complete for identifiers in a program
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-ignore-case t)

; flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

; Helm
; Save files in an index, as projects
(require 'helm-config)
; Enable helm from the get-go
(helm-mode 1)
; Reverse the bindings of persistent action and select action
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z")  'helm-select-action)
; Replace default commands with helm alternatives
(define-key evil-normal-state-map (kbd ";") 'helm-M-x)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
; Use more convenient binding for helm's kill ring
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
; Rebind helm's google suggest to a more convenient binding
(global-set-key (kbd "C-x c g") 'helm-google-suggest)
(evil-leader/set-key "g" 'helm-google-suggest)

; Linum
; Display line numbers
(require 'linum)
(require 'linum-relative)
(add-hook 'find-file-hook (lambda ()
                            (hl-line-mode)
                            (linum-mode)))

; Magit
; Provide an interface to git from emacs
(evil-leader/set-key "m" 'magit-status)

; Paredit
; Provide extra functionality for manipulating parentheses
(require 'evil-paredit)

; Projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

; Saveplace
; Save the location of point when closing the file
(require 'saveplace)
(setq-default saveplace t)
; Change the default save location to be in the user emacs directory
(setq save-place-file (concat user-emacs-directory "places"))

; Smartparens
; Provide several features for manipulating delimiter pairs, including parens
(smartparens-global-mode t)
(require 'smartparens-config)
; Show matching pairs when cursor is on one of them
(show-smartparens-global-mode t)
(setq sp-show-pair-from-inside t)
; Consider strings as sexps in smartparens in the following modes:
(nconc sp-navigate-consider-stringlike-sexp
       '(emacs-lisp-mode csharp-mode python-mode))

; Uniquify
; When two buffers have the same name, distinguish them by their containing
; directories
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

; YASnippet
; Provides snippets like Textmate. Use certain keywords and press TAB to expand
; into oft-used programming constructs.
(require 'yasnippet)
(yas-global-mode 1)


;; Language-specific:
; C Sharp
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
  (setq auto-mode-alist
     (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
(setq c-default-style '((csharp-mode . "c#")))
; Clojure
(add-hook 'clojure-mode-hook 'evil-paredit-mode)
; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
; Markdown
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;;; Core Configuration

;; Appearance
; Turn off toolbar and scrollbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
; Colorscheme
(require 'solarized-dark-theme)
; Line length of 79
(setq-default fill-column 79)
; Set frames to have width 84 (enough space to display 80 characters), and full
; screen height.
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(width . 84))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))
; Turn column numbers on in the modeline
(setq column-number-mode t)
; Show trailing whitespace
(setq show-trailing-whitespace t)

;; Behaviour
; Focus the initial window on startup
(x-focus-frame nil)
; Set an absolute backup directory, placing it in the emacs config dir
(setq backup-directory-alist
      (list (cons "." (concat user-emacs-directory "backups"))))
; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq tab-width 4
      c-basic-offset 4)
; Add custom plugins directory to load-path
(add-to-list 'load-path (concat user-emacs-directory "custom"))
; apropos will show everything, including functions
(setq apropos-do-all t)
; Rebind several common operations to use the leader key
(evil-leader/set-key
  "w" 'save-buffer
  "e" 'helm-find-files
  "b" 'helm-mini)
; Replace yes-or-no with y-or-n prompt
(fset 'yes-or-no-p 'y-or-n-p)
; Do not confirm when file or buffer does not exist
(setq confirm-nonexistent-file-or-buffer nil)
