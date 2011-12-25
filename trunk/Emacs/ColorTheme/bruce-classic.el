;;bruce-classic.el
;;Classic Color Theme For Emacs, 
;;Dec. 25, 2011.
;;Author: Bruce (http://bruce-lab.blogspot.com/)
;;Usage: You must install color theme (http://www.nongnu.org/color-theme/) first.
;;Suppose you installed color theme to "./emacs-23.2/bruce/color-theme-6.6.0".
;;Copy this file to "./emacs-23.2/bruce/color-theme-6.6.0/themes/bruce-classic.el"
;;Add the following code (changes may needed!) to your ".emacs".
;;
;(setq load-path (cons "~/bruce/color-theme-6.6.0" load-path))
;(require 'color-theme)
;(color-theme-initialize)
;(bruce-classic)
;;
;;;;;;;;;;
;;;;;;;;;;
(defun bruce-classic ()
  (interactive)
  (color-theme-install
   '(bruce-classic
     ((background-color . "#ffffff")
      (background-mode . light)
      (border-color . "#969696")
      (cursor-color . "#000000")
      (foreground-color . "#000000")
      (mouse-color . "black"))
     (fringe ((t (:background "#969696"))))
     (mode-line ((t (:foreground "#ffffff" :background "#595959"))))
     (region ((t (:background "#c0c0c0"))))
     (font-lock-builtin-face ((t (:foreground "#00a000" :bold t))))
     (font-lock-comment-face ((t (:foreground "#a0a0a0"))))
     (font-lock-function-name-face ((t (:foreground "#000000" :bold t))))
     (font-lock-keyword-face ((t (:foreground "#0000a0" :bold t))))
     (font-lock-string-face ((t (:foreground "#0000ff" :bold t))))
     (font-lock-type-face ((t (:foreground"#0000a0" :bold t))))
     (font-lock-variable-name-face ((t (:foreground "#b03060" :bold t))))
     (font-lock-constant-face ((t (:bold t :foreground "#0000a0"))))
     (minibuffer-prompt ((t (:foreground "#7299ff" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'bruce-classic)
;;;;;;;;;;
;;;;;;;;;;