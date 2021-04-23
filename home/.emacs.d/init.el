(org-babel-load-file
  (expand-file-name
    "config.org"
    user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(git-gutter:added-sign "++")
 '(git-gutter:deleted-sign "--")
 '(git-gutter:modified-sign "~~")
 '(git-gutter:update-interval 1)
 '(package-selected-packages
   '(shfmt lsp-pyright json-mode prettier git-gutter flycheck emmet-mode company-web yasnippet-snippets yasnippet ini-mode yaml-mode impatient-mode auto-rename-tag web-mode typescript-mode lsp-ui lsp-mode rainbow-delimiters autopair evil-nerd-commenter visual-fill-column all-the-icons-dired which-key-posframe vterm use-package projectile peep-dired org-bullets magit-todos ivy-rich ivy-posframe haskell-mode general evil-collection eshell-syntax-highlighting doom-themes doom-modeline dired-open dashboard counsel))
 '(shfmt-arguments '("-bn" "-ci" "-i" "4" "-sr" "-s" "-p")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
