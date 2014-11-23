(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'package)
;; (push '("marmalade" . "http://marmalade-repo.org/packages/")
;;       package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(package-initialize)

(require 'flymake)

(setq evil-want-C-u-scroll t)
(setq evil-toggle-key "C-c z")
(evil-mode 1)
;; enable evil mode in all buffers
(setq evil-motion-state-modes (append evil-emacs-state-modes evil-motion-state-modes))
(setq evil-emacs-state-modes nil)

;; flx-ido setup
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(projectile-global-mode)

(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(load-theme 'solarized-light t)

(add-hook 'after-init-hook #'global-flycheck-mode)

;; go-mode setup
;; (add-hook 'before-save-hook 'go-remove-unused-imports)
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
			  (define-key (current-local-map) (kbd "C-c C-f") 'godef-jump)
			  (define-key (current-local-map) (kbd "C-x 4 C-c C-f") 'godef-jump-other-window)
			  ))

;; highlighting parentheses
(show-paren-mode 1)
(setq show-paren-delay 0)

;; line numbers
(custom-set-faces '(linum ((t (:background "white" :foreground "brightcyan")))))
(setq linum-format "%3d ")
(global-linum-mode 1)

;; copy into OSX clipboard
(require 'pbcopy)
(turn-on-pbcopy)

;; backups
(setq
 backup-by-copying t      ; don't clobber symlinks
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))    ; don't litter my fs tree
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

;; auto-complete
(setq company-idle-delay 0)
(add-hook 'after-init-hook 'global-company-mode)

;; kill all buffers
(defun kill-all-buffers ()
  "Kill all buffers."
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(define-key global-map (kbd "C-c \\ b d") 'kill-all-buffers)

;; give me back my shell!
(define-key global-map (kbd "C-z") 'shell)