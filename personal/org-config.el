;;; -*- lexical-binding: t -*-

;; Org Mode
(defun make-org-file-path (org-file)
  "A function that gets the full path of a file in the org-directory.

Also adds the extension."
  (concat (file-name-as-directory org-directory) org-file ".org"))
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
(setq org-tag-alist
      '((:startgroup)
        ("laptop" . ?l) ("desktop" . ?d) ("phone" . ?p)
        (:endgroup)
        (:startgroup)
        ("@campus" . ?c) ("@apartment" . ?a) ("@sheffield" . ?s)
        (:endgroup)
        ("low_energy" . ?o)))
;; Capture Templates
(setq org-capture-templates
      `(("t" "todo" entry (file (make-org-file-path "refile")
				"* TODO %?\n%U\n%a\n"
				:clock-in t :clock-resume t))
	("r" "respond" entry
	 (file (make-org-file-path "refile")
	       (concat "* NEXT Respond to %:from on %:subject\n"
		       "SCHEDULED: %t\n%U\n%a\n")
	       :clock-in t :clock-resume t :immediate-finish t))
	("n" "note" entry (file (make-org-file-path "refile")
				"* %? :NOTE:\n%U\n%a\n"
				:clock-in t :clock-resume t))
	("j" "Journal" entry
	 (file+datetree (make-org-file-path "diary")
			"* %?\n%U\n" :clock-in t :clock-resume t))
	("h" "Habit" entry
	 (file (make-org-file-path "refile")
	       (concat "* NEXT %?\n%U\n%a\n"
		       "SCHEDULED: %(format-time-string "
		       "\"<%Y-%m-%d %a .+1d/3d>\")\n"
		       ":PROPERTIES:\n:STYLE: habit\n"
		       ":REPEAT_TO_STATE: NEXT\n:END:\n")))))
;; Agenda Files
(setq org-agenda-files `(,org-directory))
(setq org-agenda-compact-blocks t)
(setq org-agenda-custom-commands
      '((" " "Agenda"
         ((agenda "" nil)
          (tags "REFILE"
                ((org-agenda-overriding-header "Tasks to Refile")
                 (org-tags-match-list-sublevels nil)))))))
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

;; Keybindings
(define-key global-map (kbd "C-c a") 'org-agenda)
(define-key global-map (kbd "C-c b") 'org-iswitchb)
(define-key global-map (kbd "C-c c") 'org-capture)
(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c o")
  (find-file-command (make-org-file-path "refile")))
;; Use indentation form to display headlines
(add-hook 'org-mode-hook 'org-indent-mode)

;; Minor modes to activate with org mode
(add-hook 'org-mode-hook 'writegood-mode)

;; Remove empty LOGBOOK drawers on clock out
(defun remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point))))

(add-hook 'org-clock-out-hook
	  'remove-empty-drawer-on-clock-out 'append)
