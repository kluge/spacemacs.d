(setq kluge-packages '(avy
                       cc-mode
                       dired+))

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
    (define-key dired-mode-map (kbd "-") 'dired-up-directory)))
