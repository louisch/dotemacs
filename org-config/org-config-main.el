;;; -*- lexical-binding: t -*-

;; Org Mode

;; Requires and utility functions
(require 'bh/org-utils)
(require 'louisch/org-agenda-config)
(defun make-org-file-path (org-file)
  "A function that gets the full path of a file in the org-directory.
Also adds the extension."
  (concat (file-name-as-directory org-directory) org-file ".org"))

;; Modules
(push 'org-habit org-modules)
;; position the habit graph on the agenda to the right of the default
(setq org-habit-graph-column 50)

;; Keybindings
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c o")
  (find-file-command (make-org-file-path "refile")))
(define-key global-map (kbd "C-c n") 'bh/org-todo)

;; Minor modes to activate with org mode
;; Use indentation form to display headlines
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'writegood-mode)

;; Files and directories used by org
(defvar refile-file (make-org-file-path "refile")
  "General purpose file for capturing.")
(setq org-default-notes-file refile-file)

;; Todo keywords
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
(setq org-todo-state-tags-triggers
      '(("CANCELLED" ("CANCELLED" . t))
        ("WAITING" ("WAITING" . t))
        ("HOLD" ("WAITING") ("HOLD" . t))
        (done ("WAITING") ("HOLD"))

        ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
        ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
        ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))

;; Tags
;; Some, such as CANCELLED, are set by changing todo-state.
;; Others, such as PERSONAL, are set by FILETAGS
(setq org-tag-alist
      '((:startgroup)
        ("@london" . ?l) ("@apartment" . ?a) ("@sheffield" . ?s)
        (:endgroup)
        ("CANCELLED" . ?c)
        ("WAITING" . ?c)
        ("HOLD" . ?h)
        ("PERSONAL" . ?p)
        ("WORK" . ?w)))
(setq org-fast-tag-selection-single-key t)

;; Capture
(setq org-capture-templates
      `(("t" "todo" entry (file (make-org-file-path "refile"))
         "* TODO %?\n%U\n%a\n"
         :clock-in t :clock-resume t)
        ("r" "respond" entry
         (file (make-org-file-path "refile"))
         (concat "* NEXT Respond to %:from on %:subject\n"
                 "SCHEDULED: %t\n%U\n%a\n")
         :clock-in t :clock-resume t :immediate-finish t)
        ("n" "note" entry (file (make-org-file-path "refile"))
         "* %? :NOTE:\n%U\n%a\n"
         :clock-in t :clock-resume t)
        ("j" "Journal" entry
         (file+datetree (make-org-file-path "diary"))
         "* %?\n%U\n" :clock-in t :clock-resume t)
        ("h" "Habit" entry
         (file (make-org-file-path "refile"))
         (concat "* NEXT %?\n%U\n%a\n"
                 "SCHEDULED: %(format-time-string "
                 "\"<%Y-%m-%d %a .+1d/3d>\")\n"
                 ":PROPERTIES:\n:STYLE: habit\n"
                 ":REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Global Properties
(setq org-global-properties
      '((Effort_ALL "1:00 2:00 3:00 4:00 5:00 6:00 7:00 0:10 0:30")))
(setq org-columns-default-format
      (concat "%25ITEM(Task) %TODO %TAGS(Context) "
              "%17Effort(Estimated Effort){:} %CLOCKSUM"))

;; Refiling
;;; Targets include this file and any file contributing to the agenda
;;; - up to 9 levels deep
(setq org-refile-targets '((nil :maxlevel . 9)
                           (org-agenda-files :maxlevel . 9)))
(setq org-refile-use-outline-path t)
(setq org-refile-allow-creating-parent-nodes 'confirm)

;; Clocking
;; Persistent clocking
(org-clock-persistence-insinuate)
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

;; Projects
;; Disable org's default stuck projects definition
(setq org-stuck-projects (quote ("" nil nil "")))

;; File structure settings
(setq org-hide-leading-stars t)
(setq org-startup-indented t)

(provide 'org-config-main)
