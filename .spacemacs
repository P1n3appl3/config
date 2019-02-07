(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation nil
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     ;; Languages
     (c-c++ :variables c-c++-enable-clang-support t)
     (python :variables python-backend 'lsp)
     rust markdown ruby emacs-lisp scheme java

     ;; Visual
     (colors :variables colors-enable-nyan-cat-progress-bar t)
     (emoji :enabled-for markdown)
     themes-megapack

     ;; General programming
     (auto-completion :variables
                      auto-completion-enable t
                      auto-completion-enable-sort-by-usage t)
     (semantic :disabled-for emacs-lisp
               :packages (not stickyfunc-enhance))
     git version-control syntax-checking imenu-list lsp

     ;; General
     ivy org vinegar xkcd ; spell-checking
     )
   dotspacemacs-additional-packages '(rmsbolt)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(evil-search-highlight-persist)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/user-init ()
  (setq custom-file "~/.emacs.d/.cache/.custom-settings")
  (load custom-file))

(defun dotspacemacs/user-config ()
  ;; Fix mouse scrolling (shouldn't be scrolling anyways)
  (setq scroll-margin 5
        mouse-wheel-scroll-amount '(2 ((shift) . 2))
        mouse-wheel-progressive-speed nil)

  ;; Fix bug that pastes when opening new files
  (add-hook 'spacemacs-buffer-mode-hook (lambda ()
  (set (make-local-variable 'mouse-1-click-follows-link) nil)))

  ;; Exclude some sections from the powerline
  (spaceline-toggle-buffer-encoding-abbrev-off)
  (spaceline-toggle-purpose-off)
  (spaceline-toggle-major-mode-off)
  (spaceline-toggle-minor-modes-off)

  ;; Enable LSP stuff
  (require 'lsp-mode)
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (add-hook 'lsp-ui-mode-hook 'flycheck-mode)

  ;; Set the one true tab width
  (setq-default tab-width 4)
  (setq-default c-basic-offset 4)

  ;; Don't create .#temp files
  (setq create-lockfiles nil)

  ;; Use // instead of /**/ comments in C
  (add-hook 'c-mode-hook '(lambda () (setq comment-start "//" comment-end "")))

  ;; Make word motions work like vim (underscores don't break words)
  (add-hook 'c-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'python-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
  (add-hook 'rust-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

  ;; Add clang format to C mode
  (evil-leader/set-key-for-mode 'c-mode "=" 'clang-format-buffer)

  ;; Bind Ctrl +/- to increment and decrement numbers
  (define-key evil-normal-state-map (kbd "C-=") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C--") 'evil-numbers/dec-at-pt)

  ;; Make j and k work well in single line paragraphs
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

  ;; Bind s to easy-motion jump
  (define-key evil-normal-state-map (kbd "s") 'evil-avy-goto-char-2)
  )

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 10)
                                (projects . 4))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-dark gruvbox-dark-hard darkokai)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("SauceCodePro Nerd Font Mono"
                               :size 22
                               :weight normal
                               :width normal
                               :powerline-scale 1.0)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text nil
   dotspacemacs-ex-substitute-global t
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers
   '(:disabled-for-modes dired-mode doc-view-mode markdown-mode
                         org-mode pdf-view-mode text-mode
                         :size-limit-kb 1000)
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup `trailing
   ))
