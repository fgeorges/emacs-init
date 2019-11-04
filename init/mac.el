;; map the `command` key (both sides) to `M-` instead of `s-`
(setq mac-command-modifier 'meta)
;; map the `option` key (both sides) to `C-`
(setq mac-option-modifier 'control)

;; common implementation for `fg:dired-mac-browser` and `fg:dired-mac-explore`
(defun fg:dired-mac-broxplore (cmd)
  (mapc
   (lambda (path)
     (shell-command
      (concat cmd (shell-quote-argument path))))
   (dired-get-marked-files)))

;; equivalent to `dired-w32-browser` on Windows (open file in Dired using system app)
(defun fg:dired-mac-browser ()
  (interactive)
  (fg:dired-mac-broxplore "open "))

;; equivalent to `dired-w32explore` on Windows (open file in Dired using explorer/finder)
(defun fg:dired-mac-explore ()
  (interactive)
  (fg:dired-mac-broxplore "open -R "))

(define-key dired-mode-map (kbd "C-<return>") 'fg:dired-mac-explore)
(define-key dired-mode-map (kbd "M-<return>") 'fg:dired-mac-browser)
