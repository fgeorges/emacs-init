(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (misterioso)))
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate" "-n256")))
 '(package-selected-packages
   (quote
    (treemacs treemacs-magit org org-bullets company use-package no-littering magit-todos minions hl-todo smart-mode-line-powerline-theme smart-mode-line xquery-mode restclient names markdown-mode magit icicles editorconfig crappy-jsp-mode cider ascii adoc-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((default :background "#002b36")))
 '(company-preview ((t (:inherit default :foreground "darkgray" :height 110))))
 '(company-preview-common ((t (:inherit default :foreground "bisque1" :distant-foreground "blue"))))
 '(company-tooltip ((t (:inherit company-preview :background "lightgray" :foreground "black"))))
 '(company-tooltip-annotation ((t (:inherit company-tooltip :foreground "saddle brown"))))
 '(company-tooltip-annotation-selection ((t (:inherit company-tooltip-selection :foreground "sandy brown"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :foreground "white" :background "olive drab")) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :background "blue")) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:inherit company-preview :background "steelblue" :foreground "white"))))
 '(eshell-prompt ((t (:foreground "tan"))))
 '(org-link ((t (:inherit link :foreground "gainsboro")))))
