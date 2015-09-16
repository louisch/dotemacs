;;; -*- lexical-binding: t -*-

(let ((default-directory user-emacs-directory))
  (normal-top-level-add-subdirs-to-load-path))

;; Not added to version control: system-local values for paths used in various
;; things.
(load "personal-dirs.el")
;; Utility files. Libraries and such.
(load "find-file-command.el")
(load "extra-sorting.el")
(load "funda-haxe-mode.el")
;; Modularized configuration files
(load "package-setup.el")
(load "package-config.el")
(load "mode-config.el")
(load "editor-config.el")
