# emacs-init

**TODO**: See how to use [company-box](https://github.com/sebastiencs/company-box).

## Install

First of all, stop Emacs: `C-x C-c`.  Then the steps are:

1. remove (or rename) .emacs and .emacs.d
2. clone emacs-init to .emacs.d
3. clone company-ml
4. install dired+
5. start Emacs with no config: "emacs -q"
6. execute the following in Emacs
7. stop then start again

In a (nut) shell:

    # 1. rename config files
    cd ~
    mv .emacs .emacs.ORIG
    mv .emacs.d .emacs.d.ORIG
    
    # 2. clone emacs-init
    git clone https://github.com/fgeorges/emacs-init.git .emacs.d
    
    # 3. clone company-marklogic
    cd ~/.emacs.d/elisp
    git clone https://github.com/fgeorges/company-marklogic.git
    
    # 4. install dired+
    mkdir diredp
    cd diredp
    wget https://www.emacswiki.org/emacs/download/dired%2b.el

Start Emacs, but with no config: `emacs -q`, and execute the following code (for
instance from `*scratch*`, using `C-x C-e`):

    (progn
      ;; check whether Git is intalled (error if it is not)
      (unless (equal 0 (shell-command "git --version"))
        (error "Git is not installed (at least not accessible from Emacs)"))

      ;; prepare packaging system (load, add MELPA, update)
      (require 'package)
      (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
      (package-initialize)
      (package-refresh-contents)

      ;; install all packages, leave trace in *Messages*
      (dolist (name '(company
              editorconfig
              hl-todo
              magit
              magit-todos
              markdown-mode
              no-littering
              org
              org-bullets
              restclient
              smart-mode-line
              smart-mode-line-powerline-theme
                      treemacs
              use-package
              xquery-mode))
        (if (package-installed-p name)
        (message "Package installed: %s" name)
          (message "Package not installed %s: installing now..." name)
          (package-install name))))

Then stop, and start again as normal.

## TODO

Try and intall packages `cider` and `oook` for MarkLogic support.
