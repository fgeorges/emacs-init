;; .emacs.d/init/main - fgeorges
;;
;; Depends on packages (or desired/common packages):
;;
;; - adoc-mode
;; - company
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
;; - treemacs
;; - use-package
;; - xquery-mode
;;
;; And also:
;;
;; - cider, oook              once I can make it work
;; - dired+                   https://emacswiki.org/emacs/DiredPlus
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

(setq server-auth-dir (no-littering-expand-var-file-name "server/"))

(setq custom-file
      (no-littering-expand-etc-file-name "custom.el"))
;; the above tells to save custom values in a file, but not to load it
(load custom-file)

;;; Local init file

(load "~/.emacs.d/init/local" t)

(cond
 ((string-equal system-type "darwin")
  (load "~/.emacs.d/init/mac" t))
 ((string-equal system-type "windows-nt")
  (load "~/.emacs.d/init/windows" t)))

;;; Basics

(set-face-attribute 'default nil :background "#002b36")

(global-set-key (kbd "M-<down>") (lambda () (interactive) (scroll-up   1)))
(global-set-key (kbd "M-<up>")   (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "C-<")      (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C->")      (lambda () (interactive) (other-window  1)))

;; TODO: To review and organize (how does this fit with use-package?)
(setq default-input-method "latin-1-postfix")
(column-number-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(desktop-save-mode t)
(setq-default indent-tabs-mode nil)
;; TODO: ISwitch is obsolete, what to use then?
(iswitchb-mode t)
;;(smart-yank-mode t)

;; the mode line appearance
(smart-mode-line-enable)
(powerline-default-theme)

;; custom extensions
(add-to-list 'auto-mode-alist '("\\.xar\\'" . archive-mode))
(add-to-list 'auto-mode-alist '("\\.xaw\\'" . archive-mode))

;; https://emacswiki.org/emacs/DiredPlus
(use-package dired+
  :load-path "~/.emacs.d/elisp/diredp")

(use-package esh-mode
  :hook (eshell-mode . (lambda ()
                         (setenv "TERM" "ansi")
                         (aset ansi-color-map 1 'bold))))

(use-package editorconfig
  :config
  (editorconfig-mode 1)
  (setq editorconfig-mode-lighter " ECfg"))

(use-package treemacs
  :bind ("C-x t" . treemacs)
  :bind (:map treemacs-mode-map
              ("B"       . treemacs-bookmark)
              ("<prior>" . nil)
              ("<next>"  . nil)))

;;; Prog languages

(use-package hl-todo
  :hook   ((emacs-lisp-mode js-mode python-mode xquery-mode) . hl-todo-mode)
  :config (add-to-list 'hl-todo-keyword-faces '("DEBUG" . "#ff3c8a")))

(require 'subr-x) ;; required by company, and seems not to be defined if not loaded here?
(use-package company
  :hook ((emacs-lisp-mode js-mode python-mode xquery-mode) . company-mode)
  :config (setq company-lighter " Cpny")
  :custom-face
  (company-preview
   ((t (:inherit default :foreground "darkgray" :height 110))))
  (company-preview-common
   ((t (:inherit default :foreground "bisque1" :distant-foreground "blue"))))
  (company-tooltip
   ((t (:inherit company-preview :background "lightgray" :foreground "black"))))
  (company-tooltip-selection
   ((t (:inherit company-preview :background "steelblue" :foreground "white"))))
  (company-tooltip-common
   ((((type x)) (:inherit company-tooltip :foreground "white" :background "olive drab"))
    (t (:inherit company-tooltip))))
  (company-tooltip-common-selection
   ((((type x)) (:inherit company-tooltip-selection :background "blue"))
    (t (:inherit company-tooltip-selection))))
  (company-tooltip-annotation
   ((t (:inherit company-tooltip :foreground "saddle brown"))))
  (company-tooltip-annotation-selection
   ((t (:inherit company-tooltip-selection :foreground "sandy brown")))))

(use-package company-marklogic
  :load-path "~/.emacs.d/elisp/company-marklogic/src"
  :config
  (add-to-list 'company-backends 'company-marklogic-sjs)
  (add-to-list 'company-backends 'company-marklogic-xqy))

(use-package elisp-mode
  :hook (emacs-lisp-mode-hook . (lambda ()
                                  (setq mode-name "ELisp"))))

(use-package js
  :mode ("\\.sjs\\'" . js-mode)
  :hook (js-mode . (lambda ()
                     (setq mode-name "JS"))))

(use-package xquery-mode
  :mode "\\.\\(xq\\|xqy\\|xquery\\)\\'"
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
  :config
  ;; use :config rather than :bind here, as we need to lookup keys
  ;; map M-S-<down> (resp. <up>) to what's in M-<down> (today, it's org-metadown)
  (bind-key "M-S-<down>" (lookup-key org-mode-map (kbd "M-<down>")) org-mode-map)
  (bind-key "M-S-<up>"   (lookup-key org-mode-map (kbd "M-<up>"))   org-mode-map)
  ;; use the global binding for M-<down> (resp. <up>): my own lambdas
  (bind-key "M-<down>" nil org-mode-map)
  (bind-key "M-<up>"   nil org-mode-map))

(use-package org-agenda
  :config
  ;; see explanations for the similar config for package 'org
  (bind-key "M-S-<down>" (lookup-key org-agenda-mode-map (kbd "M-<down>")) org-agenda-mode-map)
  (bind-key "M-S-<up>"   (lookup-key org-agenda-mode-map (kbd "M-<up>"))   org-agenda-mode-map)
  (bind-key "M-<down>" nil org-agenda-mode-map)
  (bind-key "M-<up>"   nil org-agenda-mode-map))

(use-package org-bullets
  :hook ((org-mode) . org-bullets-mode))

;;; Dev tools

(use-package restclient
  ;; disable that stupid hack from restclient that prevents to use Digest Auth
  :config (ad-deactivate 'url-http-handle-authentication))

(defvar fg:git-repo-dirs
  "The list of all Git repositories on this system.

A Git repo is a directory, the one containing the subdir `.git/'.
This list is used to initialize the list of repos for Magit.  You
can use the following command to find them all under your home
dir:

    $ find /home/me/ -name 'applypatch-ms*'")

;; make sure to store necessary tokens for Magit, from various forges, see:
;; https://magit.vc/manual/ghub/Storing-a-Token.html, you can also use:
;; `git config --global credential.helper cache`
;;
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
(find-file "~/projects/fgeorges/notes/splash-screen.org")
