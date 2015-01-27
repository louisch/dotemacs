;;; -*- lexical-binding: t -*-

(defun in-user-dir (dir-name)
  "Create path for directory inside user-emacs-directory."
  (concat user-emacs-directory (file-name-as-directory dir-name)))
(let ((lib-dir (in-user-dir "lib"))
      (personal-dir (in-user-dir "personal"))
      (org-dir (in-user-dir "org-config")))
  (add-to-list 'load-path lib-dir)
  (add-to-list 'load-path personal-dir)
  (add-to-list 'load-path org-dir))
;; Not added to version control: system-local values for paths used in various
;; things.
(load "personal-dirs.el")
;; Utility files. Libraries and such.
(load "find-file-command.el")
;; Modularized configuration files
(load "package-setup.el")
(load "package-config.el")
(load "mode-config.el")
(load "editor-config.el")

(require 'org-config-main)
