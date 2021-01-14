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

;; evil
(add-to-list 'load-path "~/.emacs.d/plugins/evil")
(require 'evil)
(evil-mode 1) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(autopair paredit flycheck-irony irony-eldoc ivy-posframe ivy-prescient auto-complete-clang company-irony-c-headers auto-complete-c-headers auto-complete spacemacs-theme afternoon-theme)))

;; theme
(load-theme 'spacemacs-dark' t)
(setq frame-resize-pixelwise t) ;;解决aweosme wm窗口空缺


;; 显示时间
(display-time-mode 1)  ;; 常显 
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期

;; 隐藏菜单栏工具栏
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; 启动界面


;; user config

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



;; c/c++
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-20201213.1255/")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20201213.1255/dict/")
(require 'auto-complete-config)
(add-to-list 'load-path "~/.emacs.d/elpa/auto-complete-clang-20140409.752/")
(require 'auto-complete-clang)  
;; 设置不自动启动
(setq ac-auto-start nil)  
;; 设置响应时间 0.5
(setq ac-quick-help-delay 0.5)  

(ac-set-trigger-key "TAB")  
;;(define-key ac-mode-map  [(control tab)] 'auto-complete)  
;; 提示快捷键为 M-/
(define-key ac-mode-map  (kbd "M-/") 'auto-complete) 
(defun my-ac-config ()  
  (setq ac-clang-flags  
        (mapcar(lambda (item)(concat "-I" item))  
               (split-string  
                "
 /usr/include/c++/10.2.0
 /usr/include/x86_64-linux-gnu/c++/10.2.0/.
 /usr/include/c++/10.2.0/backward
 /usr/lib/gcc/x86_64-linux-gnu/10.2.0/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/10.2.0/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include
"
)))  
(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))  
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
(add-hook 'css-mode-hook 'ac-css-mode-setup)  
(add-hook 'auto-complete-mode-hook 'ac-common-setup)  
(global-auto-complete-mode t))  
(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))  
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)  
;; ac-source-gtags  
(my-ac-config)  
(ac-config-default)



;; ivy-posframe
(require 'ivy-posframe)
;; display at `ivy-posframe-style'
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
 (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-bottom-left)))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
(ivy-posframe-mode 1)

;; setting
(set-face-attribute 'default nil :height 200) ;;字体大小

(add-to-list 'load-path "~/.emacs.d/elpa/autopair")  ;;自动匹配括号
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
(setq frame-title-format "[%b]")                ;显示buffer的名字
(global-display-line-numbers-mode)
(electric-indent-mode t)                                 ;开启智能缩进



;; markdown
(defun markdown-to-html ()
  (interactive)
  (start-process "grip" "*gfm-to-html*" "grip" (buffer-file-name) "5000")
  (browse-url (format "http://localhost:5000/%s.%s" (file-name-base) (file-name-extension (buffer-file-name)))))
(global-set-key (kbd "C-c m")   'markdown-to-html)



;; file tree
(add-to-list 'load-path "~/.emacs.d/plugins/neotree")
(require 'neotree)
(global-set-key [f3] 'neotree-toggle)

;; org  mode
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))