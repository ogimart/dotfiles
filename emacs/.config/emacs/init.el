;;;; init.el
;;;;
;;;; This is a generated file from ~/.dotfiles/emacs.org
;;;; Do not edit!

(setq gc-cons-threshold (* 2 1024 1024))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-native-compile t)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-expand-minimally t)

(setq user-emacs-diructory "~/.cache/emacs/")
(setq make-backup-files t)
(setq backup-directory-alist '(("." . "~/.cache/emacs/backups/")))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta))

(defun semi-bold ()
  "Make bold weight semi-bold"
  (interactive)
  (mapc (lambda (face)
	  (when (eq (face-attribute face :weight) 'bold)
	    (set-face-attribute face nil :weight 'semi-bold)))
	(face-list)))

(use-package modus-themes
  :init
  (defun custom-modus ()
    (semi-bold))
  (add-hook 'after-init-hook (lambda () (custom-modus)))
  :config
  (setq modus-themes-common-palette-overrides
	`((fg-line-number-active "#adadad")
	  (fg-line-number-inactive "#cdcdcd")
	  (bg-line-number-active "#ffffff")
	  (bg-line-number-inactive "ffffff")
	  (fg-region nil)
	  (bg-region "#e6e6e6")
	  (fringe "#ffffff")
	  (cursor "#303030")
	  ,@modus-themes-preset-overrides-faint))
  (setq modus-themes-weights '(normal semibold))
  (setenv "EMACS_THEME" "modus-operandi")
  (load-theme 'modus-operandi t))

(use-package mood-line
  :init
  (mood-line-mode))

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic partial-completion)))

(use-package consult
  :bind (("C-x C-b" . consult-buffer)
	 ("C-c l"   . consult-line)
	 ("C-c r"   . consult-ripgrep)))

(use-package marginalia
  :defer t
  :init (marginalia-mode))

(use-package company
  :defer 3
  :config
  (global-company-mode))

(use-package eglot
  :ensure nil
  :defer t)

(use-package sly
  :defer t
  :commands (sly)
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package prolog-mode
  :ensure nil
  :defer t
  :mode ("\\.pl?\\'" . prolog-mode))

(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t))

(use-package go-mode
  :defer t
  :config
  (defun project-find-go-module (dir)
    (when-let ((root (locate-dominating-file dir "go.mod")))
      (cons 'go-module root)))

  (cl-defmethod project-root ((project (head go-module)))
    (cdr project))

  (add-hook 'project-find-functions #'project-find-go-module)
  (add-hook 'go-mode-hook (lambda () (setq-local compile-command "go build ")))
  (add-hook 'go-mode-hook (lambda () (setq tab-width 4))))

(use-package c-mode
  :ensure nil
  :defer t
  :init (setq c-basic-offset 4)
  :config
  (add-hook 'c-mode-hook
	    (lambda ()
	      (setq comment-start "//" comment-end ""))))

(use-package python
  :ensure nil
  :defer t
  :hook (python-mode-hook . eldoc-mode))

(use-package magit
  :defer t)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(use-package dockerfile-mode
  :defer t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package protobuf-mode
  :defer t
  :defer t)

(use-package yaml-mode
  :defer t
  :mode ("\\.yml\\'" . yaml-mode))

(use-package web-mode
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

(use-package restclient
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.restclient\\'" . restclient-mode)))

;; (use-package dotenv
;;   :quelpa
;;   (dotenv :repo "pkulev/dotenv.el"
;;           :fetcher github :upgrade t))

(add-hook 'sh-mode-hook
      (lambda ()
	(setq sh-basic-offset 2
	      sh-indentation 2)))

(use-package yasnippet
  :defer t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package vterm
  :defer t
  :config
  (setq vterm-shell "/bin/zsh")
  (setq vterm-disable-bold t))

(use-package multi-vterm
  :defer t
  :bind ("C-c t" . multi-vterm))

(setq browse-url-browser-function 'xwidget-webkit-browse-url)

(defun google ()
  (interactive)
  (xwidget-webkit-browse-url "https://google.com"))

(defun duckduckgo ()
  (interactive)
  (xwidget-webkit-browse-url "https://duckduckgo.com"))

(use-package grip-mode
  :defer t
  :custom (grip-preview-use-webkit t))

(use-package htmlize
  :defer t)

(use-package flyspell
  :ensure nil
  :defer t
  :custom
  (ispell-program-name "aspell")
  (aspell-dictionary "en_US-wo_accents")
  (aspell-program-name "/opt/homebrew/bin/aspell")
  (ispell-dictionary "en_US-wo_accents")
  (ispell-program-name "/opt/homebrew/bin/aspell")
  :config
  ;; (define-key flyspell-mode-map [down-mouse-3] 'flyspell-correct-word)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (add-hook 'org-mode-hook 'markdown-mode)
  (add-hook 'TeX-mode-hook 'flyspell-mode))

(use-package markdown-mode
  :defer t
  :commands (mardown-mode gfm-mode)
  :mode (("\\.md\\'" . gfm-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init
  (setq markdown-command "pandoc"))

(use-package graphviz-dot-mode)
  ;; :init
  ;; (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot)))

(use-package org
  :ensure nil
  :defer t
  :config
  ;; export
  (require 'ox-md nil t)
  (require 'ox-gfm nil t)
  ;; theme
  ;; (if (eq current-theme 'light)
  ;;	(org-light-theme)
  ;; (org-dark-theme))
  (setq org-hide-emphasis-markers nil)
  (setq org-src-fontify-natively t))

(use-package ox-gfm
  :after org)

(use-package which-key
  :init
  (which-key-mode))

(global-set-key (kbd "C-x k") 'kill-this-buffer)

(use-package evil
  :defer 3
  :config
  (setq evil-default-state 'emacs)
  (setq evil-disable-insert-state-bindings t)
  (evil-set-initial-state 'vterm-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (evil-mode 0))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)
