;;; module-css.el

(after! emr
  (emr-declare-command 'doom/css-toggle-inline-or-block
    :title "toggle inline/block"
    :modes '(css-mode less-css-mode scss-mode)
    :predicate (lambda () (not (use-region-p)))))

(sp-with-modes '(css-mode scss-mode less-css-mode stylus-mode)
  (sp-local-pair "/*" "*/" :post-handlers '(("[d-3]||\n[i]" "RET") ("| " "SPC"))))

(map! (:map* (css-mode-map scss-mode-map less-css-mode-map)
        :n "M-R" 'doom/web-refresh-browser)
      (:map* (css-mode-map scss-mode-map less-css-mode-map)
        :localleader :nv ";" 'doom/append-semicolon))

;; css & scss
(use-package css-mode
  :mode (("\\.css$"  . css-mode)
         ("\\.scss$" . scss-mode))
  :init
  (add-hook! css-mode
    '(yas-minor-mode-on flycheck-mode rainbow-mode highlight-numbers-mode
      doom|counsel-css-imenu-setup))
  :config
  (def-company-backend! css-mode (css yasnippet))
  (push '("css" "scss" "sass" "less" "styl") projectile-other-file-alist)

  (def-builder! scss-mode doom/scss-build)
  (def-company-backend! scss-mode (css yasnippet))
  (def-docset! scss-mode "sass,bourbon,compass,neat,css")
  (push '("scss" "css") projectile-other-file-alist))

(use-package sass-mode
  :mode "\\.sass$"
  :config
  (setq sass-command-options '("--style compressed"))
  (def-builder! sass-mode doom/sass-build)
  (def-company-backend! sass-mode (css yasnippet))
  (push '("sass" "css") projectile-other-file-alist))

(use-package less-css-mode
  :mode "\\.less$"
  :config (push '("less" "css") projectile-other-file-alist))

(use-package stylus-mode
  :mode "\\.styl$"
  :init (add-hook! stylus-mode '(yas-minor-mode-on flycheck-mode))
  :config (push '("styl" "css") projectile-other-file-alist))

(provide 'module-css)
;;; module-css.el ends here
