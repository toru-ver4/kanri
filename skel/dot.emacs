;; itagaki に命じられ以下の文を冒頭に付け加えることにする．
;; PATHの設定．
(setq load-path
      (append
       '(expand-file-name "~/.emacs.d/site-lisp")	        ; 自分のsite-lisp 1
       '(expand-file-name "~/Ohhhhh/share/emacs/site-lisp")	; 自分のsite-lisp 2
       '(expand-file-name "~avsf/share/emacs/site-lisp")	; 共有site-lisp．
       load-path))

(require 'add-subdirs-to-load-path)
(add-subdirs-to-load-path (expand-file-name "~/.emacs.d/site-lisp"))
(add-subdirs-to-load-path (expand-file-name "~avsf/share/emacs/site-lisp"))

;;
;; Keyboad Translate Table (Delete <=> BackSpace)
;;
(setq keyboard-translate-table "\C-@\C-A\C-B\C-C\C-D\C-E\C-F\C-G\177\t\n\C-K\f\r\C-N\C-O\C-P\C-Q\C-R\C-S\C-T\C-U\C-V\C-W\C-X\C-Y\C-Z\C-[\C-\\\C-]\C-^\C-_ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\b")

;; M-h : Help
;; C-h : Help 今日から君が〜Helpだよぅ〜！
;;(global-set-key "\C-h" 'help)
(global-set-key "\C-z" 'undo)

(require 'un-define)
(require 'jisx0213) 
;; 日本語環境(EUC)
(set-language-environment "Japanese")
(prefer-coding-system 'euc-jp)
(set-default-coding-systems 'euc-jp)
(set-terminal-coding-system 'euc-jp)
(setq default-buffer-file-coding-system 'euc-jp)
(setq default-file-name-coding-system 'euc-jp)
(setq default-keyboard-coding-system 'euc-jp)
(setq default-sendmail-coding-system 'iso-2022-jp)

;; wnn6の呼び出し
(setq input-method "japanese-egg-wnn")
(setq wnn-jserver '("momo"))		

;; japanese-anthy をデフォルトの input-method にする。
;;(setq default-input-method "japanese-anthy")
;; 句読点とカンマ・ピリオドに変更
;;(anthy-change-hiragana-map "," "，")
;;(anthy-change-hiragana-map "." "．")
;; 常に半角スペース
;;(setq anthy-wide-space " ")


;;Anthyの導入（一時凍結中）
;;(push "/usr/local/share/emacs/site-lisp/anthy" load-path)
;;(load-library "anthy")
;;(setq dafault-input-method "japanese-anthy")

;; isearch のバグフィックスパッチ
(let ((load-status (load "tamago-isearch-fix.el" t))))

;; リージョンに色をつけよう．
(setq transient-mark-mode t)                    ; 色を付けるぜ宣言．
(set-face-foreground 'region nil)               ; フォアグラウンドの色．そのままで．
(set-face-background 'region "DeepSkyBlue4") ; バックグラウンドの色．
;;(set-face-background 'region "firebrick1") ; バックグラウンドの色．
;; 括弧をピカピカ
(cond
 ((fboundp 'paren-set-mode)            ; XEmacs
  (paren-set-mode 'paren))
 ((fboundp 'show-paren-mode)            ; Standard Emacs
  (show-paren-mode t)))

;; 「。」を「．」に 「、」を「，」に変更
;; 一般に技術論文では「。、」ではなく「．，」を用いる
(setq its-hira-period "．")
(setq its-hira-comma  "，")

;; "n" = "nn" = "ん"
(setq enable-double-n-syntax t)         ; "nn" and "n'"

;;スクロールをマウスで
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)

(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)

;;;; LaTeX記述支援ソフト 野鳥（やてふ）の設定
(require 'yatex-startup)
(setq YaTeX-kanji-code 3) ; euc
(setq yahtml-kanji-code 3) ; euc
;;(setq tex-command "platex") ; platexでtype-setしてくれる
(setq tex-command "latexmk") ; platexでtype-setしてくれる
(setq dvi2-command "xdvi -rv -geometry 711x1006-0-0 -s 7")

;; reftex-modeを自動起動．
(add-hook 'yatex-mode-hook
          '(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
(setq reftex-default-bibliography '("/lib/tex/main.bib"))

;;;; svn + cvs 設定関連
;; psvnをオン
(require 'psvn)
;; psvnモードへのショートカットの設定．
(global-set-key "\M-s" 'svn-status)  ;;M-s = svn-status 

;; pcl-cvsモードへのショートカットの追加
(global-set-key "\M-c" 'cvs-status)  ;;M-c = cvs-status
(global-set-key "\C-cv" 'cvs-update) ;pcl-cvs-update

;; pcl-cvsモード用フック
(add-hook 'yatex-mode-hook
          '(lambda ()
             (local-set-key "\C-cv" 'cvs-update)
             )
	  )

;; textモード時のpcl-cvsモード用フック
(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key "\M-s" 'svn-status)
             )
          )


;;フォントに色を付けましょう
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;Mew
(setq mew-use-overlay-keymap nil)
(autoload 'mew "mew" nil t);
(autoload 'mew-send "mew" nil t)
;;個人毎の変更部
(setq mew-name "Toru Yoshihara") ;; (user-full-name)

(setq mew-mail-domain "ice.uec.ac.jp") ;; (domain-name)
(setq mew-pop-server  "pop.ice.uec.ac.jp") ;; if not localhost
(setq mew-smtp-server "smtp.ice.uec.ac.jp") ;; if not localhost
(setq mew-icon-directory "/usr/local/share/emacs/etc/mew3")

;;Mewでの受信容量制限 0 で無制限 (* x y)だと x*y [Byte]になる． 
(setq mew-pop-size 0) 	

;;APOPパスワードをキャッシュに保管（保管時間は (* 60 12)=(720min)）
(setq mew-use-cached-passwd t)
(setq mew-passwd-timer-unit (* 60 12))

; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

; サマリに漢字の曜日を出す．差出人幅も長くして，なるべく全部収まるようにする．
(defun mew-scan-form-youbi ()
  (let ((s (MEW-DATE)))
    (if (>= (length s) 3) (setq s (substring s 0 3)))
    (cond 
     ((string= s "Mon") "月")
     ((string= s "Tue") "火")
     ((string= s "Wed") "水")
     ((string= s "Thu") "木")
     ((string= s "Fri") "金")
     ((string= s "Sat") "土")
     ((string= s "Sun") "日")
     (t "??"))))
  
(setq mew-scan-form
      '(type (5 date) "(" (2 youbi) ")[" (-4 time) "] " 
	     (18 from) " " t (0 subj)))

;(setq mew-scan-form
;      '(type (4 year) " " (5 date) " " (5 time) " " (14 from) " " t (0 subj))
;      )

;;Emacsのディスプレイの設定
(if window-system
    (progn
      (if (x-display-color-p)
	  (progn
	    ;;(set-face-background 'region "green") 
	    (set-face-background 'highlight "Turquoise")
	    (set-face-background 'modeline "MidnightBlue")
	    (set-face-foreground 'modeline "Cyan"))
	(set-face-underline-p 'region nil)
	(set-face-underline-p 'highlight t)
	(set-face-underline-p 'paren t)
	)
      (setq show-paren-match-face 'underline)
      (require 'paren)
      )
  ) 


;;スクロールバーを右に
;;(set-scroll-bar-mode 'right)
(scroll-bar-mode nil)
;;(toggle-scroll-bar nil)
;;時刻の表示
(setq display-time-day-and-date t)

;;行番号 on
(line-number-mode t)

;;桁番号 on
(column-number-mode t)

;;Tool bar Icon 削除
(tool-bar-mode nil) 

;;Menu bar Icon 削除
(menu-bar-mode nil)

;;ローマ字変換規則設定
;;必要な部分をコメントアウトすることで有効に
(defun my-customize-romaji-tamago4-hira ()
		(interactive)
		(define-its-state-machine-append
		  its-hira-map
		  (its-defrule "la" "ぁ" nil t)
		  (its-defrule "li" "ぃ" nil t)
		  (its-defrule "lu" "ぅ" nil t)
		  (its-defrule "le" "ぇ" nil t)
		  (its-defrule "lo" "ぉ" nil t)
		  (its-defrule "ltu" "っ" nil t)
		  (its-defrule "lya" "ゃ" nil t)
		  (its-defrule "lyu" "ゅ" nil t)
		  (its-defrule "lyo" "ょ" nil t)
		  (its-defrule "dhi" "でぃ" nil t)
		  (its-defrule "dhu" "でゅ" nil t)
		  )
		)
(eval-after-load "its/hira" '(my-customize-romaji-tamago4-hira))

;;  Lookup の設定

(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

(define-key ctl-x-map "l" 'lookup)              ;C-x l -lookup
(define-key ctl-x-map "y" 'lookup-region)       ;C-x y -lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern)   ;C-x C-y -lookup-pattern

(setq lookup-search-agents '((ndtp "oki" :port 2010)))

;; confファイルの編集時に林田モード
; DSP,conffileの設定
;;; load-path の設定
(setq load-path
      (append
       (list
	(expand-file-name "~/.emacs.d")
	) ; list end
       load-path))

;;;  conf* --> asm mode (04.07.12)
(setq auto-mode-alist (append (list (cons "[/]conf.*$" 'asm-mode)) ;本当は[/]じゃいやだな
                              auto-mode-alist))

(add-hook 'asm-mode-hook ; asm モード色を付ける
	  '(lambda () (require 'asm-hilit)))

;;(add-hook 'auto-complete-mode-hook ; asm モード色を付ける
;;	  '(lambda () (require 'auto-complete-mode)))

;;----------------------------------
;; 2005.12.09 itagakiがMewの全文検索の方法をみつけた
;; /homes/avsf/bin/READMEの mg のところを見よ．以下は，それに関する追加
      ;; C-u? で使用するコマンドを指定
      (setq mew-prog-grep "mg")
      (setq mew-prog-grep-opts '("--euc" "-j" "jis" "-l" "-e" "-x" "&mime"))
      ;; C-u/ で使用するコマンドを指定
      (setq mew-prog-vgrep mew-prog-grep)
      (setq mew-prog-vgrep-opts mew-prog-grep-opts)
;;----------------------------------
;;2006.07.04の板垣のメイルより．
;;psvnでログを見るとき，ログの最初の1行の色が，おかしくなることがitagakiと
;;先生のEmacsで起こっていました．もしおかしくなっていた場合は，
;;とりあえず(require 'psvn)よりも手前に，以下の記述を加えればとりあえず解決します．
;;応急処置的なのでなんとも汚いですが，とりあえずということで． 
(defvar svn-log-view-font-lock-keywords
  '(("^\\(r[0-9]+ +|\\)" 
     (1 `(face font-lock-keyword-face
	       keymap ,svn-log-view-popup-menu-map)))
    ("^\\(r[0-9]+ +|\\)\\([^|]*\\)|" 
     (2 `(face svn-status-update-available-face
	       keymap ,svn-log-view-popup-menu-map)))
    ("^\\(r[0-9]+ +|\\)\\([^|]*\\)\\(|.+\\)$" 
     (3 `(face font-lock-keyword-face
	       keymap ,svn-log-view-popup-menu-map)))
    )
  "Keywords in svn-log-view-mode.")
;;----------------------------------
;; 2006.4.11 tomのSubversion紹介輪講の直後にtomから, 
;; そのあと4/11のwaka-sのメイル．psvnをオン
(require 'psvn)
;; psvnモードへのショートカットの設定．
(global-set-key "\M-m" 'svn-status)  ;;M-s = svn-status 
;; textモード時のpcl-svnモード用フック
(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key "\M-m" 'svn-status)
             )
          )
;;----------------------------------
;; 日本語入力中にも，即座にquitできる．
;; 2006/10/28 tomが教えてくれる．
 (add-hook 'egg-mode-hook
	  (lambda () (define-key its-mode-map "\C-g" 
		       (lambda ()
			 (interactive)
			 (its-cancel-input)
			 (keyboard-quit)))))

;; by tom 使いたくなったらコメントアウトしてね

;; バックアップファイルを作らない
(setq backup-inhibited t) ;; *~
(setq auto-save-default nil) ;; #*

;; 画像ファイルを表示
;;(auto-image-file-mode)

;;Shiftカーソルでウィンドウ間移動．
;;(windmove-default-keybindings)

;;C-x C-bをbuffer-menuに	
(global-set-key "\C-x\C-b" 'buffer-menu)

;;C-x bでbuffersを選ぶ時便利
;;(iswitchb-default-keybindings)
;;(add-hook 'iswitchb-define-mode-map-hook
;;         'iswitchb-my-keys)

(defun iswitchb-my-keys ()
 "Add my keybindings for iswitchb."
 (define-key iswitchb-mode-map [right] 'iswitchb-next-match)
 (define-key iswitchb-mode-map [left] 'iswitchb-prev-match)
 (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
 (define-key iswitchb-mode-map " " 'iswitchb-next-match)
 (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
 )

;;(resize-minibuffer-mode)

;; スクリプト保存時にchmod
(defun make-file-executable ()
  "Make the file of this buffer executable, when it is a script source."
  (save-restriction
    (widen)
    (if (string= "#!" (buffer-substring-no-properties 1 (min 3 (point-max))))
        (let ((name (buffer-file-name)))
          (or (equal ?. (string-to-char (file-name-nondirectory name)))
              (let ((mode (file-modes name)))
                (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                (message (concat "Wrote " name " (+x)"))))))))
(add-hook 'after-save-hook 'make-file-executable)

;; シェルモード用の日本語の設定 + C-p C-n でヒストリ
;;(add-hook 'shell-mode-hook
;;          (function
;;           (lambda ()
;;             (set-buffer-process-coding-system 'euc-jp 'euc-jp)
;;	     (local-set-key "\C-p" 'comint-previous-input)	     
;;	     (local-set-key "\C-n" 'comint-next-input)	     
;;	     )
;;	   )
;;)

;; itagaki より授かりし秘密の技！
;; Emacs上でsvnの過去ログを見る
(require 'svn-update-log)
(global-set-key "\M-u" 'svn-update-log)
(global-set-key "\M-n" 'svn-view-log-this-file)

;; enlarge-window-10
;;                  by itagaki

(defun enlarge-window-10 ()
  "enlarge-windowを使ってウィンドウを広げる"
  (interactive)
  (while (> (- (screen-height) (window-height)) 10)
    (enlarge-window 1)))

(global-set-key "\C-x/" 'enlarge-window-10)

;; w3m
(autoload 'w3m "w3m"
  "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m"
  "Find a local file using emacs-w3m." t)
(autoload 'w3m-search "w3m-search"
  "Search words using emacs-w3m." t)
(autoload 'w3m-weather "w3m-weather"
  "Display a weather report." t)
(autoload 'w3m-antenna "w3m-antenna"
  "Report changes of web sites." t)
(autoload 'w3m-namazu "w3m-namazu"
  "Search files with Namazu." t)
;; クッキーを有効にする
(setq w3m-use-cookies t)


;; itagaki 作成 「文字数カウント！」
;; M-+ で起動！！！
;; word-count-mode
(autoload 'word-count-mode "word-count"
	  "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;; M-qで折り返す文字数
(setq default-fill-column 80)	; (デフォルト値 : 70)
;;(setq fill-column 80)

;; ウィンドウの移動！！
(global-set-key "\M-h" 'windmove-left)
(global-set-key "\M-j" 'windmove-down)
(global-set-key "\M-k" 'windmove-up)
(global-set-key "\M-l" 'windmove-right)

;; Latex でコメントアウト C-c C-c
(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map "\C-c\C-c" 'comment-region)))

;;;; ================================================================================
;; デッドライン ヒャッホーィ！！！！
(require 'display-deadline)
(display-deadline "三橋レポート〆切：あと%d日%h時間%m分" (encode-time 00 00 21 6 6 2008))

;;;; ================================================================================
;; メジャーモードの追加．

(require 'masm-mode)	; masm-mode．(DSP56300を編集するメジャーモード．)
(require 'mconf-mode)	; mconf-mode．(confファイルを編集するメジャーモード．)
(require 'cook-mode)	; cook-mode．なくてもいいが，入れておこう．
(setq auto-mode-alist (append '(("\\.asm$"	   . masm-mode))
			      '((".*/dsp/.*/conf.*$" . mconf-mode))
			      auto-mode-alist))

;;;; ================================================================================
;; ぷっぷ音を鳴らさないための処理

(setq visible-bell t)

;;;; ================================================================================
;; 起動時に最近開いたファイル一覧を表示．
(recentf-mode t)	; recentf-modeをON．
;; recentf-open-filesを実行したときに，初期位置を2行下げる．
(defadvice recentf-open-files (after hl-line-recentf-open-files activate)
  (switch-to-buffer "*Open Recent*")
  (hl-line-mode)
  (forward-line 2))
(recentf-open-files)	; 初期画面をrecentfにする．
(define-key ctl-x-map "\C-r" 'recentf-open-files)
(setq recentf-max-saved-items 2000)


;; ぼうがぐるぐる．by itagaki 2008.01.25
;(require 'twiddle)
;(setq twiddle-rotate-chars '(?- ?森 ?の ?水 ?だ ?よ ?り))
;(setq twiddle-delay 0.1)
;(twiddle-stop)
;(twiddle-start)

;; css-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;; Yahtml
(autoload 'yahtml-mode "yahtml" "Yet Another HTML mode" t)
(setq auto-mode-alist (cons (cons "\\.html?$" 'yahtml-mode) auto-mode-alist))
(setq yahtml-www-browser "sese-firefox");; yatex の html モードで起動するビューワ

;; カラーサンプルを画面上に表示
(autoload 'list-hexadecimal-colors-display "color-selection"
  "Display hexadecimal color codes, and show what they look like." t)

;; 画像をemacsで表示
(setq image-file-name-extension nil)
(auto-image-file-mode)

;; vip-mode
(setq vip-inhibit-startup-message t)
(setq vip-re-search t)
(setq vip-re-replace t)
(setq vip-re-query-replace t)
(setq vip-open-with-indent t)
(eval-after-load "vip"
  '(define-key vip-mode-map "s" 'vip-substitute))

;; フレーム作成およびフレーム削除のキーバインドを追加
(global-set-key "\C-xj" 'make-frame-command)
(global-set-key "\C-xh" 'delete-frame)
(global-set-key "\C-t" 'enlarge-window)

;; 右側で表示を自動的に折り返す            by sugimoto 2008.05.11
(setq truncate-partial-width-windows nil)

;; change color-theme
;;(load "~/.emacs.d/site-lisp/themes/color-theme-library.el")
;;(require 'color-theme)
;;(color-theme-dark-laptop)  
;;(global-font-lock-mode t)

;; css-mode
(autoload 'basic-mode "basic-mode")
(setq auto-mode-alist
      (cons '("\\.bas\\'" . basic-mode) auto-mode-alist))

;; run-prolog
(setq auto-mode-alist
      (append '(("\\.pr" . prolog-mode))
       auto-mode-alist))
(setq prolog-program-name "/usr/local/bin/cuprolog")

;; enlarge-window-10
;;                  by itagaki
(defun enlarge-window-10 ()
  "enlarge-windowを使ってウィンドウを広げる"
  (interactive)
  (while (> (- (screen-height) (window-height)) 10)
    (enlarge-window 1)))

(global-set-key "\C-x/" 'enlarge-window-10)

;; キーバインド無効
(global-set-key "\C-x\C-t" 'undefined)
(global-set-key "\C-x\C-z" 'undefined)

;; 起動時に最近開いたファイル一覧を表示．
(recentf-mode t)	; recentf-modeをON．

;; recentf-open-filesを実行したときに，初期位置を2行下げる．
(defadvice recentf-open-files (after hl-line-recentf-open-files activate)
  (switch-to-buffer "*Open Recent*")
  (hl-line-mode)
  (forward-line 2))
(recentf-open-files)	; 初期画面をrecentfにする．
(define-key ctl-x-map "\C-r" 'recentf-open-files)
(setq recentf-max-saved-items 2000)

;; reftex-mode の自動起動
(add-hook 'yatex-mode-hook
          #'(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; octave-mode
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
           (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
               (lambda ()
                 (abbrev-mode 1)
                 (auto-fill-mode 1)
                 (if (eq window-system 'x)
                     (font-lock-mode 1))))

;; gtags-mode
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
;; 自動でgtags-modeに移行
(add-hook 'c-mode-common-hook
          #'(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))

;; printf と fprintf の テンプレ作成
(defun ty_printf ()
  (interactive)
  (insert "printf(\"\\n\")\;"))
(global-set-key "\C-cp" 'ty_printf)

(defun ty_fprintf ()
  (interactive)
  (insert "fprintf(stderr, \"\\n\")\;"))
(global-set-key "\C-cf" 'ty_fprintf)

;; 拡張子に応じてテンプレートを挿入
;; auto-insert
(setq auto-insert-directory "~/.code_template/")
(load "autoinsert" t)
(setq auto-insert-alist
  (append '(
    ("\.py$"   . "template.py")
    ("\.c$"   . "template.c")
  ) auto-insert-alist))
(add-hook 'find-file-hooks 'auto-insert)
(add-hook 'find-file-not-found-hooks 'auto-insert)

;; compile を M-c にバインド
(setq compile-command "gmake install")
(global-set-key "\M-c" 'compile)

;; 全スクロールではなく半スクロールに
(defun scroll-up-half ()
  "Scroll up half a page."
  (interactive)
  (scroll-up (/ (window-height) 3))
)

(defun scroll-down-half ()
  "Scroll down half a page."
  (interactive)
  (scroll-down (/ (window-height) 3))
)

(global-set-key "\C-v" 'scroll-up-half)
(global-set-key "\M-v" 'scroll-down-half)

;------------画面分割の記憶  はじめ
;;http://www.bookshelf.jp/soft/meadow_30.html#SEC404
;; キーバインドを保存
;;デフォルトは，C-c C-w
;; 変更しない場合は以下の３行を削除する．
;;(setq win:switch-prefix "\C-z")
;;(define-key global-map win:switch-prefix nil)
;;(define-key global-map "\C-z1" 'win-switch-to-window)
(require 'windows)
;; 新規にフレームを作らない
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
(global-set-key "\M-r" 'win-resume-menu)
;------------画面分割の記憶  おわり

;; wnn+eggの設定だお
;; 変換候補を表示するまでの回数を指定するんだお
(setq egg-conversion-auto-candidate-menu 1)
;; アルファベットで入力確定
(setq menudiag-select-without-return t)
;; 先頭に戻る
(setq egg-conversion-wrap-select t)

;; クリップボードに関する設定
(global-set-key "\M-w" 'clipboard-kill-ring-save)  ; クリップボードにコピー
(global-set-key "\C-w" 'clipboard-kill-region)     ; 切り取ってクリップボードへ

;; コンパイルに関する設定
(setq compilation-window-height 10) ;行数が減る by kfuru

;; 以下は navi2ch に関する設定
;; 必ず書く設定
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
;; 終了時に訪ねない
(setq navi2ch-ask-when-exit nil)
;; スレのデフォルト名を使う
(setq navi2ch-message-user-name "")
;; あぼーんがあったたき元のファイルは保存しない
(setq navi2ch-net-save-old-file-when-aborn nil)
;; 送信時に訪ねない
(setq navi2ch-message-ask-before-send nil)
;; kill するときに訪ねない
(setq navi2ch-message-ask-before-kill nil)
;; バッファは 5 つまで
(setq navi2ch-article-max-buffers 5)
;; navi2ch-article-max-buffers を超えたら古いバッファは消す
(setq navi2ch-article-auto-expunge t)
;; Board モードのレス数欄にレスの増加数を表示する。
(setq navi2ch-board-insert-subject-with-diff t)
;; Board モードのレス数欄にレスの未読数を表示する。
(setq navi2ch-board-insert-subject-with-unread t)
;; 既読スレはすべて表示
(setq navi2ch-article-exist-message-range '(1 . 1000))
;; 未読スレもすべて表示
(setq navi2ch-article-new-message-range '(1000 . 1))
;; 3 ペインモードでみる
;;(setq navi2ch-list-stay-list-window t)
;; C-c 2 で起動
;;(global-set-key "\C-c2" 'navi2ch)

(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-other-frame "wl" "Wanderlust on new frame." t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)

(load-library "navi")
(global-set-key [f11] 'call-navi)
(global-set-key "\C-x\C-l" 'call-navi)
(defun call-navi ()
  (interactive)
  (navi (buffer-name)))

;; C-b で華麗にバッファを選択
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )


;; ポップアップで補間する
(require 'auto-complete)
;; M-/ で補間開始にする
(global-auto-complete-mode t)
;;(global-set-key "\M-/" 'ac-start)

;; これを書くと，複数のバッファの内容を補間できるようになる？．
(setq-default ac-sources '(ac-source-abbrev ac-source-words-in-all-buffer))

;; 補間開始文字数の指定
(setq ac-auto-start 2)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; Maybe default-enable-multibyte-characters is t by default
;; (setq default-enable-multibyte-characters t) ;; カット

;; kill ring を効率よく使おう．
(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)

;; kill-ring を一行で表示
(setq browse-kill-ring-display-style 'one-line)
;; browse-kill-ring 終了時にバッファを kill する
(setq browse-kill-ring-quit-action 'kill-and-delete-window)
;; 必要に応じて browse-kill-ring のウィンドウの大きさを変更する
(setq browse-kill-ring-resize-window t)
;; kill-ring の内容を表示する際の区切りを指定する
(setq browse-kill-ring-separator "-------")
;; 現在選択中の kill-ring のハイライトする
(setq browse-kill-ring-highlight-current-entry t)
;; 区切り文字のフェイスを指定する
(setq browse-kill-ring-separator-face 'region)
;; 一覧で表示する文字数を指定する． nil ならすべて表示される．
(setq browse-kill-ring-maximum-display-length 100)

;;; GDB 関連
;;; 有用なバッファを開くモード
(setq gdb-many-windows t)

;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))

;; AutoComplete for yatex
(when (require 'auto-complete nil t)
  (require 'auto-complete-yatex)
  )
(setq ac-yatex-user-keywords
      (list "Lbox[]{}" "Rbox[]{}" "MARU{}" "maru{}" "RN{}" "Hline"
	    "makeatletter" "makeatother"
	    "setbox" "lower" "raise" "llap" "rlap"
	    "hbox{}" "mbox{}" "fbox{}" "parbox[]{}"
	    "hfil" "hfill" "hss" "hskip" "hspace*{}"
	    "vfil" "vfill" "vss" "vskip" "vspace*{}"
	    "baselineskip" "onelineskip" "halflineskip"
	    ))

; 起動時のメッセージ非表示
(setq inhibit-startup-message t)



;; === howm の設定 basic ===
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

;; === howm の設定 custermize ===
;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)

;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)

;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)

;; howm のファイル名
;; 以下のスタイルのうちどれかを選んでください
;; で，不要な行は削除してください
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")

(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))

;; メニューを自動更新しない
(setq howm-menu-refresh-after-save nil)
;; 下線を引き直さない
(setq howm-refresh-after-save nil)

(require 'git-emacs)
