(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(modus-vivendi))
 '(fringe-mode 0 nil (fringe))
 '(org-agenda-files
   '("~/Multimedia/Documents/Agendas/MainList.org" "/home/seolhwa/Multimedia/Documents/Agendas/LifeList.org" "/home/seolhwa/Multimedia/Documents/Agendas/ComputerList.org"))
 '(package-selected-packages '(org-roam haskell-mode))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(menu-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monoid" :foundry "PfEd" :slant normal :weight regular :height 98 :width semi-condensed)))))

(set-frame-parameter nil 'alpha-background 65)

(add-to-list 'default-frame-alist '(alpha-background . 65))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)

;; hslint on the command line only likes this indentation mode;
;; alternatives commented out below.
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; Ignore compiled Haskell files in filename completions
(add-to-list 'completion-ignored-extensions ".hi")

(setq inhibit-splash-screen t)

(transient-mark-mode 1)

(require 'org)

(find-file "~/Multimedia/Documents/Agendas/MainList.org")

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
