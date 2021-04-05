;;; doom-nvcode-theme.el --- inspired by vscode's theme -*- lexical-binding: t; -*-
(require 'doom-themes)

;; Compiler pacifier
(defvar modeline-bg)

;;
(defgroup doom-nvcode-theme nil
  "Options for doom-nvcode."
  :group 'doom-themes)

(defcustom doom-nvcode-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-nvcode-theme
  :type 'boolean)

(defcustom doom-nvcode-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-nvcode-theme
  :type '(choice integer boolean))

(def-doom-theme doom-nvcode
  "The nvcode flagship theme"

  ;; name        gui       256       16
  ((bg         '("#1e1e1e" "#1d1d1d" "black"))
   (bg-alt     '("#1f1f1f" "#1d1d1d" "black"))
   (bg-alt2    '("#1f1f1f" "#1d1d1d" "black"))

   (base0      '("#1e1e1e" "black"   "black"      )) ; (self-defined)
   (base1      '("#1d1d1d" "#1d1d1d" "brightblack")) ; bg0_h
   (base2      '("#282828" "#282828" "brightblack")) ; bg0
   (base3      '("#383838" "#383838" "brightblack")) ; bg1
   (base4      '("#5c5c5c" "#5c5c5c" "brightblack")) ; bg3
   (base5      '("#6f6f6f" "#6f6f6f" "brightblack")) ; bg4
   (base6      '("#909090" "#909090" "brightblack")) ; gray
   (base7      '("#d8dee9" "#cccccc" "brightblack")) ; fg2
   (base8      '("#d8dee9" "#fbfbfb" "brightwhite")) ; fg0
   (fg         '("#d8dee9" "#dfdfdf" "brightwhite")) ; fg/fg1
   (fg-alt     '("#d8dee9" "#cccccc" "brightwhite")) ; fg2

   ;; Standardized official colours from nvcode
   (grey        '("#bbbbbb" "#e74c3c" "brightblack"))   ; grey
   (red         '("#d54646" "#e74c3c" "red"))           ; red
   (orange         '("#d54646" "#e74c3c" "red"))           ; red
   (dark-red         '("#d54646" "#e74c3c" "red"))           ; red
   (magenta     '("#c586c0" "#cc241d" "magenta"))       ; magenta
   (yellow      '("#d7ba7d" "#fabd2f" "yellow"))        ; yellow
   (dark-yellow      '("#d7ba7d" "#fabd2f" "yellow"))        ; yellow
   (green       '("#23d18b" "#b8bb26" "green"))         ; green
   (dark-green       '("#23d18b" "#b8bb26" "green"))         ; green
   (blue        '("#569cd6" "#83a598" "brightblue"))    ; blue
   (dark-blue        '("#569cd6" "#83a598" "brightblue"))    ; blue
   (teal        '("#569cd6" "#83a598" "brightblue"))    ; blue
   (violet        '("#569cd6" "#83a598" "brightblue"))    ; blue
   (cyan        '("#29b8db" "#83a598" "brightcyan"))    ; cyan
   (dark-cyan        '("#29b8db" "#83a598" "brightcyan"))    ; cyan
   (black       '("#29b8db" "#83a598" "brightcyan"))    ; black
   (white       '("#29b8db" "#83a598" "brightcyan"))    ; white

   ;; face categories
   (highlight      yellow)
   (vertical-bar   grey)
   (selection      bg-alt2)
   (builtin        red)
   (comments       (if doom-nvcode-brighter-comments magenta grey))
   (doc-comments   (if doom-nvcode-brighter-comments (doom-lighten magenta 0.2) (doom-lighten fg-alt 0.25)))
   (constants      blue)
   (functions      green)
   (keywords       magenta)
   (methods        green)
   (operators      fg)
   (type           yellow)
   (strings        green)
   (variables      blue)
   (numbers        blue)
   (region         base4)
   (error          red)
   (warning        yellow)
   (success        green)

   (vc-modified    (doom-darken cyan 0.15))
   (vc-added       (doom-darken green 0.15))
   (vc-deleted     (doom-darken red 0.15))

   ;; custom categories
   (-modeline-pad
    (when doom-nvcode-padded-modeline
      (if (integerp doom-nvcode-padded-modeline)
          doom-nvcode-padded-modeline
        4)))

   (org-quote `(,(doom-lighten (car bg) 0.05) "#1f1f1f")))

  ;; --- extra faces ------------------------
  (
   ;;;;;;;; Editor ;;;;;;;;
   (cursor :background "white")
   (hl-line :background base3)
   ((line-number &override) :foreground base5)
   ((line-number-current-line &override) :background base3 :foreground fg)

   ;; Vimish-fold
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background bg-alt2 :weight 'light)
   ((vimish-fold-mouse-face &override) :foreground "white" :background yellow :weight 'light)
   ((vimish-fold-fringe &override) :foreground magenta :background magenta)

   ;;;;;;;; Doom-modeline ;;;;;;;;
   (mode-line
    :background (doom-lighten bg 0.05) :foreground (doom-lighten fg-alt 0.25)
    :box (if -modeline-pad `(:line-width ,-modeline-pad ,:color base3)))

   (mode-line-inactive
    :background bg :foreground base4
    :box (if -modeline-pad `(:line-width ,-modeline-pad ,:color base2)))

   ;; File-name
   (doom-modeline-project-dir :bold t :foreground cyan)
   (doom-modeline-buffer-path :inherit 'bold :foreground green)
   (doom-modeline-buffer-file :inherit 'bold :foreground fg)
   (doom-modeline-buffer-modified :inherit 'bold :foreground red)

   ;; Misc
   (doom-modeline-error :background bg)
   (doom-modeline-buffer-major-mode :foreground yellow :bold t)
   (doom-modeline-info :bold t :foreground cyan)
   (doom-modeline-bar :background green)
   (doom-modeline-panel :background green :foreground fg)

   ;; Solaire
   (solaire-mode-line-face :inherit 'mode-line)
   (solaire-mode-line-inactive-face :inherit 'mode-line-inactive)

   ;;;;;;;; Search ;;;;;;;;
   ;; /find
   (isearch :foreground base0 :background red)
   (evil-search-highlight-persist-highlight-face :background yellow)
   (lazy-highlight :background yellow :foreground base0 :distant-foreground base0 :bold bold)
   (evil-ex-substitute-replacement :foreground cyan :strike-through nil :inherit 'evil-ex-substitute-matches)

   ;; evil-snipe
   (evil-snipe-first-match-face :foreground "white" :background yellow)
   (evil-snipe-matches-face     :foreground yellow :bold t :underline t)

   ;;;;;;;; Mini-buffers ;;;;;;;;
   (minibuffer-prompt :foreground cyan)

   ;; ivy
   (ivy-current-match :background base4)
   (ivy-subdir :background nil :foreground cyan)
   (ivy-action :background nil :foreground cyan)
   (ivy-grep-line-number :background nil :foreground cyan)
   (ivy-minibuffer-match-face-1 :background nil :foreground yellow)
   (ivy-minibuffer-match-face-2 :background nil :foreground yellow)
   (ivy-minibuffer-match-highlight :foreground cyan)
   (counsel-key-binding :foreground cyan)

   ;; swiper
   (swiper-line-face :background bg-alt2)

   ;; ivy-posframe
   (ivy-posframe :background base3)
   (ivy-posframe-border :background base1)

   ;; neotree
   (neo-root-dir-face   :foreground cyan)
   (doom-neotree-dir-face :foreground cyan)
   (neo-dir-link-face   :foreground cyan)
   (doom-neotree-file-face :foreground fg)
   (doom-neotree-hidden-file-face :foreground (doom-lighten fg-alt 0.25))
   (doom-neotree-media-file-face :foreground (doom-lighten fg-alt 0.25))
   (neo-expand-btn-face :foreground magenta)

   ;; dired
   (dired-directory :foreground cyan)
   (dired-marked :foreground yellow)
   (dired-symlink :foreground cyan)
   (dired-header :foreground cyan)

   ;;;;;;;; Brackets ;;;;;;;;
   ;; Rainbow-delimiters
   (rainbow-delimiters-depth-1-face :foreground green)
   (rainbow-delimiters-depth-2-face :foreground red)
   (rainbow-delimiters-depth-3-face :foreground magenta)
   (rainbow-delimiters-depth-4-face :foreground blue)
   ;; Bracket pairing
   ((show-paren-match &override) :foreground nil :background base5 :bold t)
   ((show-paren-mismatch &override) :foreground nil :background "red")

   ;;;;;;;; which-key ;;;;;;;;
   (which-func :foreground cyan)
   (which-key-command-description-face :foreground fg)
   (which-key-group-description-face :foreground (doom-lighten fg-alt 0.25))
   (which-key-local-map-description-face :foreground cyan)

   ;;;;;;;; Company ;;;;;;;;
   (company-preview-common :foreground cyan)
   (company-tooltip-common :foreground cyan)
   (company-tooltip-common-selection :foreground cyan)
   (company-tooltip-annotation :foreground cyan)
   (company-tooltip-annotation-selection :foreground cyan)
   (company-scrollbar-bg :background (doom-darken base2 0.045))
   (company-scrollbar-fg :background green)
   (company-tooltip-selection :background base2)
   (company-tooltip-mouse :background (doom-darken base2 0.045) :foreground nil)

   ;;;;;;;; Misc ;;;;;;;;
   (+workspace-tab-selected-face :background green :foreground "white")

   ;; Undo tree
   (undo-tree-visualizer-active-branch-face :foreground cyan)
   (undo-tree-visualizer-current-face :foreground yellow)

   ;; General UI
   (button :foreground cyan :underline t :bold t)

   ;; ediff
   (ediff-fine-diff-A    :background (doom-blend red bg 0.4) :weight 'bold)
   (ediff-current-diff-A :background (doom-blend red bg 0.2))

   ;; flycheck
   (flycheck-error   :underline `(:style wave :color ,red)    :background base3)
   (flycheck-warning :underline `(:style wave :color ,yellow) :background base3)
   (flycheck-info    :underline `(:style wave :color ,blue)   :background base3)

   ;; helm
   (helm-swoop-target-line-face :foreground magenta :inverse-video t)

   ;; magit
   (magit-section-heading             :foreground cyan :weight 'bold)
   (magit-branch-current              :underline green :inherit 'magit-branch-local)
   (magit-diff-hunk-heading           :background base3 :foreground fg-alt)
   (magit-diff-hunk-heading-highlight :background bg-alt2 :foreground fg)
   (magit-diff-context                :foreground base3 :foreground fg-alt)


   ;;;;;;;; Major mode faces ;;;;;;;;
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground keywords)

   ;; elisp-mode
   (highlight-quoted-symbol :foreground cyan)

   ;; highlight-symbol
   (highlight-symbol-face :background (doom-lighten base3 0.03) :distant-foreground fg-alt)

   ;; highlight-thing
   (highlight-thing :background (doom-lighten base3 0.03) :distant-foreground fg-alt)

   ;; LaTeX-mode
   (font-latex-math-face :foreground cyan)

   ;; markdown-mode
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-header-delimiter-face :foreground red)
   (markdown-blockquote-face :inherit 'italic :foreground grey)
   (markdown-list-face :foreground red)
   (markdown-url-face :foreground blue)
   (markdown-pre-face  :foreground cyan)
   (markdown-comment-face :foreground cyan)
   (markdown-link-face :inherit 'underline :foreground green)
   ((markdown-code-face &override) :background (doom-darken base2 0.045))

   ;; mu4e-view
   (mu4e-header-key-face :foreground red)

   ;; org-mode
   ((outline-1 &override) :foreground green)
   ((outline-2 &override) :foreground red)
   ((outline-3 &override) :foreground blue)
   ((outline-4 &override) :foreground magenta)
   ((outline-5 &override) :foreground yellow)
   ((outline-6 &override) :foreground cyan)
   (org-ellipsis :underline nil :foreground red)
   (org-tag :foreground yellow :bold nil)
   ((org-quote &override) :inherit 'italic :foreground base7 :background org-quote)
   ((org-block &override) :background (doom-darken base2 0.045) :foreground cyan)
   ((org-block-begin-line &override) :background (doom-darken base2 0.045) :foreground red)
   (org-todo :foreground yellow :bold 'inherit)
   (org-list-dt :foreground yellow)

   ;; web-mode
   (web-mode-html-tag-bracket-face :foreground green)
   (web-mode-html-tag-face         :foreground cyan)
   (web-mode-html-attr-name-face   :foreground red)
   (web-mode-json-key-face         :foreground blue)
   (web-mode-json-context-face     :foreground yellow))

  ;; --- extra variables --------------------
  ;; ()
  )
;;; doom-nvcode-theme.el ends here
