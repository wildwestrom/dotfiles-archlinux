;; BEGIN CONFIG

;; Turn off startup message
(setq inhibit-startup-message t)
(scroll-bar-mode -1)  ; Disable visible scrollbar
(tool-bar-mode -1)    ; Disable the toolbar
;(tooltip-mode -1)     ; Disable tooltips
(setq visible-bell t) ; No beepling, but now there's a big pop-up on my screen


(setq scroll-step 1                ;; Lets me scroll one line at a time
      scroll-margin 4              ;; While scrolling, the cursor is always
                                   ;; x number of lines from the bottom
      scroll-conservatively 100000 ;; Doesn't jump when scrolling
      )

;; set up font
(set-face-attribute 'default nil
		    :font "JetBrainsMono Nerd Font Mono")

;; set-up use-package
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ;("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Add support for keyboard command logging
;; Use clm/toggle-command-log-buffer
(use-package command-log-mode
  :after (global-command-log-mode))

;; TODO: Figure out how to save buffers between restarts
;; desktop-save? persp-mode?

;; Look into just-one-space M-SPC
;; TODO: Create el function that executes just-one-space when there is only whitespace to the left of the cursor


;; TODO: Close parentheses, other brackets, quotes, etc. automatically.

;; evil-mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

;; TODO: Org Roam

;; TODO: Custom theming, most likely atom light

;; TODO: Let me type in y instead of yes for prompts

;; TODO: which-key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 1))

;; TODO: auto completion
;; TODO: helm swoop


;; TODO: no tabs, only spaces

;; TODO: figure out window manip bindings


;; TODO: bindings:
;; Switch-windows
;; Leader to SPC
;; SPC SPC opens M-x minibuffer
;; scroll+ctrl to change font size globally


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(which-key-posframe which-key command-log-mode use-package general evil-collection counsel avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
