;; Canning spam
(defun kluge-mu4e-headers-spam ()
  "Move the current message to spam folder."
  (interactive)
  (mu4e-mark-set 'move "/spam")
  (mu4e-headers-next))
(defun kluge-mu4e-view-spam ()
  "Move the current message to spam folder."
  (interactive)
  (mu4e~view-in-headers-context
   (mu4e-mark-set 'move "/spam"))
  (mu4e-view-headers-next))
