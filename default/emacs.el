;; ~/.emacs.d/init.el

;;
;; add MELPA to package repositories
;;

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

;;
;; global settings
;;

(setq-default user-full-name "Chris Rorvick")

(setq-default initial-major-mode 'org-mode)

(setq-default inhibit-splash-screen t
	      inhibit-startup-message t
	      initial-scratch-message nil
	      make-backup-files nil
	      column-number-mode t
	      indicate-empty-lines t
	      show-trailing-whitespace t
	      require-final-newline t
	      fill-column 73)

(menu-bar-mode -1)
(tool-bar-mode -1)

(show-paren-mode t)

;;
;; default theme
;;

(load-theme 'tango-dark)

;;
;; global key bindings
;;

(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x r b") 'helm-bookmarks)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-i") 'helm-swoop)

;;
;; company - Modular text completion framework
;;

(require 'company)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)

;;
;; helm
;;

(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)

(helm-mode 1)

;;
;; org-mode
;;

(setq org-todo-keywords '((sequence "TODO" "INPROGRESS" "DONE"))
      org-todo-keyword-faces '(("INPROGRESS" . (:foreground "blue" :weight bold))))

(add-hook 'org-mode-hook
	  (lambda ()
	    (define-key org-mode-map (kbd "C-c a") 'org-agenda)
	    (define-key org-mode-map (kbd "C-c c") 'org-capture)
	    (define-key org-mode-map (kbd "C-c l") 'org-store-link)
	    (define-key org-mode-map (kbd "C-c b") 'org-iswitchb)))

;;
;; cc-mode
;;

(defun my-recompile-or-compile ()
  "Call recompile if defined, otherwise compile"
  (interactive)
  (if (fboundp 'recompile)
      (call-interactively 'recompile)
    (call-interactively 'compile)))

(add-hook 'c-initialization-hook
	  '(lambda ()
	     (flyspell-prog-mode)
	     (define-key c-mode-base-map (kbd "<f5>") 'my-recompile-or-compile)
	     (define-key c-mode-base-map (kbd "S-<f5>") 'compile)
	     (define-key c-mode-base-map (kbd "<f6>") 'gdb)))

(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (c-toggle-auto-state 1)))

(setq compilation-scroll-output 'first-error
      compilation-auto-jump-to-first-error t)

;;
;; magit - A Git porcelain inside Emacs.
;;

(require 'magit)

(add-hook 'git-commit-setup-hook
	  '(lambda()
	     (git-commit-turn-on-flyspell)))

;;
;; elpy - Emacs Python Development Environment
;;

(elpy-enable)

;;
;; load site-specific config
;;

(let ((site-init (expand-file-name "~/.emacs.d/site-init.el")))
  (if (file-exists-p site-init)
      (load-file site-init)))
