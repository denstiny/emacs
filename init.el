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

(global-evil-leader-mode)
;; evil
(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)
(evil-mode 1) 
(load-file "~/.emacs.d/user-config/evil.el")
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
(set-face-attribute 'default nil :height 150) ;;字体大小
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
;; 自动缩进
(electric-indent-mode t)
;; 自动启动全屏
(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; 显示匹配光标
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 高粱当前行
(global-hl-line-mode t)
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
  ;(setq eaf-proxy-port "1089")


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

;; org config
(load-file "~/.emacs.d/user-config/org-config.el")

;;counsel
(use-package counsel
  :config
  (global-set-key (kbd "M-x") 'counsel-M-x))

(use-package company
  :ensure t)
(with-eval-after-load 'company
(global-company-mode t)  
(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") #'company-select-next)
(define-key company-active-map (kbd "C-p") #'company-select-previous))
(setq company-show-numbers t)
(use-package company-box
  :ensure t
  :config
  (add-hook 'company-mode-hook 'company-box-mode))


(use-package company-jedi
  :ensure t)
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; c/c++ lsp
(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

;; 彩虹猫
(load-file "~/.emacs.d/user-config/nyan-mode.el")

