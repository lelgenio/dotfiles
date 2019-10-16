(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)


;; language server
    (require 'lsp-mode)
    (require 'lsp-ui)
    (require 'yasnippet)
    (add-hook 'prog-mode-hook #'lsp)
    (add-hook 'lsp-mode-hook #'lsp-ui-mode)

;; Line numbers
    (add-hook 'prog-mode-hook #'display-line-numbers-mode)
    (setq display-line-numbers 'relative)
    (setq-default display-line-numbers-type 'visual
		display-line-numbers-current-absolute t)

;; Whitespace
    (whitespace-mode)
    (customize-set-variable 'indent-tabs-mode nil)
    (customize-set-variable 'standard-indent 4)
    (customize-set-variable 'tab-width 4)
    (customize-set-variable 'tab-stop-list '(4 8 12))
    (add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Keybinds
    (global-set-key (kbd "C-;") 'comment-line)
    (global-set-key (kbd "C-,") (lambda() (interactive)
			      (find-file "~/.emacs.d/init.el")))

(set-face-attribute 'default nil :height 200)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(fringe-mode 0 nil (fringe))
 '(global-whitespace-mode t)
 '(global-whitespace-newline-mode t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages (quote (yasnippet lsp-ui lsp-mode evil)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#202020" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 200 :width normal :foundry "default" :family "default"))))
 '(line-number ((t (:inherit (shadow default) :foreground "#cc5757"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "white"))))
 '(whitespace-big-indent ((t (:foreground "dark gray"))))
 '(whitespace-space ((t (:foreground "darkgray"))))
 '(whitespace-tab ((t (:foreground "dim gray")))))

 (set-frame-parameter (selected-frame) 'alpha 10 )
 (add-to-list 'default-frame-alist '(alpha . 10))
