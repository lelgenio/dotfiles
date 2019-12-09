;;; init.el --- just my settings
;;; Commentary:
(require 'package)

(setq package-list '(evil
                     lsp-mode
                     lsp-ui
                     yasnippet
                     company-lsp
                     projectile
                     tide))

; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'evil)
(evil-mode 1)


;; language server
    (require 'lsp-mode)
    (add-hook 'prog-mode-hook 'lsp)
    (require 'yasnippet)
    (require 'projectile)
    (require 'lsp-ui)
    (add-hook 'lsp-mode-hook #'lsp-ui-mode)
    ;; Typescript
        (defun setup-tide-mode ()
        (interactive)
        (tide-setup)
        (flycheck-mode +1)
        (setq flycheck-check-syntax-automatically '(save mode-enabled))
        (eldoc-mode +1)
        (tide-hl-identifier-mode +1)
        ;; company is an optional dependency. You have to
        ;; install it separately via package-install
        ;; `M-x package-install [ret] company`
        (company-mode +1))

        ;; aligns annotation to the right hand side
        (setq company-tooltip-align-annotations t)

        ;; formats the buffer before saving
        (add-hook 'before-save-hook 'tide-format-before-save)

        (add-hook 'typescript-mode-hook #'setup-tide-mode)
        ;; Python

;; Completion
    (add-hook 'after-init-hook 'global-company-mode)
    (require 'company-lsp)
    (push 'company-lsp company-backends)

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
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (lsp-typescript lsp-python projectile typescript-mode yasnippet lsp-ui lsp-mode evil)))
 '(scroll-bar-mode nil)
 '(standard-indent 4)
 '(tab-stop-list (quote (4 8 12)))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#202020" :foreground "#f6f3e8" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :width normal :foundry "pyrs" :family "Fira Code"))))
 '(line-number ((t (:inherit (shadow default) :foreground "#cc5757"))))
 '(line-number-current-line ((t (:inherit line-number :foreground "white"))))
 '(whitespace-big-indent ((t (:foreground "dark gray"))))
 '(whitespace-newline ((t (:inherit whitespace-space :weight normal))))
 '(whitespace-space ((t (:foreground "#303030"))))
 '(whitespace-tab ((t (:foreground "dim gray")))))
