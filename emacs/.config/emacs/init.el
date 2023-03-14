;;;; init.el
;;;;
;;;; This is a generated file from ~/.dotfiles/emacs.org
;;;; Do not edit!

(setq gc-cons-threshold (* 4 1024 1024))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(setq package-native-compile t)

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)
(setq use-package-expand-minimally t)

(global-auto-revert-mode 1)

(setq user-emacs-diructory "~/.cache/emacs/")
(setq make-backup-files t)
(setq backup-directory-alist '(("." . "~/.cache/emacs/backups/")))

(defun read-lines (file-name)
  (if (file-exists-p file-name)
  (with-temp-buffer
	(insert-file-contents file-name)
	(split-string (buffer-string) "\n" t))
    nil))

(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta))

(use-package ns-auto-titlebar
  :defer t
  :init
  (ns-auto-titlebar-mode))

(defun font-weight ()
  "Normal weight font"
  (interactive)
  (set-face-attribute 'default nil :weight 'normal)
  (set-face-attribute 'bold nil :weight 'medium))

(defun font-size (size)
  (interactive "nFont size in pt: ")
  (let ((height (* size 10)))
  (set-face-attribute 'default nil :height height)
  (set-face-attribute 'bold nil :height height)))

(add-hook 'after-init-hook (lambda () (font-weight)))
(add-hook 'org-mode-hook (lambda () (font-weight)))

(use-package modus-themes
  :bind ("<f5>" . modus-themes-toggle)
  :init
  (require 'modus-themes)
  (add-hook 'modus-themes-after-load-theme-hook
	    (lambda ()
	  (if (string= (modus-themes--current-theme) "modus-operandi")
		  (setenv "EMACS_THEME" "light")
		(setenv "EMACS_THEME" "dark"))
	  (font-weight)
	  (set-face-attribute 'line-number-current-line nil
				  :slant 'normal :bold nil)
	  (set-face-attribute 'line-number nil
				  :slant 'normal :bold nil)))
  (setq modus-themes-to-toggle '(modus-vivendi modus-operandi))
  (setq modus-themes-weights '(normal semibold)
	modus-themes-disable-other-themes t)
  (setq modus-themes-common-palette-overrides
	'((fg-region unspecified)
	  (bg-region bg-mode-line-inactive)
	  (bg-line-number-active bg-default)
	  (bg-line-number-inactive bg-default)
	  (fg-line-number-active bg-active)
	  (fg-line-number-inactive bg-inactive)
	  (bg-paren-match bg-mode-line-active)
	  (fringe bg-default)))
  (setq modus-operandi-palette-overrides
	`((cursor "black")
	  (bg-paren-match bg-mode-line-inactive)
	  (bg-mode-line-active bg-blue-subtle)
	  ,@modus-themes-common-palette-overrides))
  (setq modus-vivendi-palette-overrides
	`((cursor "white")
	  (bg-paren-match bg-mode-line-active)
	  ,@modus-themes-common-palette-overrides))
  :config
  (modus-themes-load-theme (car modus-themes-to-toggle)))

(use-package diminish
  :init
  (diminish 'eldoc-mode))

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

;; (use-package company
;;   :defer 3
;;   :config
;;   (global-company-mode))

(use-package corfu
  :init
  (require 'corfu-popupinfo)
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :custom
  (corfu-auto t))

(use-package eglot
  :ensure nil
  :defer t)

(use-package sly
  :defer t
  :commands (sly)
  :config
  (setq inferior-lisp-program "sbcl"))

(use-package geiser-chez
  :defer t)

(use-package racket-mode
  :defer t)

(use-package clojure-mode
  :defer t)

(use-package cider
  :defer t
  :init
  (setq safe-local-variable-values '((cider-clojure-cli-aliases . "dev")
				     (cider-clojure-cli-command . "clojure")))
  :config
  (setq cider-repl-use-clojure-font-lock t)
  ;; (setq nrepl-hide-special-buffers t)
  ;; (setq cider-overlays-use-font-lock t)
  (setq cider-use-overlays nil)
  ;; (setq cider-show-error-buffer nil)
  (setq cider-eldoc-display-for-symbol-at-point t))

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

(use-package go-tag
  :defer t
  :after go-mode)

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

(use-package smartparens
  :config
  (require 'smartparens-config)
  (global-set-key (kbd "M-o (") 'sp-wrap-round)
  (global-set-key (kbd "M-o [") 'sp-wrap-square)
  (global-set-key (kbd "M-o {") 'sp-wrap-curly)
  (global-set-key (kbd "M-o r") 'sp-rewrap-sexp)
  (global-set-key (kbd "M-o w") 'sp-unwrap-sexp)
  (global-set-key (kbd "M-o f") 'sp-forward-sexp)
  (global-set-key (kbd "M-o b") 'sp-backward-sexp)
  (global-set-key (kbd "M-o u") 'sp-up-sexp)
  (global-set-key (kbd "M-o d") 'sp-down-sexp))

(use-package dockerfile-mode
  :defer t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package protobuf-mode
  :defer t
  :defer t)

(use-package yaml-mode
  :defer t
  :mode ("\\.yml\\'" . yaml-mode))

(use-package hcl-mode
  :defer t)

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

(defun eshell/gst (&rest args)
    (magit-status (pop args) nil)
    (eshell/echo))

(defun git-prompt-branch-name ()
  (let ((args '("symbolic-ref" "HEAD" "--short")))
    (with-temp-buffer
  (apply #'process-file "git" nil (list t nil) nil args)
  (unless (bobp)
	(goto-char (point-min))
	(buffer-substring-no-properties (point) (line-end-position))))))

(defun pwd-replace-home (pwd)
  "Replace home in PWD with tilde (~) character."
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
	 (home-len (length home)))
    (if (and
	 (>= (length pwd) home-len)
	 (equal home (substring pwd 0 home-len)))
	(concat "~" (substring pwd home-len))
  pwd)))

(defun pwd-shorten-dirs (pwd)
  "Shorten all directory names in PWD except the last two."
  (let ((p-lst (split-string pwd "/")))
    (if (> (length p-lst) 3)
	(concat "~/.../"
		(mapconcat (lambda (elm) elm)
			   (last p-lst 2)
			   "/"))
  pwd)))

(defmacro with-face (str &rest properties)
  `(propertize ,str 'face (list ,@properties)))

(defun esh-prompt-fn ()
  (let ((branch-name (git-prompt-branch-name))
	(prompt-path (pwd-shorten-dirs (pwd-replace-home (eshell/pwd))))
	(default-fg (face-attribute 'default :foreground))
	(branch-fg (face-attribute 'modus-themes-fg-cyan :foreground))
	(path-fg (face-attribute 'modus-themes-fg-blue :foreground)))
    (concat (with-face "[" :foreground default-fg)
	    (with-face prompt-path :foreground path-fg)
	    (if branch-name
		(with-face (concat " " branch-name) :foreground branch-fg)
	  "")
	    (with-face "] $" :foreground default-fg)
	    (with-face " " :foreground default-fg))))

(use-package eshell
  :ensure nil
  :defer t
  :bind (("C-c e" . eshell)
	 ("C-c C-r" . consult-eshell-history))
  :init
  (setq eshell-hist-ignoredups t
	eshell-save-history-on-exit t
	eshell-destroy-buffer-when-process-dies t)
  (add-hook 'eshell-mode-hook
	    (lambda ()
	  ;; aliases
	  (eshell/alias "ff" "find-file $1")
	  (eshell/alias "ee" "find-file-other-window $1")
	  (eshell/alias "gd" "magit-diff-unstaged")
	  (eshell/alias "gds" "magit-diff-staged")
	  (eshell/alias "bat" "bat --theme=base16")
	  (eshell/alias "ll" "exa -al --git --sort=type --time-style=long-iso")
	  (eshell/alias "tree" "exa -a --tree --sort=type --ignore-glob='.git|.idea|.vscode'")
	  ;; visaul commands
	  (add-to-list 'eshell-visual-commands "bat")
	  (add-to-list 'eshell-visual-commands "ssh")
	  (add-to-list 'eshell-visual-commands "tail")))
  :config
  (setq eshell-prompt-function #'esh-prompt-fn))

(defun eshell-history-list ()
  "return the eshell history as a list"
  (and (or (not (ring-p eshell-history-ring))
	   (ring-empty-p eshell-history-ring))
   (error "No history"))
  (let* ((index (1- (ring-length eshell-history-ring)))
	 (ref (- (ring-length eshell-history-ring) index))
	 (items (list)))
    (while (>= index 0)
  (setq items (cons (format "%s" (eshell-get-history index)) items)
	    index (1- index)
	    ref (1+ ref)))
    items))

(defun consult-eshell-history ()
  "Eshell History"
  (interactive)
  "Insert eshell command from history"
  (let ((cmd (completing-read "Select eshell command: "
			  (eshell-history-list))))
    (insert cmd)))

(use-package esh-mode
  :ensure nil
  :defer t
  :bind (:map eshell-mode-map
	      ("C-c C-r" . consult-eshell-history)))

(use-package vterm
  :defer t
  :init
  (setq vterm-shell "/bin/zsh")
  (setq vterm-term-environment-variable "eterm-color")
  (setq vterm-disable-bold t))

(use-package multi-vterm
  :defer t
  :bind ("C-c t" . multi-vterm))

(use-package sql-mode
  :ensure nil
  :defer t
  :bind ("C-c q" . sql-connect)
  :init
  (defun psql:connection-alist (pgpass)
    (let ((value))
  (dolist (element pgpass value)
	(setq srv-element (split-string element ":"))
	(setq value (cons (list (intern (nth 0 srv-element))
				`(sql-server ,(nth 0 srv-element))
				`(sql-port ,(string-to-number
					     (nth 1 srv-element)))
				`(sql-database ,(nth 2 srv-element))
				`(sql-user ,(nth 3 srv-element))
				`(sql-password ,(nth 4 srv-element)))
			  value)))))
  (setq sql-product 'postgres)
  (setq sql-connection-alist
	(reverse (psql:connection-alist (read-lines "~/.pgpass"))))
  (add-hook 'sql-interactive-mode-hook
	    (lambda ()
	  (toggle-truncate-lines t)
	  (sql-highlight-postgres-keywords))))

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
  :diminish
  :init
  (which-key-mode))

(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)

(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 1 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 1 M-v"))

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
