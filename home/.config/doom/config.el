(setq user-full-name "Jackson McCrory"
      user-mail-address "jackson@mccrory.xyz")

(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 14))

(setq display-line-numbers-type 'relative)

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                markdown-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq doom-theme 'doom-nvcode)

(setq doom-modeline-modal-icon nil)
(setq evil-echo-state nil)
(setq evil-normal-state-tag   (propertize "[Normal]" 'face '((:background "green" :foreground "black")))
      evil-emacs-state-tag    (propertize "[Emacs]" 'face '((:background "orange" :foreground "black")))
      evil-insert-state-tag   (propertize "[Insert]" 'face '((:background "red") :foreground "white"))
      evil-motion-state-tag   (propertize "[Motion]" 'face '((:background "blue") :foreground "white"))
      evil-visual-state-tag   (propertize "[Visual]" 'face '((:background "grey80" :foreground "black")))
      evil-operator-state-tag (propertize "[Operator]" 'face '((:background "purple"))))

(map! :leader
      :desc "Truncate lines"
      "t t" #'toggle-truncate-lines)

(setq ivy-posframe-display-functions-alist
      '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (ivy-switch-buffer          . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
      ivy-posframe-height-alist
      '((swiper . 20)
        (dmenu . 20)
        (t . 10)))

(ivy-posframe-mode 1)

(setq +doom-dashboard-menu-sections
      '(("Find or create file"
      :icon (all-the-icons-faicon "file-o" :face 'doom-dashboard-menu-title)
      :action find-file)
        ("Reload last session"
         :icon (all-the-icons-octicon "history" :face 'doom-dashboard-menu-title)
         :when (cond ((require 'persp-mode nil t)
                  (file-exists-p (expand-file-name persp-auto-save-fname persp-save-dir)))
                 ((require 'desktop nil t)
                  (file-exists-p (desktop-full-file-name))))
         :face (:inherit (doom-dashboard-menu-title bold))
         :action doom/quickload-session)
        ("Recently opened files"
         :icon (all-the-icons-octicon "file-text" :face 'doom-dashboard-menu-title)
         :action recentf-open-files)
        ("Open project"
         :icon (all-the-icons-octicon "briefcase" :face 'doom-dashboard-menu-title)
         :action projectile-switch-project)
        ("Open private configuration"
         :icon (all-the-icons-octicon "tools" :face 'doom-dashboard-menu-title)
         :when (file-directory-p doom-private-dir)
         :action doom/open-private-config)
        ("Open documentation"
         :icon (all-the-icons-octicon "book" :face 'doom-dashboard-menu-title)
         :action doom/help)))

(setq fancy-splash-image "~/.local/share/doom/splash.png")

(setq org-directory "~/org/")

(defun jade/org-mode-setup ()
  (org-indent-mode)
  (org-bullets-mode)
  (visual-line-mode 1))

(add-hook 'org-mode-hook 'jade/org-mode-setup)

(setq org-ellipsis " ▾")

(custom-set-variables '(org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(require 'org-tempo)

(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("ja" . "src java"))
(add-to-list 'org-structure-template-alist '("js" . "src js"))
(add-to-list 'org-structure-template-alist '("ha" . "src haskell"))
(add-to-list 'org-structure-template-alist '("lua" . "src lua"))

(defun jade/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(add-hook 'lsp-mode 'jade/lsp-mode-setup)
(setq lsp-keymap-prefix "C-c l")
(setq lsp-enable-which-key-integration t)

(add-hook 'lsp-mode 'lsp-ui-mode)

(setq lsp-ui-doc-position 'bottom)

(add-hook 'web-mode-hook 'auto-rename-tag-mode)

(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)

(add-hook 'sh-mode-hook 'shfmt-on-save-mode)

(custom-set-variables
 '(shfmt-arguments '("-bn" "-ci" "-i" "4" "-sr" "-s" "-p")))

(map!
    :leader
    :desc "Format shell code"
    "c s" #'shfmt-buffer)

(load! "~/.config/doom/private/grip-mode-credentials.el")
(setq grip-binary-path "/usr/bin/grip")
(setq grip-update-after-change nil)
(setq grip-preview-use-webkit nil)

(map!
    :leader
    (:prefix ("c" . "code")
     (:prefix ("m" . "markdown")
     :desc "Mardown live preview" "p" #'grip-mode)))

(setq emmet-self-closing-tag-style " /")

(global-git-gutter-mode t)

(custom-set-variables
 '(git-gutter:update-interval 1))

(use-package! company
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  )

(after! js2-mode
  (set-company-backend! 'js2-mode 'company-tide 'company-yasnippet))

(after! python-mode
  (set-company-backend! 'python-mode 'company-anaconda 'company-yasnippet))

(after! haskell-mode
  (set-company-backend! 'haskell-mode 'company-yasnippet))

(after! sh-mode
  (set-company-backend! 'sh-mode
    '(company-shell :with company-yasnippet)))

(after! web-mode
  (set-company-backend! 'web-mode
    '(company-web-html :with company-yasnippet)))

(after! css-mode
  (set-company-backend! 'css-mode
    '(company-css :with company-yasnippet)))

(after! cc-mode
  (set-company-backend! 'c-mode
    '(:separate company-irony-c-headers company-irony)))

(add-hook 'after-init-hook #'global-prettier-mode)

(map! :leader
      :desc "Prettify Code"
      "c p" #'prettier-prettify)

(map!
    :leader
    :desc "Send to repl"
    "c S" #'eval/send-region-to-repl)

(map! :leader
      (:prefix ("d" . "dired")
      :desc "Dired Jump" "j" #'dired-jump))

(custom-set-variables
 '(dired-listing-switches "-Alh1vD --group-directories-first"))

(dired-async-mode 1)

(evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer)

(map! (:after dired
       (:map dired-mode-map
        :leader
        :desc "Peep-dired image previews"
        "d p" #'peep-dired
        :leader
        :desc "Dired view file"
        "d v" #'dired-view-file)))

(evil-collection-define-key 'normal 'peep-dired-mode-map
  "j" 'peep-dired-next-file
  "k" 'peep-dired-prev-file)

;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(add-hook 'after-init-hook #'global-emojify-mode)

(custom-set-variables
 '(elfeed-feeds
   (quote
    (("https://www.reddit.com/r/linux.rss" reddit linux)
     ("https://www.reddit.com/r/archlinux.rss" reddit linux)
     ("https://www.reddit.com/r/gentoo.rss" reddit linux)
     ("https://www.archlinux.org/feeds/news" arch linux)
     ("https://itsfoss.com/feed/" itsfoss linux)
     ("https://techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
     ("http://feeds.feedburner.com/d0od" omgubuntu linux)
     ("https://opensource.com/feed" opensource linux)
     ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
     ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))

(defun jade/org-babel-tangle-config ()

  ;; Doom Emacs
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "~/.local/repos/dotfiles/home/.config/doom/"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle)))

  ;; Xmonad
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name "~/.local/repos/dotfiles/home/.config/xmonad/"))
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle)))
  )

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'jade/org-babel-tangle-config)))

(defun jade/set-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook 'org-mode-hook 'jade/set-visual-fill)
(add-hook 'markdown-mode-hook 'jade/set-visual-fill)
