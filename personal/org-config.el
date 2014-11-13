;;; -*- lexical-binding: t -*-

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
(defvar today-plan-heading "Today's Plan"
  "The heading for a list planning today's events")
(defvar events-heading "Events"
  "The heading for a list of events that will take place in the future.")
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
      '((:startgroup)
        ("laptop" . ?l) ("desktop" . ?d) ("phone" . ?p)
        (:endgroup)
        (:startgroup)
        ("@campus" . ?c) ("@apartment" . ?a) ("@sheffield" . ?s)
        (:endgroup)
        ("low_energy" . ?o)))
;; Capture Templates
(let ((undecided-heading "Undecided")
      (shopping-list-heading "Shopping List"))
  (setq org-capture-templates
        `(("t" "Todo" entry (file+olp ,main-org-file
                                      ,tasks-heading ,undecided-heading)
           "* TODO %^{Action}%?\n%i")
          ("d" "Deadline" entry (file+olp ,main-org-file
                                          ,tasks-heading ,undecided-heading)
           "* TODO %^{Action}%?\nDEADLINE: %^t\n%i")
          ("e" "Event" entry (file+olp ,main-org-file
                                       ,tasks-heading ,events-heading)
           "* TODO %^{Action}%?\n%^t\n%i")
          ("t" "Todo" entry (file+olp ,main-org-file ,shopping-list-heading)
           "* TODO %^{Action}%?\n%i")
          ("p" "Plan Today" entry (file+olp ,main-org-file ,today-plan-heading)
           "* TODO %^{Action}%? %^t")
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
           "* %^{Someday/Maybe}%?\n%i"))))
;; Agenda Files
(setq org-agenda-files `(,main-org-file
                         ,reference-org-file
                         ,someday-file))
;; Global Properties
(setq org-global-properties
      '((Effort_ALL "0:10 0:30 1:00 2:00 3:00 4:00 5:00 6:00 7:00")))
(setq org-columns-default-format
      (concat "%25ITEM(Task) %TODO %TAGS(Context) "
              "%17Effort(Estimated Effort){:} %CLOCKSUM"))

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

;; Push to MobileOrg on exit
(add-hook 'kill-emacs-hook 'org-mobile-push)
