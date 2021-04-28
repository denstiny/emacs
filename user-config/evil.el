(evil-leader/set-key
  "f" 'find-file
  "bb" 'switch-to-buffer
  "w/" 'split-window-right
  "w-" 'split-window-below
  ":"  'counsel-M-x
  "q"  'kill-buffer
  )
(define-key evil-normal-state-map (kbd "gs") 'xref-find-references)
(define-key evil-normal-state-map (kbd "tt") 'lsp-treemacs-symbols)
(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'evil-normal-state))
