;;; -*- lexical-binding: t -*-

;;; Packages

(require 'cl)
(require 'package)
;; List of package archives
                                        ; (add-to-list 'package-archives
                                        ;              '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

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
(defun try-install-packages ()
  "Install any packages listed in `my-packages' if not installed."
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
    elm-mode
    evil
    evil-leader
    evil-paredit
    fill-column-indicator
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
    w3m
    yasnippet

    csharp-mode
    clojure-mode
    clojure-test-mode
    cider
    haskell-mode
    lua-mode
    markdown-mode)
  "A list of packages to ensure are installed at launch")
;; Install all above packages
(try-install-packages)
