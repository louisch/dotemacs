(require 'package)
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
			  ("melpa" . "http://melpa.milkbox.net/packages/")))

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

(require-package 'auto-complete)
(require-package 'evil)
(require-package 'haskell-mode)
(require-package 'linum-relative)
(require-package 'yasnippet)

(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)

; Evil
(require 'evil)
(evil-mode t)

; Auto-Complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-ignore-case t)

; YASnippet
(require 'yasnippet)
(yas-global-mode 1)

; Set an absolute backup directory, placing it in the emacs config dir
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

; Spaces only for indentation
(setq-default indent-tabs-mode nil)

; Linum
(require 'linum)
(require 'linum-relative)
(add-hook 'find-file-hook (lambda ()
                            (hl-line-mode)
                            (linum-mode)))
