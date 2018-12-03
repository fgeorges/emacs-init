;; .emacs.d/init/main - fgeorges
;;
;; depends on packages (or desired/common packages):
;;
;; - adoc-mode
;; - editorconfig
;; - hl-todo
;; - magit
;; - magit-todos
;; - markdown-mode
;; - org
;; - org-bullets
;; - restclient
;; - smart-mode-line                    (smart-mode-line-enable)
;; - smart-mode-line-powerline-theme    (powerline-default-theme)
;; - xquery-mode
;;
;; - cider, oook              # once I can make it work
;;
;; - dired+                   https://emacswiki.org/emacs/DiredPlus
;;                            ~/.emacs.d/elisp/diredp/diredp
;;
;; Font: "Office Code Pro D" (on Windows)
;; https://github.com/nathco/Office-Code-Pro
;; download the repo as ZIP, go to Fonts/Office Code Pro D/OTF, and for each,
;; double-click and then "install"
;;
;; In case I have problems with mlproj in eshell or ansi-term, have a look at:
;;
;;     '(ansi-color-faces-vector
;;       [default default default italic underline success warning error])

(set-language-environment "UTF-8")

;;; Package system

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

;; make sure packages are in the load path
(package-initialize)

(eval-when-compile
  (require 'use-package))

;;; No littering - require it as early as possible

(require 'no-littering)

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq custom-file
      (no-littering-expand-etc-file-name "custom.el"))
;; the above tells to save custom values in a file, but not to load it
(load custom-file)

;;; Local init file

;; yes, it is required (if not present, then we can assumed that the system has
;; not been properly configured for this init system)
(load "~/.emacs.d/init/local")

(if (string-equal system-type "windows-nt")
    (load "~/.emacs.d/init/windows"))

;;; Basics

(global-set-key [(meta down)] (lambda () (interactive) (scroll-up   1)))
(global-set-key [(meta up)]   (lambda () (interactive) (scroll-down 1)))

;; TODO: To review and organize (how does this fit with use-package?)
(setq default-input-method "latin-1-postfix")
(column-number-mode t)
(desktop-save-mode t)
;; TODO: ISwitch is obsolete, what to use then?
(iswitchb-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
;;(smart-yank-mode t)

(use-package dired+
  :load-path "~/.emacs.d/elisp/diredp")

(use-package esh-mode
  :hook (eshell-mode . (lambda ()
                         (setenv "TERM" "ansi")
                         (aset ansi-color-map 1 'bold))))

;;; Prog languages

(use-package hl-todo)

(use-package elisp-mode
  :hook (emacs-lisp-mode . hl-todo-mode))

(use-package js
  :mode ("\\.sjs\\'" . js-mode)
  :hook (js-mode . hl-todo-mode))

(use-package xquery-mode
  :hook (xquery-mode . hl-todo-mode)
  :config
  (setq xquery-indent-size 3)
  ;; The ELPA XQuery Mode package generates a lot of errors like:
  ;;     Invalid face reference: nxml-tag-slash-face
  ;; when displaying an XQuery bufer.  For the following faces.
  ;; Defining them as empty faces "fixes" the problem.
  ;; TODO: Report it, somewhere.  Not sure who maintains XQuery Mode,
  ;; if anyone.
  (defface nxml-element-prefix-face () "")
  (defface nxml-tag-slash-face () "")
  (defface nxml-element-colon-face () "")
  (defface nxml-element-local-name-face () ""))

;;; Org mode

(use-package org
  :config (require 'org-bullets)
  :hook (org-mode . org-bullets-mode))

;;; Dev tools

(use-package restclient
  ;; disable that stupid hack from restclient that prevents to use Digest Auth
  :config (ad-deactivate 'url-http-handle-authentication))

;; depends on fg:git-repo-dirs to be defined (in init/local.el)
(use-package magit
  :bind ("C-x g" . fg:magit-status-or-list)
  :init
  (defun fg:magit-status-or-list ()
    (interactive)
    (condition-case nil
        (magit-status)
      (magit-outside-git-repo (magit-list-repositories))))
  :config
  (global-magit-file-mode 1)
  (setq magit-repository-directories
	(mapcar
	 (lambda (proj) (cons proj 0))
	 fg:git-repo-dirs)))

;;; MarkLogic
;;
;; TODO: Have another look at...

;; (require 'oook-setup  "~/.emacs.d/elisp/oook-selector/oook-setup")
;; ;; default server configuration
;; (defvar drkm:conf/marklogic-host
;; ;;  "ml9ea4"
;;   "poh"
;;   "The host name of the MarkLogic instance to use from Emacs.")
;; (setq xdmp-servers
;;   `(:rest-server (:host ,drkm:conf/marklogic-host :port "8002" :user "admin" :password "admin")
;;     :xdbc-server (:host ,drkm:conf/marklogic-host :port "8000" :user "admin" :password "admin")))
;; ;; make sure that oook has our current XDBC server configuration
;; ;(xdmp-propagate-server-to-oook)

;;; Outro

;; Open my personal splash screen.
;; TODO: Disable the "standard" one.
(find-file "~/projects/fgeorges/notes/splash-screen.org")
