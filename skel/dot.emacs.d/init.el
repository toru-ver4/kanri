; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ site-lisp                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

(let ( (default-directory
         (file-name-as-directory (concat user-emacs-directory "site-lisp")))
       )
  (add-to-list 'load-path default-directory)
  (normal-top-level-add-subdirs-to-load-path)
  )

;; ------------------------------------------------------------------------
;; @ coding system
(cond
 ((string-match "linux" system-configuration)
  )
 ((string-match "mingw" system-configuration)
   ;; 日本語入力のための設定
   (set-keyboard-coding-systm 'cp932)

   (prefer-coding-system 'utf-8-dos)
   (set-file-name-coding-system 'cp932)
   (setq default-process-coding-system '(cp932 . cp932))
  )
 )


;; ------------------------------------------------------------------------
;; @ ime
(cond
 ((string-match "linux" system-configuration)
  )
 ((string-match "mingw" system-configuration)
   ;; 標準IMEの設定
   (setq default-input-method "W32-IME")

   ;; IME状態のモードライン表示
   (setq-default w32-ime-mode-line-state-indicator "[Aa]")
   (setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))

   ;; IMEの初期化
   (w32-ime-initialize)

   ;; IME OFF時の初期カーソルカラー
   ;; (set-cursor-color "red")

   ;; IME ON/OFF時のカーソルカラー
   ;; (add-hook 'input-method-activate-hook
   ;;           (lambda() (set-cursor-color "green")))
   ;; (add-hook 'input-method-inactivate-hook
   ;;           (lambda() (set-cursor-color "red")))

   ;; バッファ切り替え時にIME状態を引き継ぐ
   (setq w32-ime-buffer-switch-p nil)
  )
 )

;; ------------------------------------------------------------------------
;; @ encode
(cond
 ((string-match "linux" system-configuration)
  )
 ((string-match "mingw" system-configuration)
   ;; ;; 機種依存文字
   ;; (require 'cp5022x)
   ;; (define-coding-system-alias 'euc-jp 'cp51932)

   ;; decode-translation-table の設定
   (coding-system-put 'euc-jp :decode-translation-table
              (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
   (coding-system-put 'iso-2022-jp :decode-translation-table
              (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
   (coding-system-put 'utf-8 :decode-translation-table
              (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

   ;; encode-translation-table の設定
   (coding-system-put 'euc-jp :encode-translation-table
              (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
   (coding-system-put 'iso-2022-jp :encode-translation-table
              (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
   (coding-system-put 'cp932 :encode-translation-table
              (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
   (coding-system-put 'utf-8 :encode-translation-table
              (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

   ;; charset と coding-system の優先度設定
   (set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
             'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
   (set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

   ;; PuTTY 用の terminal-coding-system の設定
   (apply 'define-coding-system 'utf-8-for-putty
      "UTF-8 (translate jis to cp932)"
      :encode-translation-table 
      (get 'japanese-ucs-jis-to-cp932-map 'translation-table)
      (coding-system-plist 'utf-8))
   (set-terminal-coding-system 'utf-8-for-putty)

   ;; East Asian Ambiguous
   (defun set-east-asian-ambiguous-width (width)
     (while (char-table-parent char-width-table)
       (setq char-width-table (char-table-parent char-width-table)))
     (let ((table (make-char-table nil)))
       (dolist (range 
            '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
             (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
             #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
             (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0 
             (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
             #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
             (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
             (#x0148 . #x014B) #x014D (#x0152 . #x0153)
             (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
             #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
             (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
             #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
             (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401 
             (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
             (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
             (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
             #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
             #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
             #x212B (#x2153 . #x2154) (#x215B . #x215E) 
             (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
             (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
             (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
             #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
             (#x2227 . #x222C) #x222E (#x2234 . #x2237)
             (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
             (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
             (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
             #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
             (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595) 
             (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
             (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
             (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1) 
             (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
             (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
             #x2642 (#x2660 . #x2661) (#x2663 . #x2665) 
             (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
             (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F) 
             #xFFFD
             ))
     (set-char-table-range table range width))
       (optimize-char-table table)
       (set-char-table-parent table char-width-table)
       (setq char-width-table table)))
   (set-east-asian-ambiguous-width 2)

   ;; emacs-w3m
   (eval-after-load "w3m"
     '(when (coding-system-p 'cp51932)
        (add-to-list 'w3m-compatible-encoding-alist '(euc-jp . cp51932))))

   ;; Gnus
   (eval-after-load "mm-util"
     '(when (coding-system-p 'cp50220)
        (add-to-list 'mm-charset-override-alist '(iso-2022-jp . cp50220))))

   ;; SEMI (cf. http://d.hatena.ne.jp/kiwanami/20091103/1257243524)
   (eval-after-load "mcs-20"
     '(when (coding-system-p 'cp50220)
        (add-to-list 'mime-charset-coding-system-alist 
             '(iso-2022-jp . cp50220))))

   ;; 全角チルダ/波ダッシュをWindowsスタイルにする
   (let ((table (make-translation-table-from-alist '((#x301c . #xff5e))) ))
     (mapc
      (lambda (coding-system)
        (coding-system-put coding-system :decode-translation-table table)
        (coding-system-put coding-system :encode-translation-table table)
        )
      '(utf-8 cp932 utf-16le)))
  )
 )


;; ------------------------------------------------------------------------
;; @ font

   ;; 標準フォントの設定
   ;; (set-default-font "M+2VM+IPAG circle-12")

   ;; IME変換時フォントの設定（テストバージョンのみ）
   ;; (setq w32-ime-font-face "MigMix 1M")
   ;; (setq w32-ime-font-height 22)

   ;; 固定等幅フォントの設定
   ;; (set-face-attribute 'fixed-pitch    nil :family "M+2VM+IPAG circle")

   ;; 可変幅フォントの設定
   ;; (set-face-attribute 'variable-pitch nil :family "M+2VM+IPAG circle")

;; ------------------------------------------------------------------------
;; @ frame

   ;; フレームタイトルの設定
   (setq frame-title-format "%b")

;; ------------------------------------------------------------------------
;; @ buffer

   ;; バッファ画面外文字の切り詰め表示
   (setq truncate-lines nil)

   ;; ウィンドウ縦分割時のバッファ画面外文字の切り詰め表示
   (setq truncate-partial-width-windows t)

   ;; 同一バッファ名にディレクトリ付与
   (require 'uniquify)
   (setq uniquify-buffer-name-style 'forward)
   (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
   (setq uniquify-ignore-buffers-re "*[^*]+*")

;; ------------------------------------------------------------------------
;; @ fringe

   ;; バッファ中の行番号表示
   (global-linum-mode t)

   ;; 行番号のフォーマット
   ;; (set-face-attribute 'linum nil :foreground "red" :height 0.8)
   (set-face-attribute 'linum nil :height 0.8)
   (setq linum-format "%4d")

;; ------------------------------------------------------------------------
;; @ modeline

   ;; 行番号の表示
   (line-number-mode t)

   ;; 列番号の表示
   (column-number-mode t)

   ;; 時刻の表示
   (require 'time)
   (setq display-time-24hr-format t)
   (setq display-time-string-forms '(24-hours ":" minutes))
   (display-time-mode t)

   ;; cp932エンコード時の表示を「P」とする
   (coding-system-put 'cp932 :mnemonic ?P)
   (coding-system-put 'cp932-dos :mnemonic ?P)
   (coding-system-put 'cp932-unix :mnemonic ?P)
   (coding-system-put 'cp932-mac :mnemonic ?P)

;; ------------------------------------------------------------------------
;; @ cursor

   ;; カーソル点滅表示
   (blink-cursor-mode 0)

   ;; スクロール時のカーソル位置の維持
   (setq scroll-preserve-screen-position t)

   ;; スクロール行数（一行ごとのスクロール）
   (setq vertical-centering-font-regexp ".*")
   (setq scroll-conservatively 35)
   (setq scroll-margin 0)
   (setq scroll-step 1)

   ;; 画面スクロール時の重複行数
   (setq next-screen-context-lines 5)

;; ------------------------------------------------------------------------
;; @ default setting

   ;; 起動メッセージの非表示
   (setq inhibit-startup-message t)

   ;; スタートアップ時のエコー領域メッセージの非表示
   (setq inhibit-startup-echo-area-message -1)

;; ------------------------------------------------------------------------
;; @ image-library
   ;; (setq image-library-alist
   ;;       '((xpm "libxpm.dll")
   ;;         (png "libpng14.dll")
   ;;         (jpeg "libjpeg.dll")
   ;;         (tiff "libtiff3.dll")
   ;;         (gif "libungif4.dll")
   ;;         (svg "librsvg-2-2.dll")
   ;;         (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
   ;;         (glib "libglib-2.0-0.dll")
   ;;         (gobject "libgobject-2.0-0.dll"))
   ;;       )

;; ------------------------------------------------------------------------
;; @ backup

   ;; 変更ファイルのバックアップ
   (setq make-backup-files nil)

   ;; 変更ファイルの番号つきバックアップ
   (setq version-control nil)

   ;; 編集中ファイルのバックアップ
   (setq auto-save-list-file-name nil)
   (setq auto-save-list-file-prefix nil)

   ;; 編集中ファイルのバックアップ先
   (setq auto-save-file-name-transforms
         `((".*" ,temporary-file-directory t)))

   ;; 編集中ファイルのバックアップ間隔（秒）
   (setq auto-save-timeout 30)

   ;; 編集中ファイルのバックアップ間隔（打鍵）
   (setq auto-save-interval 500)

   ;; バックアップ世代数
   (setq kept-old-versions 1)
   (setq kept-new-versions 2)

   ;; 上書き時の警告表示
   ;; (setq trim-versions-without-asking nil)

   ;; 古いバックアップファイルの削除
   (setq delete-old-versions t)

;; ------------------------------------------------------------------------
;; @ key bind

   ;; 標準キーバインド変更
   (global-set-key "\C-z"          'scroll-down)

;; ------------------------------------------------------------------------
;; @ scroll

   ;; バッファの先頭までスクロールアップ
   (defadvice scroll-up (around scroll-up-around)
     (interactive)
     (let* ( (start_num (+ 1 (count-lines (point-min) (point))) ) )
       (goto-char (point-max))
       (let* ( (end_num (+ 1 (count-lines (point-min) (point))) ) )
         (goto-line start_num )
         (let* ( (limit_num (- (- end_num start_num) (window-height)) ))
           (if (< (- (- end_num start_num) (window-height)) 0)
               (goto-char (point-max))
             ad-do-it)) )) )
   (ad-activate 'scroll-up)

   ;; バッファの最後までスクロールダウン
   (defadvice scroll-down (around scroll-down-around)
     (interactive)
     (let* ( (start_num (+ 1 (count-lines (point-min) (point)))) )
       (if (< start_num (window-height))
           (goto-char (point-min))
         ad-do-it) ))
   (ad-activate 'scroll-down)

;; ------------------------------------------------------------------------
;; @ print

(cond
 ((string-match "linux" system-configuration)
  )
 ((string-match "mingw" system-configuration)
   (setq ps-print-color-p t
         ps-lpr-command "gswin32c.exe"
         ps-multibyte-buffer 'non-latin-printer
         ps-lpr-switches '("-sDEVICE=mswinpr2" "-dNOPAUSE" "-dBATCH" "-dWINKANJI")
         printer-name nil
         ps-printer-name nil
         ps-printer-name-option nil
         ps-print-header nil          ; ヘッダの非表示
         )
  )
 )

;; ------------------------------------------------------------------------
;; @ hiwin-mode
;(require 'hiwin)

;; hiwin-modeを有効化
;   (hiwin-activate)

;; 非アクティブウィンドウの背景色を設定
;   (set-face-background 'hiwin-face "gray25")

;; ------------------------------------------------------------------------
;; @ tabbar

   ;; (require 'tabbar)

   ;; ;; tabbar有効化
   ;; (tabbar-mode)

   ;; ;; タブ切替にマウスホイールを使用（0：有効，-1：無効）
   ;; (tabbar-mwheel-mode -1)

   ;; ;; タブグループを使用（t：有効，nil：無効）
   ;; (setq tabbar-buffer-groups-function nil)

   ;; ;; ボタン非表示
   ;; (dolist (btn '(tabbar-buffer-home-button
   ;;                tabbar-scroll-left-button
   ;;                tabbar-scroll-right-button))
   ;;   (set btn (cons (cons "" nil) (cons "" nil))))

   ;; ;; タブ表示 一時バッファ一覧
   ;; (defvar tabbar-displayed-buffers
   ;;   '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*"
   ;;     "*Faces*" "*Apropos*" "*Customize*" "*shell*" "*Help*")
   ;;   "*Regexps matches buffer names always included tabs.")

   ;; ;; 作業バッファの一部を非表示
   ;; (setq tabbar-buffer-list-function
   ;;       (lambda ()
   ;;         (let* ((hides (list ?\  ?\*))
   ;;                (re (regexp-opt tabbar-displayed-buffers))
   ;;                (cur-buf (current-buffer))
   ;;                (tabs (delq
   ;;                       nil
   ;;                       (mapcar
   ;;                        (lambda (buf)
   ;;                          (let ((name (buffer-name buf)))
   ;;                            (when (or (string-match re name)
   ;;                                      (not (memq (aref name 0) hides)))
   ;;                              buf)))
   ;;                        (buffer-list)))))
   ;;           (if (memq cur-buf tabs)
   ;;               tabs
   ;;             (cons cur-buf tabs)))))

   ;; ;; キーバインド設定
   ;; (global-set-key (kbd "<C-tab>")   'tabbar-forward-tab)
   ;; (global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

   ;; ;; タブ表示欄の見た目（フェイス）
   ;; (set-face-attribute 'tabbar-default nil
   ;;                     :background "SystemMenuBar")

   ;; ;; 選択タブの見た目（フェイス）
   ;; (set-face-attribute 'tabbar-selected nil
   ;;                     :foreground "red3"
   ;;                     :background "SystemMenuBar"
   ;;                     :box (list
   ;;                           :line-width 1
   ;;                           :color "gray80"
   ;;                           :style 'released-button)
   ;;                     :overline "#F3F2EF"
   ;;                     :weight 'bold
   ;;                     :family "ＭＳ Ｐゴシック"
   ;;                     )

   ;; ;; 非選択タブの見た目（フェイス）
   ;; (set-face-attribute 'tabbar-unselected nil
   ;;                     :foreground "black"
   ;;                     :background "SystemMenuBar"
   ;;                     :box (list
   ;;                           :line-width 1
   ;;                           :color "gray80"
   ;;                           :style 'released-button)
   ;;                     :overline "#F3F2EF"
   ;;                     :family "ＭＳ Ｐゴシック"
   ;;                     )

   ;; ;; タブ間隔の調整
   ;; (set-face-attribute 'tabbar-separator nil
   ;;                     :height 0.1)

;; ------------------------------------------------------------------------
;; @ setup-cygwin
   ;; (setq cygwin-mount-cygwin-bin-directory
   ;;       (concat (getenv "CYGWIN_DIR") "\\bin"))
   ;; (require 'setup-cygwin)
   ;; (file-name-shadow-mode -1)

;; ------------------------------------------------------------------------
;; @ shell
   ;; (require 'shell)
   ;; (setq explicit-shell-file-name "bash.exe")
   ;; (setq shell-command-switch "-c")
   ;; (setq shell-file-name "bash.exe")

   ;; ;; (M-! and M-| and compile.el)
   ;; (setq shell-file-name "bash.exe")
   ;; (modify-coding-system-alist 'process ".*sh\\.exe" 'cp932)

   ;; ;; shellモードの時の^M抑制
   ;; (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

   ;; ;; shell-modeでの補完 (for drive letter)
   ;; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

   ;; ;; エスケープシーケンス処理の設定
   ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color"
   ;;           "Set `ansi-color-for-comint-mode' to t." t)

   ;; (setq shell-mode-hook
   ;;       (function
   ;;        (lambda ()

   ;;          ;; シェルモードの入出力文字コード
   ;;          (set-buffer-process-coding-system 'sjis-dos 'sjis-unix)
   ;;          (set-buffer-file-coding-system    'sjis-unix)
   ;;          )))

;; ------------------------------------------------------------------------
;; @ menu-tree
   ;; (setq menu-tree-coding-system 'utf-8)
   ;; (require 'menu-tree)

;; ------------------------------------------------------------------------
;; @ migemo/cmigemo
   ;; (setq migemo-command (concat (getenv "INST_DIR")
   ;;                              "\\app\\cmigemo\\cmigemo"))
   ;; (setq migemo-options '("-q" "--emacs"))
   ;; (setq migemo-dictionary (concat (getenv "INST_DIR")
   ;;                                 "\\app\\cmigemo\\dict\\utf-8\\migemo-dict"))
   ;; (setq migemo-user-dictionary nil)
   ;; (setq migemo-regex-dictionary nil)
   ;; (setq migemo-use-pattern-alist t)
   ;; (setq migemo-use-frequent-pattern-alist t)
   ;; (setq migemo-pattern-alist-length 1024)
   ;; (setq migemo-coding-system 'utf-8-unix)
   ;; (load-library "migemo")
   ;; (migemo-init)


;; ------------------------------------------------------------------------
;; @ package manager
   (require 'package)
   (add-to-list 'package-archives
                '("melpa" . "http://melpa.milkbox.net/packages/") t)
   (add-to-list 'package-archives
                '("marmalade" . "http://marmalade-repo.org/packages/"))
   (package-initialize)

;; ------------------------------------------------------------------------
;; @ install if not installed
(require 'cl)
(defvar my-package-list
  '(auto-async-byte-compile
    auto-complete
    helm
    helm-ag
    helm-descbinds
    helm-ls-git
    init-loader
    magit
    open-junk-file
    yasnippet
    atom-dark-theme
    neotree))
(let ((not-installed
       (loop for package in my-package-list
             when (not (package-installed-p package))
             collect package)))
  (when not-installed
    (package-refresh-contents)
    (dolist (package not-installed)
      (package-install package))))

;; ------------------------------------------------------------------------
;; @ w32-symlinks

   ;; (custom-set-variables '(w32-symlinks-handle-shortcuts t))
   ;; (require 'w32-symlinks)

   ;; (defadvice insert-file-contents-literally
   ;;   (before insert-file-contents-literally-before activate)
   ;;   (set-buffer-multibyte nil))

   ;; (defadvice minibuffer-complete (before expand-symlinks activate)
   ;;   (let ((file (expand-file-name
   ;;                (buffer-substring-no-properties
   ;;                 (line-beginning-position) (line-end-position)))))
   ;;     (when (file-symlink-p file)
   ;;       (delete-region (line-beginning-position) (line-end-position))
   ;;       (insert (w32-symlinks-parse-symlink file)))))


;; ------------------------------------------------------------------------
;; @ toru.yoshihara personal settings
;; for windows
(global-set-key [M-kanji] 'ignore)

;; OS if version

(cond
 ((string-match "linux" system-configuration)
  )
 ((string-match "mingw" system-configuration)
  ;; add path for find, grep, and xargs.
;  (setenv "PATH" (format (expand-file-name "~/kanri/WindowsBinary/GnuWin32/bin") (getenv "PATH")))
  (setenv "PATH" (format (expand-file-name "~/kanri/WindowsBinary/Git/bin") (getenv "PATH")))
  )
 )

;; change find-grep command.
;;(setq grep-find-command '("find . -type f -print0 | xargs -0 -e grep -nH -e "))


;;---------------------------------------------------------------------------------
;; minimum settings
;;---------------------------------------------------------------------------------
;;; set color current-line
(global-hl-line-mode 1)
;; color settings
;(set-face-background 'hl-line "dakolivegreen")
;(set-face-background 'hl-line "gray20")
;(set-face-background 'hl-line "color-25")
;;; save history
(savehist-mode 1)
;;; save cursor position
(setq-default save-place t)
(require 'saveplace)
;;; brink bracket
(show-paren-mode 1)
;;; set C-h backspace
(global-set-key (kbd "C-h") 'delete-backward-char)
;;; display time on mode-line
(display-time)
;;; display line and column number
(line-number-mode 1)
(column-number-mode 1)
;;; coloring resion
(transient-mark-mode 1)
;;; light wait
(setq gc-cons-threshold (* 10 gc-cons-threshold))
;;; increase log max
(setq message-log-max 10000)
;;; permit recursive processing
(setq enable-recursive-minibuffers t)
;;; disable dialog box
(setq use-dialog-box nil)
(defalias 'message-box 'message)
;;; save history
(setq history-length 1000)
;;; fast display of key stroke
(setq echo-keystrokes 0.1)
;;; alarm settings of big file open
(setq large-file-warning-threshold (* 25 1024 1024))
;;; save history of minibuffer
(defadvice abort-recursive-edit (before minibuffer-save activate)
  (when (eq (selected-window) (active-minibuffer-window))
    (add-to-history minibuffer-history-variable (minibuffer-contents))))
;;; yes/no -> y/n
(defalias 'yes-or-no-p 'y-or-n-p)
;;; disable toolbar and menubar
(tool-bar-mode -1)
;(scroll-bar-mode -1)
(scroll-bar-mode 'right)
(menu-bar-mode -1)
;;; move window with hjkl
(global-set-key "\M-h" 'windmove-left)
(global-set-key "\M-j" 'windmove-down)
(global-set-key "\M-k" 'windmove-up)
(global-set-key "\M-l" 'windmove-right)
;;; search result move
(global-set-key "\M-n" 'next-error)
(global-set-key "\M-p" 'previous-error)
;; enlarge-window
(global-set-key "\C-T" 'enlarge-window)
;; C++ style
(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
             ))
;; C++ style
(add-hook 'c-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
	     (setq c-basic-offset 4)
	     (setq tab-width 4)
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
             ))
;; use clipboard
(setq x-select-enable-clipboard t)
;; enlarge window
(global-set-key "\C-t"  'enlarge-window)
;; not gen backupfile
(setq make-backup-files nil)

;;---------------------------------------------------------------------------------
;; minimum settings end
;;---------------------------------------------------------------------------------


;;; package settings

;;---------------------------------------------------------------------------------
;; yasnippet
;;---------------------------------------------------------------------------------
(require 'yasnippet)
(yas/global-mode 1)

;;---------------------------------------------------------------------------------
;; color-theme
;;---------------------------------------------------------------------------------

(setq custom-theme-directory "~/.emacs.d/themes/")
(load-theme 'atom-dark-nw t)
;(load-theme 'atom-dark t)
;(load-theme 'misterioso t)
;(load-theme 'manoj-dark t)

;;---------------------------------------------------------------------------------
;; auto-complete
;;---------------------------------------------------------------------------------
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
(ac-config-default)
;; C-n/C-pで候補選択
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)


(eval-when-compile (require 'cl))

;; ミニバッファで C-h でヘルプでないようにする
(load "term/bobcat")
(when (fboundp 'terminal-init-bobcat)
  (terminal-init-bobcat))

;;---------------------------------------------------------------------------------
;; magit
;;---------------------------------------------------------------------------------
(require 'magit)


;;---------------------------------------------------------------------------------
;; helm (basic)
;;---------------------------------------------------------------------------------
(require 'helm-config)
(require 'helm-command)
;;(require 'helm-descbinds)

(setq helm-idle-delay             0.3
      helm-input-idle-delay       0.3
      helm-candidate-number-limit 200)

(let ((key-and-func
       `((,(kbd "C-r")   helm-for-files)
         (,(kbd "C-^")   helm-c-apropos)
;         (,(kbd "C-;")   helm-resume)
	 (,(kbd "M-.")   helm-resume)
         (,(kbd "M-s s")   helm-occur)
	 (,(kbd "M-s g")   helm-ag)
         (,(kbd "M-x")   helm-M-x)
         (,(kbd "M-y")   helm-show-kill-ring)
         (,(kbd "M-z")   helm-do-grep)
         (,(kbd "C-S-h") helm-descbinds)
	 (,(kbd "C-x b") helm-buffers-list)
	 (,(kbd "C-x r") helm-recentf)
        )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))
(trace-function-background 'helm-mp-highlight-region) ;; bug fix??? http://www49.atwiki.jp/ntemacs/m/pages/32.html 
(setq helm-buffer-max-length 40)
;;---------------------------------------------------------------------------------
;; helm-gtags
;;---------------------------------------------------------------------------------
(require 'helm-gtags)
;;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
; '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative)))

(setq helm-gtags-auto-update t)

;; key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "C-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s t") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:foreground "color-39")))))

(add-to-list 'load-path "~/.emacs.d/psvn")
(require 'psvn)
(setq process-coding-system-alist '(("svn" . utf-8)))
(setq default-file-name-coding-system 'utf-8)
(setq svn-status-svn-file-coding-system 'utf-8)
