;; basis implementation for `fg:dired-linux-browser` (see `fg:dired-mac-broxplore`)
(defun fg:dired-linux-broxplore (cmd)
  (mapc
   (lambda (path)
     (shell-command
      (concat cmd (shell-quote-argument path))))
   (dired-get-marked-files)))

;; equivalent to `dired-w32-browser` on Windows (open file in Dired using system app)
;; see also `fg:dired-mac-browser`
(defun fg:dired-linux-browser ()
  (interactive)
  (fg:dired-linux-broxplore "open "))

;; There is no command to open files in the file explorer, as xdg-open does not support `-R`.
;; Should we xdg-open on the dirname, to open the file explorer on the right dir at least?
;;(defun fg:dired-linux-explore ()
;;  (interactive)
;;  (fg:dired-linux-broxplore "open -R "))

(with-eval-after-load "dired"
  (define-key dired-mode-map (kbd "M-<return>") 'fg:dired-linux-browser))
