;;;; early-init.el
;;;;
;;;; This is a generated file from ~/.dotfiles/emacs.org
;;;; Do not edit!

(setq native-comp-speed 2
      native-comp-jit t
      native-comp-async-report-warnings-errors nil)

(setq inhibit-splash-screen t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(delete-selection-mode 1)
(setq blink-cursor-mode nil)
(setq line-number-mode t)
(setq column-number-mode t)
(if (not (display-graphic-p))
    (menu-bar-mode 0))
(setq default-frame-alist '((width . 160) (height . 42)))
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil
      ns-antialias t
      ns-use-thin-smoothing nil)
(pixel-scroll-precision-mode)
;; (setq x-underline-at-descent-line t)

(set-face-attribute 'default nil :family "Source Code Pro"
		    :height 150 :weight 'normal)
(set-face-attribute 'variable-pitch nil :family "Helvetica Neue"
		    :height 160 :weight 'normal)
