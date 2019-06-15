# emacs-init

**TODO**: See how to use [company-box](https://github.com/sebastiencs/company-box).

## Install

First of all, install packages from MELPA.  You have to evaluate the following
line from `*scratch*` (using `C-x C-e`) or from the mini-buffer (using `M-:`):

    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

You can then use `M-x list-packages` to install the following packages (press
`i` to mark them to install, then `x` once they are all marked):

- company
- magit
- no-littering
- restclient
- use-package

Install `company-ml` by cloning the repo:

    mkdir ~/.emacs.d/elisp
    cd ~/.emacs.d/elisp
    git clone https://github.com/fgeorges/company-ml.git

Install `dired+` by downloading https://www.emacswiki.org/emacs/download/dired%2b.el
to `~/.emacs.d/elisp/diredp/dired+.el`.
