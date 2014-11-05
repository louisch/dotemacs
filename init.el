;;; -*- lexical-binding: t -*-

(require 'cl)
(defvar personal-dir (concat user-emacs-directory "personal")
  "Directory containing personal configuration files to load at initialization.")
(add-to-list 'load-path personal-dir)
(load "package-setup.el")
(load "package-config.el")
(load "mode-config.el")
(load "editor-config.el")
(load "org-config.el")
