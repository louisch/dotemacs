;;; -*- lexical-binding: t -*-

;;; Packages

(require 'cl)
(require 'package)
;; List of package archives
                                        ; (add-to-list 'package-archives
                                        ;              '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; Initialise packages
(package-initialize)
(package-refresh-contents)


;; Functions for installing and managing packages taken from Emacs Prelude
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
    aggressive-indent
    anzu
    auto-complete
    auctex
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
    powerline
    powerline-evil
    projectile
    saveplace
    smartparens
    solarized-theme
    volatile-highlights
    yasnippet

    csharp-mode

    clojure-mode
    clojure-test-mode
    cider

    haskell-mode

    markdown-mode)
  "A list of packages to ensure are installed at launch")
;; Install all above packages
(install-packages)


;; Package configuration:

;; NOTE: Evil must be placed before anything else because the evil variables need
;; to be set before any call to an evil function is made. Evil-leader/set-key is
;; included in this requirement.
;;
;; Evil
;; Provide vim keybindings to emacs
;; The following variables should be set before evil is loaded via require
(setq-default evil-search-module 'evil-search
              evil-want-C-u-scroll t
              evil-want-C-w-in-emacs-state t)
(require 'evil)
(evil-mode 1)
;; Enable evil-leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

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
(add-to-list 'aggressive-indent-excluded-modes 'html-mode 'org-mode)

;; Anzu
(global-anzu-mode +1)
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t) ; Use pdfs rather than dvi files

;; Auto-Complete
;; Provide auto-complete for identifiers in a program
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(require 'auto-complete-config)
(ac-config-default)
(ac-linum-workaround)
(setq ac-ignore-case t)

;; flx
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;; Helm
;; Save files in an index, as projects
(require 'helm-config)
;; Enable helm from the get-go
(helm-mode 1)
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

;; Malabar Mode
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)
(require 'malabar-mode)
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))
(add-hook 'malabar-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'malabar-compile-file-silently
                      nil t)))

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


;;; Language-specific:

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


;;; Core Configuration

;; Support functions
(defun find-file-command (a-file)
  "Return a command that will find the given file."
  (lambda () (interactive) (find-file a-file)))

;; Appearance
;; Turn off toolbar and scrollbar
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; Line length of 79
(setq-default fill-column 79)
;; Custom theme
(load-theme 'solarized-dark t)
;; Set frames to have width 84 (enough space to display 80 characters), and full
;; screen height.
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(width . 84))
(add-to-list 'default-frame-alist '(fullscreen . fullheight))
;; Turn column numbers on in the modeline
(setq column-number-mode t)
;; Show trailing whitespace
(setq show-trailing-whitespace t)
;; Coding system
(prefer-coding-system 'utf-8)

;; Behaviour
;; Focus the initial window on startup
(x-focus-frame nil)
;; Set an absolute backup directory, placing it in the emacs config dir
(setq backup-directory-alist
      (list (cons "." (concat user-emacs-directory "backups"))))
;; Indentation
(setq-default indent-tabs-mode nil) ; Spaces only for indentation
(setq tab-width 4
      c-basic-offset 4)
;; Add custom plugins directory to load-path
(add-to-list 'load-path (concat user-emacs-directory "custom"))
;; apropos will show everything, including functions
(setq apropos-do-all t)
;; Rebind several common operations to use the leader key
(evil-leader/set-key
  "s" (lambda () (interactive)
        (progn (delete-trailing-whitespace) (save-buffer)))
  "e" 'helm-find-files
  "b" 'helm-mini)
;; Replace yes-or-no with y-or-n prompt
(fset 'yes-or-no-p 'y-or-n-p)
;; Do not confirm when file or buffer does not exist
(setq confirm-nonexistent-file-or-buffer nil)
;; Save emacs' state upon closing
(setq desktop-save-mode 1)
;; Enable debug information on error
(setq debug-on-error t)

;; Additional keybindings
(evil-leader/set-key
  "w" 'delete-trailing-whitespace
  "i" (find-file-command user-init-file)
  "%" 'split-window-right
  "\"" 'split-window-below)

;; ANTLR
(setq auto-mode-alist
      (append '(("\\.g4$" . antlr-mode)) auto-mode-alist))

;; C
(setq c-basic-offset 2)
(add-to-list 'c-default-style '(other . "k&r"))


;; Org Mode
(setq org-directory "~/org")
(defun make-org-file-path (org-file)
  "A function that gets the full path of a file in the org-directory.

Also adds the extension."
  (concat (file-name-as-directory org-directory) org-file ".org"))
;; Files and directories used by org
(setq org-mobile-directory
      (concat (file-name-as-directory org-directory) "MobileOrg"))
(defvar main-org-file (make-org-file-path "main")
  "The primary org file, containing, amongst other things, the next
actions that need to be done at some point.")
(defvar reference-org-file (make-org-file-path "reference")
  "Reference. Used for storing any information in text form. For example,
bills that need to be paid, or notes from an ongoing project.")
(defvar someday-file (make-org-file-path "someday")
  "List of things which will be done someday. Inactive actions that will be
considered for doing at some point.")
(setq org-default-notes-file main-org-file)
;; Headings that should be in main
(defvar tasks-heading "Tasks"
  "The heading for the list of next actions.")
(defvar projects-heading "Projects"
  "The heading for the list of projects ongoing.")
(defvar notes-heading "Journal"
  "The heading for the list of general text notes.")
(defvar bills-heading "Bills"
  "The heading for the list of bills.")
(defvar dates-heading "Calendar"
  "The heading for the list of notable dates.")
(defvar someday-heading "Someday/Maybe"
  "The heading for the list of items that are not ongoing, but may happen at
some point.")
;; Todo keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|"
                  "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")))
;; Tags
(setq org-tag-alist
      '((:startgroup . nil)
        ("laptop" . ?l) ("desktop" . ?d) ("phone" . ?p)
        (:endgroup . nil) (:newline . nil)
        (:startgroup . nil)
        ("@campus" . ?c) ("@apartment" . ?a) ("@sheffield" . ?s)
        (:endgroup . nil) (:newline . nil)
        ("low_energy" . ?o)))
;; Capture Templates
(setq org-capture-templates
      `(("t" "Todo" entry (file+headline ,main-org-file ,tasks-heading)
         "* TODO %^{Action}%?\n%i")
        ("d" "Deadline" entry (file+headline ,main-org-file ,tasks-heading)
         "* TODO %^{Action}%?\nDEADLINE: %^t\n%i")
        ("e" "Event" entry (file+headline ,main-org-file ,tasks-heading)
         "* TODO %^{Action}%?\n%^t\n%i")
        ("w" "Waiting" entry (file+headline ,main-org-file ,tasks-heading)
         "* WAITING %^{Action}%?\n%i")
        ("p" "Project" entry
         (file+headline ,(make-org-file-path "projects") ,projects-heading)
         "* %^{Project}\n** Next actions\n- %?\n%i")
        ("r" "For entering something into the reference")
        ("rn" "Note" entry (file+headline ,reference-org-file ,notes-heading)
         "* %^{Note}%?\n%T\n%i")
        ("rp" "Pasted note" entry (file+headline ,reference-org-file
                                                 ,notes-heading)
         "* %^{Name of Note}%?\n%T\n%x")
        ("rb" "Bill" entry (file+headline ,reference-org-file ,bills-heading)
         "* %^{Bill}%?\n%^t")
        ("rc" "Notable date" entry
         (file+headline ,reference-org-file ,dates-heading)
         "* %^{Name of notable date}%?\n%T\n%i")
        ("m" "Someday/Maybe" entry
         (file+headline ,someday-file ,someday-heading)
         "* %^{Someday/Maybe}%?\n%i")))
;; Agenda Files
(setq org-agenda-files `(,main-org-file
                         ,reference-org-file
                         ,someday-file))

;; Keybindings
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c l") 'org-store-link)
(evil-leader/set-key
  "o" (find-file-command main-org-file))
;; Use indentation form to display headlines
(add-hook 'org-mode-hook 'org-indent-mode)

;; Pull from MobileOrg on startup
(require 'org-mobile)
(add-hook 'after-init-hook 'org-mobile-pull)

;; Push to MobileOrg when saving org files
(add-hook
 'after-save-hook
 (lambda ()
   (let (;; The filenames inside the org-directory, without their path prefixes.
         (org-filenames (mapcar 'file-name-nondirectory
                                (directory-files org-directory)))
         ;; The filename of the buffer being saved, without its path prefix.
         (buffer-filename (file-name-nondirectory buffer-file-name)))
     (if (find buffer-filename org-filenames :test #'string=)
         (org-mobile-push)))))
