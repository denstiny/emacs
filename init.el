;; 启动时间
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))



;; package
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(helm-posframe orgit google-translate zenburn-theme yasnippet-snippets winum use-package spacemacs-theme spaceline-all-the-icons request-deferred pyim pdf-tools orglue org-preview-html org-mime org-latex-impatient org-bullets neotree indent-guide highlight-indent-guides helm go-translate flycheck fira-code-mode ewal-doom-themes evil-smartparens epc dracula-theme doom-modeline dap-mode company bongo beacon autopair auto-complete-clang auto-complete-c-headers)))

;; use-package
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; 关闭滚动条
;; (push '(scroll-bar-mode -1) graphic-only-plugins-setting)
(scroll-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭启动消息
(setq inhibit-startup-message t)
;; 关闭菜单栏
(menu-bar-mode -1)
;; 字体大小
(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 150)

;; 回到关闭文件前光标的位置
(use-package saveplace
  :ensure t
  :hook (after-init . (lambda () (save-place-mode t))))

;; 关闭备份
(setq make-backup-files nil auto-save-default nil)

;; 行号
;;(global-display-line-numbers-mode +1)
(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
                prog-mode-hook
                conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; 打开大文件不警告
(setq large-file-warning-threshold nil)

;; 添加功能时不警告
(setq ad-redefinition-action 'accept)

;; 关闭烦人的提示
(setq ring-bell-function 'ignore blink-cursor-mode nil)

;; 关闭多编辑器同时编辑统一文件时锁文件操作
(setq create-lockfiles nil)

;;;; 剪切板设置
(setq x-select-enable-clipboard-manager nil)

;; 任何地方都使用UTF-8
(set-charset-priority 'unicode) 
(setq locale-coding-system   'utf-8)    ; pretty
(set-terminal-coding-system  'utf-8)    ; pretty
(set-keyboard-coding-system  'utf-8)    ; pretty
(set-selection-coding-system 'utf-8)    ; please
(prefer-coding-system        'utf-8)    ; with sugar on top
(setq default-process-coding-system '(utf-8 . utf-8))


;; 显示时间
(display-time-mode 1)  ;; 常显 
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期
;; 高亮对应的括号
(show-paren-mode 1)

;; evil vim 模式
(use-package evil
  :config
  (setq frame-title-format "%b")
  ;; 却换缓冲区
  ;(define-key evil-insert-state-map"jk" 'evil-normal-state) 
  (define-key evil-normal-state-map (kbd "C-j") 'next-buffer)
  (define-key evil-normal-state-map (kbd "C-k") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "C-S-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-S-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-S-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-S-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "tt") 'neotree-toggle)
  (define-key evil-normal-state-map (kbd "tr") 'ansi-term)

  (evil-mode 1))

;; emacs 主题配置
(use-package dracula-theme
  :ensure t ; 确保已经安装
  :config
  ;; Don't change the font size for some headings and titles (default t)
  (setq dracula-enlarge-headings nil)

  ;; Adjust font size of titles level 1 (default 1.3)
  (setq dracula-height-title-1 1.25)

  ;; Adjust font size of titles level 2 (default 1.1)
  (setq dracula-height-title-1 1.15)

  ;; Adjust font size of titles level 3 (default 1.0)
  (setq dracula-height-title-1 1.05)

  ;; Adjust font size of document titles (default 1.44)
  (setq dracula-height-doc-title 1.4)

  ;; Use less pink and bold on the mode-line and minibuffer (default nil)
  (setq dracula-alternate-mode-line-and-minibuffer t)

  (load-theme 'dracula t))


(define-fringe-bitmap 'flycheck-fringe-bitmap-ball
  (vector #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00111000
	  #b01111100
	  #b11111110
	  #b11111110
	  #b01111100
	  #b00111000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000
	  #b00000000))

(flycheck-define-error-level 'error
  :severity 100
  :compilation-level 2
  :overlay-category 'flycheck-error-overlay
  :fringe-bitmap 'flycheck-fringe-bitmap-ball
  :fringe-face 'flycheck-fringe-error
  :error-list-face 'flycheck-error-list-error)

;; 命令行补全
(use-package helm
  ;; 等价于 (bind-key "M-x" #'helm-M-x)
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files))
  :config
  ;; 全局启用 Helm minor mode
  (helm-mode 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 补全引擎
(use-package company
  ;; 等价于 (add-hook 'after-init-hook #'global-company-mode)
  :hook (after-init . global-company-mode)
  :config
  ;; setq 可以像这样连着设置多个变量的值
  (setq company-tooltip-align-annotations t ; 注释贴右侧对齐
	company-tooltip-limit 20            ; 菜单里可选项数量
	company-show-numbers t              ; 显示编号（然后可以用 M-数字 快速选定某一项）
	company-idle-delay .0               ; 延时多少秒后弹出
	company-minimum-prefix-length 1     ; 至少几个字符后开始补全
	))

(use-package lsp-mode
  ;; 延时加载：仅当 (lsp) 函数被调用时再 (require)
  :commands (lsp)
  ;; 在哪些语言 major mode 下启用 LSP
  :hook (((ruby-mode
	   php-mode
	   typescript-mode
	   ;; ......
	   ) . lsp))
  :init ;; 在 (reuqire) 之前执行
  (setq lsp-auto-configure t ;; 尝试自动配置自己
	lsp-auto-guess-root t ;; 尝试自动猜测项目根文件夹
	lsp-idle-delay 0.500 ;; 多少时间idle后向服务器刷新信息
	lsp-session-file "~/.emacs/.cache/lsp-sessions") ;; 给缓存文件换一个位置
  )

;; 内容呈现
(use-package lsp-ui
  ;; 仅在某软件包被加载后再加载
  :after (lsp-mode)
  ;; 延时加载
  :commands (lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
	;; 查询符号定义：使用 LSP 来查询。通常是 M-.
	([remap xref-find-references] . lsp-ui-peek-find-references)
	;; 查询符号引用：使用 LSP 来查询。通常是 M-?
	([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
	;; 该文件里的符号列表：类、方法、变量等。前提是语言服务支持本功能。
	("C-c u" . lsp-ui-imenu))
  ;; 当 lsp 被激活时自动激活 lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :init
  ;; lsp-ui 有相当细致的功能开关。具体参考：
  ;; https://github.com/emacs-lsp/lsp-mode/blob/master/docs/tutorials/how-to-turn-off.md
  (setq lsp-enable-symbol-highlighting t
	lsp-ui-doc-enable t
	rlsp-lens-enable t))
;; 图标
(use-package all-the-icons)

;; 状态栏
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Or use this
;; Use `window-setup-hook' if the right segment is displayed incorrectly
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

;(require 'spaceline-config)
;(spaceline-spacemacs-theme)

(use-package neotree
  :config
					;(global-set-key [f8] 'neotree-toggle)
  )

;;  语法检查
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; 自动配对括号
(use-package smartparens-config
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t)))
(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)


;; org-mode buf
;(use-package org-bullets
;  :ensure t
;  :hook (org-mode-hook . (lambda () (org-bullets-mode t)))
;  :custom (org-bullets-bullet-list '("==" "===" "   " "  asdf ")))

;; 媒体播放器
(use-package bongo
  :ensure t)

;; 信标
(use-package beacon
  :ensure t ; 确保已经安装
  :demand t ; 确保已经加载
  :config
  (beacon-mode 1)
  (setq beacon-push-mark 3)
  (setq beacon-color "#666600"))


;; 网络框架 
(use-package request
  :ensure t)
;; fira code font mode 
(use-package fira-code-mode
  :ensure t ; 确保已经安装
  :demand t ; 确保已经加载
  :custom (fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x" "lambda" "==" "===" "=====" "<<" ">>" "*"))
  :hook prog-mode) ;; Enables fira-code-mode automatically for programming major modes


;; 缩进线
(use-package indent-guide
  :ensure
  :config
  (require 'indent-guide)
  (indent-guide-global-mode))

;; 翻译

;; 代理设置
(setq url-proxy-services
      '(("http"     . "127.0.0.1:8889")
	("https"    . "127.0.0.1:8889")))

;; 输入法
(use-package pyim
  :ensure t
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure nil
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")

  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)

  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  ;;(setq pyim-page-tooltip 'popup)

  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  :bind
  (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))


;; org mode
(add-to-list 'load-path "~/.emacs.d/site-lis/org/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lis/org/contrib/lisp")

;; 快速编译运行
(defun sl-c ()
  "Compile current file just smart."
  (interactive)
  (cond ((and (boundp 'ede-minor-mode) ede-minor-mode (ede-current-project))
         (ede-compile-target))
        ((file-readable-p "Makefile")
         (compile compile-command))
        ((file-readable-p "makefile")
         (compile compile-command))
        ((string= "c-mode" major-mode)
         (let ((default-directory temporary-file-directory))
           (shell-command-on-region (point-min) (point-max)
                                    "gcc -g -O0 -x c -std=gnu11 -o a - && ./a")))
        ((string= "c++-mode" major-mode)
         (let ((default-directory temporary-file-directory))
           (shell-command-on-region (point-min) (point-max)
                                    "g++ -g -O0 -x c++ -std=c++11 -o a - && ./a")))
        ((call-interactively 'compile))))

(defun sl-python (&optional beg end)
  "Support send current line.
BEG for begine,
END for end."
  (interactive)
  (if (region-active-p)
      (call-interactively #'python-shell-send-region)
    (python-shell-send-region
     (save-excursion (python-nav-beginning-of-statement))
     (save-excursion (python-nav-end-of-statement)))))
