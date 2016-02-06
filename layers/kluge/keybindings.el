(global-set-key (kbd "<f2>") 'shell-pop-ansi-term)
(define-key evil-insert-state-map (kbd "<f5>") 'kluge-insert-date)

(bind-keys :map evil-motion-state-map
           ("ö w" . kluge-write-whole-file)
           ("ö W" . evil-write-all)
           ("ö b" . helm-mini)
           ("ö f" . spacemacs/helm-find-files)
           ("ö m" . imenu)
           ("M-j" . next-error)
           ("M-k" . previous-error))

(bind-keys :map evil-insert-state-map
          ("C-a" . spacemacs/smart-move-beginning-of-line)
          ("C-e" . end-of-line)
          ("C-k" . kill-line))
