(define-key evil-insert-state-map (kbd "<f5>") 'kluge-insert-date)

(bind-keys :map evil-motion-state-map
           ("ö w" . kluge-write-whole-file)
           ("ö W" . evil-write-all)
           ("ö b" . helm-mini)
           ("ö f" . spacemacs/helm-find-files))
