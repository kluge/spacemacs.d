(setq kluge-packages '(avy
                       cc-mode
                       dired+
                       evil
                       org))

(defun kluge/post-init-avy ()
  (define-key evil-motion-state-map (kbd "g SPC") 'avy-goto-char))

(defun kluge/post-init-cc-mode ()
   (c-add-style "kluge"
                '("stroustrup"
                  (c-offsets-alist
                   (innamespace . 0))))
   (setq c-default-style "kluge"))

(defun kluge/init-dired+ ()
  (use-package dired+
    :init
    (setq-default dired-listing-switches "-alh")
    (setq dired-recursive-copies 'always) ; Don't prompt for copying directories
    :config
    (define-key dired-mode-map (kbd "-") 'dired-up-directory)))

(defun kluge/post-init-evil ()
  ;; Don't override M-., it is useful. Rotate the repeat ring with C-, instead.
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-,") 'evil-repeat-pop-next))

(defun kluge/post-init-org ()
  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file "~/org/inbox.org")
  (setq org-refile-targets '((nil . (:maxlevel . 3))
                             (org-agenda-files . (:maxlevel . 1))))

  (setq org-todo-keywords
        '((sequence "TODO(t!)" "|" "DONE(d!)" "CANCELED(c@)")))
  ;; Log date when task state is changed
  (setq org-log-into-drawer t)

  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c c") 'org-capture)

  (setq org-capture-templates
        '(("t" "Todo" entry (file "~/org/inbox.org")
           "* TODO %?\n%U\n%i")
          ("l" "Todo with link" entry (file "~/org/inbox.org")
           "* TODO %?\n%U\n%i\n%a")
          ("n" "Note" entry (file "~/org/inbox.org")
           "* %?\n%U\n%i\n")
          ("m" "Note with link" entry (file "~/org/inbox.org")
           "* %?\n%U\n%i\n%a")
          ("j" "Journal" entry (file+datetree "~/journal/2015.org")
           "* %U\n%?")))

  ;; Start in insert state in capture mode
  (add-hook 'org-capture-mode-hook 'evil-insert-state)
  )
