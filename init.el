;;; Packages

(require 'package)
; List of package archives
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

; from purcell/emacs.d
(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION. If NO-REFRESH is
non-nil, the available package lists will not be re-downloaded in order to
locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
	(package-install package)
      (progn
	(package-refresh-contents)
	(require-package package min-version t)))))

; Initialise packages
(package-initialize)
(package-refresh-contents)

;; Required packages:
; Core
(require-package 'ack-and-a-half)
(require-package 'auto-complete)
(require-package 'evil)
(require-package 'evil-leader)
(require-package 'flx-ido)
(require-package 'helm)
(require-package 'helm-projectile)
(require-package 'linum-relative)
(require-package 'paredit)
(require-package 'evil-paredit)
(require-package 'projectile)
(require-package 'saveplace)
(require-package 'solarized-theme)
(require-package 'yasnippet)
; C Sharp
(require-package 'csharp-mode)
; Clojure
(require-package 'clojure-mode)
(require-package 'clojure-test-mode)
(require-package 'cider)
; Haskell
(require-package 'haskell-mode)


;; Package configuration:

; Ack-and-a-half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

; Auto-Complete
; Provide auto-complete for identifiers in a program
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-ignore-case t)

; Evil
; Provide vim keybindings to emacs
(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)
(require 'evil)
(evil-mode t)
; Enable evil-leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

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

; Linum
; Display line numbers
(require 'linum)
(require 'linum-relative)
(add-hook 'find-file-hook (lambda ()
                            (hl-line-mode)
                            (linum-mode)))

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
; Show matching parenthesis when cursor is on a parenthesis
(show-paren-mode 1)
; apropos will show everything, including functions
(setq apropos-do-all t)
; Rebind several common operations to use the leader key
(evil-leader/set-key
  "w" 'write-file
  "e" 'find-file
  "b" 'helm-mini)
