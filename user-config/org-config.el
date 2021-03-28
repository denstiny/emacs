(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))
(font-lock-add-keywords 'org-mode
                        '(("^ *\([-]\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\([+]\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "◦"))))))
(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "†")
                                       ("#+END_SRC" . "†")
                                       ("#+begin_src" . "†")
                                       ("#+end_src" . "†")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Source Sans Pro" :height 120 :weight light))))
 '(fixed-pitch ((t ( :family "Consolas" :slant normal :weight normal :height 0.9 :width normal)))))

(custom-theme-set-faces
 'user
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))


(use-package org-pretty-tags
  :demand t
  :config
  (setq org-pretty-tags-surrogate-strings
        (quote
         (("TOPIC" . "☆")
          ("PROJEKT" . "💡")
          ("SERVICE" . "✍")
          ("Blog" . "✍")
          ("music" . "♬")
          ("security" . "🔥"))))
  (org-pretty-tags-global-mode))

(custom-set-faces
 '(org-block-begin-line
   ((t (:underline "#A7A6AA" :foreground "#008ED1" :background "#000000"))))
 '(org-block
   ((t (:background "#000000"))))
 '(org-block-end-line
   ((t (:overline "#A7A6AA" :foreground "#008ED1" :background "#000000"))))
 )

(use-package babel
  :ensure t
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (C . t)
     (java . t)
     (js . t)
     (ruby . t)
     (ditaa . t)
     (python . t)
     (shell . t)
     (latex . t)
     (plantuml . t)
     (R . t)))
  
  )

;; 显示图片
(setq org-image-actual-width 300)    
