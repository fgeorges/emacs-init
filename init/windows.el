;; This file relies on the following variable to be defined:
;;
;; - fg:cmder-dir

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
