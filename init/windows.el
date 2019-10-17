;; This file relies on the following variable to be defined:
;;
;; - fg:cmder-dir

;;; Windows fix

;; on some Windows, they set CP65001 instead of UTF-8
;; https://www.reddit.com/r/emacs/comments/98qq5k/invalid_coding_system_cp65001/e4ix4zt/
(define-coding-system-alias 'cp65001 'utf-8)

;;; Cmder

;; add cmder <http://cmder.net/> bin directory to the path to access programs
;; like grep, find and git, relies on `fg:cmder-dir'

(defvar fg:cmder-dir
  "The directory where Cmder is install, on Windows systems.")

(defvar fg:cmder-git-dir
  (concat fg:cmder-dir "vendor/git-for-windows/"))

;; TODO: Really, modify the $PATH envar?  Why not only `exec-path'?
(setenv "PATH"
  (concat
   fg:cmder-git-dir "bin;"
   fg:cmder-git-dir "usr/bin;"
   (getenv "PATH")))

;; magit needs git
(add-to-list 'exec-path (concat fg:cmder-git-dir "bin/"))
(add-to-list 'exec-path (concat fg:cmder-git-dir "usr/bin/"))
