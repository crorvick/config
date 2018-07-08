;; ~/.emacs.d/site-init.el

(setq user-mail-address "chris.rovick@radix.trade")

(setq org-agenda-files '("~/org"))
(setq org-log-done t)

(require 'clang-format)
(global-set-key (kbd "M-<tab>") 'clang-format-region)
(global-set-key (kbd "<f12>") 'clang-format-buffer)

(c-add-style "radix"
	     '((c-basic-offset  . 4)
	       (indent-tabs-mode . nil)
	       (c-comment-only-line-offset . 0)
	       (c-hanging-braces-alist . ((brace-list-open)
					  (brace-entry-open)
					  (substatement-open after)
					  (block-close . c-snug-do-while)
					  (arglist-cont-nonempty)))
	       (c-cleanup-list . (brace-else-brace))
	       (c-offsets-alist . ((statement-block-intro . +)
				   (knr-argdecl-intro     . 0)
				   (substatement-open     . 0)
				   (substatement-label    . 0)
				   (label                 . 0)
				   (statement-cont        . +)
				   (innamespace           . [0])))))

(setq c-default-style "radix")
