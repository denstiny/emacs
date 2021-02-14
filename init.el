;; 软件包设置
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

(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))

;; 关闭滚动条
;; (push '(scroll-bar-mode -1) graphic-only-plugins-setting)
(scroll-bar-mode -1)

(fset 'yes-or-no-p 'y-or-n-p)

;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭菜单栏
(menu-bar-mode -1)

;; 回到关闭文件前光标的位置
(use-package saveplace
  :ensure t
  :hook (after-init . (lambda () (save-place-mode t))))

;; 关闭备份
(setq make-backup-files nil auto-save-default nil)

(global-display-line-numbers-mode +1)
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
(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)
(evil-mode 1) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company helm doom-themes autopair paredit flycheck-irony irony-eldoc ivy-posframe ivy-prescient auto-complete-clang company-irony-c-headers auto-complete-c-headers auto-complete spacemacs-theme afternoon-theme)))

;; emacs 主题配置
(load-theme 'spacemacs-dark' t)

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
        company-idle-delay .2               ; 延时多少秒后弹出
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
        lsp-lens-enable t))

