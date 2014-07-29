(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

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

(package-initialize)
(package-refresh-contents)

;; Required packages:
; Core
(require-package 'ack-and-a-half)
(require-package 'auto-complete)
(require-package 'evil)
(require-package 'flx-ido)
(require-package 'helm)
(require-package 'helm-projectile)
(require-package 'linum-relative)
(require-package 'paredit)
(require-package 'evil-paredit)
(require-package 'projectile)
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


;; Appearance
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
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq tab-width 4)
(setq c-basic-offset 4)
; Add custom plugins directory to load-path
(add-to-list 'load-path "~/.emacs.d/custom")


;; Packages configuration:

; Ack-and-a-half
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

; Auto-Complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-ignore-case t)

; Evil
(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)
(require 'evil)
(evil-mode t)

; flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

; Helm
(require 'helm-config)

; helm-projectile
(global-set-key (kbd "C-c h") 'helm-projectile)

; Linum
(require 'linum)
(require 'linum-relative)
(add-hook 'find-file-hook (lambda ()
                            (hl-line-mode)
                            (linum-mode)))

; Paredit
(require 'evil-paredit)

; Projectile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

; YASnippet
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
