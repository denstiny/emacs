;; packages
(setq package-archives '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
						  ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))


;; use-package
(setq use-package-always-ensure t)

;; evil
(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)
(evil-mode 1) 
;; theme
(setq frame-resize-pixelwise t) ;;解决aweosme wm窗口空缺

;; 隐藏菜单栏工具栏
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; 自动匹配括号

(use-package autopair
  :ensure t
  :defer t)

;; setting
(set-face-attribute 'default nil :height 200) ;;字体大小
(setq make-backup-files nil) ;; 关闭自动备份
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/var/backups")))

(setq-default make-backup-files nil)
;关闭自动保存模式
(setq auto-save-mode nil)
;不生成 #filename# 临时文件
(setq auto-save-default nil)


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(autopair-global-mode) ;; enable autopair in all buffers
(global-display-line-numbers-mode)

;; yes/no is y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto company
(use-package company
  :config
  (setq company-dabbrev-code-everywhere t
        company-dabbrev-code-modes t
        company-dabbrev-code-other-buffers 'all
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case t
        company-dabbrev-other-buffers 'all
        company-require-match nil
        company-minimum-prefix-length 2
        company-show-numbers t
        company-tooltip-limit 20
        company-idle-delay 0
        company-echo-delay 0
        company-tooltip-offset-display 'scrollbar
        company-begin-commands '(self-insert-command))
  (push '(company-semantic :with company-yasnippet) company-backends)
  :hook ((after-init . global-company-mode)))



;; 启动界面
(use-package dashboard
  :ensure t
  :config
  (setq dashboard-center-content t)
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "Aerocn's Emacs "
	dashboard-startup-banner 'logo
	dashhoard-center-content t
	dashboard-set-heading-icons t
	dashboard-set-file-icons t
	dashboard-set-navigator t)
  )


;; english terchar
(use-package english-teacher
  :load-path "~/.emacs.d/elpa/english-teacher.el" ;; NOTE: here type english teacher directory
  :hook ((Info-mode
	  elfeed-show-mode
	  eww-mode
	  Man-mode
	  Woman-Mode) . english-teacher-follow-mode))

;; term
(use-package vterm
  :ensure t
  :bind (("C-' C-t" . open-vterm))
  :config
  (define-key vterm-mode-map (kbd "C-c p" 'previous-buffer))
  (define-key vterm-mode-map (kbd "C-c n" 'next-buffer))
  )




;; eaf 
(use-package eaf
  :load-path "~/.emacs.d/site-lisp/emacs-application-framework" ; Set to "/usr/share/emacs/site-lisp/eaf" if installed from AUR
  :init
  (use-package epc :defer t :ensure t)
  (use-package ctable :defer t :ensure t)
  (use-package deferred :defer t :ensure t)
  (use-package s :defer t :ensure t)
  :custom
  (eaf-browser-continue-where-left-off t)
  :config
  (eaf-setq eaf-browser-enable-adblocker "true")
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding)
  (eaf-bind-key nil "M-q" eaf-browser-keybinding))
  ;(setq eaf-proxy-type "http")
  ;(setq eaf-proxy-host "127.0.0.1")
  ;(setq eaf-proxy-port "1080")


;; theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (load-file "~/.emacs.d/user-config/tabline.el"))


;;(setq doom-modeline-height 2)



(use-package company-box
  :ensure t
  :hook (company-mode-hook . company-box-mode))

;; c/c++
(load-file "~/.emacs.d/user-config/ccls-config.el")

;; java
(load-file "~/.emacs.d/user-config/java-config.el")

;; org config
(load-file "~/.emacs.d/user-config/org-config.el")

