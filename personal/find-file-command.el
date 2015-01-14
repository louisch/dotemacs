(defun find-file-command (a-file)
  "Return a command that will find the given file."
  (lambda () (interactive) (find-file a-file)))
