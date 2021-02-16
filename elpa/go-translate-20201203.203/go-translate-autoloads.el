;;; go-translate-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "go-translate" "go-translate.el" (0 0 0 0))
;;; Generated autoloads from go-translate.el

(autoload 'go-translate "go-translate" "\
Translate TEXT from FROM to TO.

Many things can be customized, with keywords or let-binding.

URL-FUN is used to specify the way to generate request url.
PRE-FUN is used to specify the way to pre-render.
REQ-FUN is used to specify the retrieving method.
RENDER-FUN is used to specify the way to render after request.

\(fn TEXT FROM TO &key (URL-FUN go-translate-url-function) (PRE-FUN go-translate-prepare-function) (REQ-FUN go-translate-request-function) (RENDER-FUN go-translate-render-function))" t nil)

(autoload 'go-translate-change-local-and-target-language "go-translate" "\
Config the default local and target language interactively." t nil)

(autoload 'go-translate-popup "go-translate" "\
Show the short translation of TEXT from FROM to TO quickly.

It will show in `posframe' and dispear in 20 seconds, and can be
broken by any user action.

You should make sure `posframe' is in your `load-path' to use this.

This example shows that it's very simple to extend functions
with current `go-translate'. Here we use the keyword style.

\(fn TEXT FROM TO)" t nil)

(autoload 'go-translate-popup-current "go-translate" "\
Translate the content under cursor: selection or word.
Auto judge the direction, if failed then take the default local/target
as the direction.

This will not prompt anything." t nil)

(autoload 'go-translate-kill-ring-save "go-translate" "\
Translate and just put result into kill ring for later yank.

Here we implement it with let-binding style." t nil)

(autoload 'go-translate-echo-area "go-translate" "\
Output the translate result to the echo area." t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "go-translate" '("go-translate-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; go-translate-autoloads.el ends here
