(setq mu4e-kluge-packages '(mu4e))

(defun mu4e-kluge/pre-init-mu4e ()
  ;; Basic options
  (setq mu4e-maildir "/home/kluge/maildir-kapsi")
  (setq mu4e-attachment-dir "~/incoming")

  (setq mu4e-sent-folder   "/sent"
        mu4e-drafts-folder "/drafts"
        mu4e-trash-folder  "/trash"
        mu4e-refile-folder "/archive")

  ;; Don't run a mail command, just update index
  (setq mu4e-get-mail-command "true")
  ;; Update the index every 5 minutes
  (setq mu4e-update-interval 300)

  (setq mu4e-confirm-quit nil)

  (setq message-send-mail-function 'smtpmail-send-it
        smtpmail-smtp-server        "mail.kapsi.fi"
        smtpmail-stream-type        'starttls
        smtpmail-smtp-service       587)

  ;; Private options
  (add-hook 'mu4e-main-mode-hook (lambda ()
                                   (load-file "~/.spacemacs.d/layers/mu4e-kluge/mu4e-kluge-private.el.gpg")))

  ;; UI options
  (setq mu4e-view-show-addresses t)
  (setq mu4e-headers-time-format "%T")
  (setq mu4e-headers-date-format "%Y-%m-%d")
  (setq mu4e-date-format-long "%A %Y-%m-%d %T %z (%Z)")

  ;; Pick HTML over plaintext less often
  (setq mu4e-view-html-plaintext-ratio-heuristic 50)

  ;; Don't keep sent message buffers around
  (setq message-kill-buffer-on-exit t)

  (spacemacs|use-package-add-hook mu4e
    :post-config
    ;; Use f for going to a folder
    (define-key mu4e-main-mode-map (kbd "f") 'mu4e~headers-jump-to-maildir)
    (define-key mu4e-headers-mode-map (kbd "f") 'mu4e~headers-jump-to-maildir)
    (define-key mu4e-view-mode-map (kbd "f") 'mu4e~headers-jump-to-maildir)

    ;; j and k for switching between messages even from view
    (evilified-state-evilify-map mu4e-view-mode-map
      :mode mu4e-view-mode
      :bindings
      (kbd "j") 'mu4e-view-headers-next
      (kbd "k") 'mu4e-view-headers-prev)

    (define-key mu4e-headers-mode-map (kbd "c") 'kluge-mu4e-headers-spam)
    (define-key mu4e-view-mode-map (kbd "c") 'kluge-mu4e-view-spam)))

