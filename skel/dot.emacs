;; itagaki ��̿�����ʲ���ʸ����Ƭ���դ��ä��뤳�Ȥˤ��롥
;; PATH�����ꡥ
(setq load-path
      (append
       '(expand-file-name "~/.emacs.d/site-lisp")	        ; ��ʬ��site-lisp 1
       '(expand-file-name "~/Ohhhhh/share/emacs/site-lisp")	; ��ʬ��site-lisp 2
       '(expand-file-name "~avsf/share/emacs/site-lisp")	; ��ͭsite-lisp��
       load-path))

(require 'add-subdirs-to-load-path)
(add-subdirs-to-load-path (expand-file-name "~/.emacs.d/site-lisp"))
(add-subdirs-to-load-path (expand-file-name "~avsf/share/emacs/site-lisp"))

;;
;; Keyboad Translate Table (Delete <=> BackSpace)
;;
(setq keyboard-translate-table "\C-@\C-A\C-B\C-C\C-D\C-E\C-F\C-G\177\t\n\C-K\f\r\C-N\C-O\C-P\C-Q\C-R\C-S\C-T\C-U\C-V\C-W\C-X\C-Y\C-Z\C-[\C-\\\C-]\C-^\C-_ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\b")

;; M-h : Help
;; C-h : Help �������鷯����Help���褥����
;;(global-set-key "\C-h" 'help)
(global-set-key "\C-z" 'undo)

(require 'un-define)
(require 'jisx0213) 
;; ���ܸ�Ķ�(EUC)
(set-language-environment "Japanese")
(prefer-coding-system 'euc-jp)
(set-default-coding-systems 'euc-jp)
(set-terminal-coding-system 'euc-jp)
(setq default-buffer-file-coding-system 'euc-jp)
(setq default-file-name-coding-system 'euc-jp)
(setq default-keyboard-coding-system 'euc-jp)
(setq default-sendmail-coding-system 'iso-2022-jp)

;; wnn6�θƤӽФ�
(setq input-method "japanese-egg-wnn")
(setq wnn-jserver '("momo"))		

;; japanese-anthy ��ǥե���Ȥ� input-method �ˤ��롣
;;(setq default-input-method "japanese-anthy")
;; �������ȥ���ޡ��ԥꥪ�ɤ��ѹ�
;;(anthy-change-hiragana-map "," "��")
;;(anthy-change-hiragana-map "." "��")
;; ���Ⱦ�ѥ��ڡ���
;;(setq anthy-wide-space " ")


;;Anthy��Ƴ���ʰ��������
;;(push "/usr/local/share/emacs/site-lisp/anthy" load-path)
;;(load-library "anthy")
;;(setq dafault-input-method "japanese-anthy")

;; isearch �ΥХ��ե��å����ѥå�
(let ((load-status (load "tamago-isearch-fix.el" t))))

;; �꡼�����˿���Ĥ��褦��
(setq transient-mark-mode t)                    ; �����դ��뤼�����
(set-face-foreground 'region nil)               ; �ե������饦��ɤο������Τޤޤǡ�
(set-face-background 'region "DeepSkyBlue4") ; �Хå����饦��ɤο���
;;(set-face-background 'region "firebrick1") ; �Хå����饦��ɤο���
;; ��̤�ԥ��ԥ�
(cond
 ((fboundp 'paren-set-mode)            ; XEmacs
  (paren-set-mode 'paren))
 ((fboundp 'show-paren-mode)            ; Standard Emacs
  (show-paren-mode t)))

;; �֡��פ�֡��פ� �֡��פ�֡��פ��ѹ�
;; ���̤˵�����ʸ�Ǥϡ֡����פǤϤʤ��֡����פ��Ѥ���
(setq its-hira-period "��")
(setq its-hira-comma  "��")

;; "n" = "nn" = "��"
(setq enable-double-n-syntax t)         ; "nn" and "n'"

;;���������ޥ�����
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

;;;; LaTeX���һٱ祽�ե� ��Ļ�ʤ�Ƥաˤ�����
(require 'yatex-startup)
(setq YaTeX-kanji-code 3) ; euc
(setq yahtml-kanji-code 3) ; euc
;;(setq tex-command "platex") ; platex��type-set���Ƥ����
(setq tex-command "latexmk") ; platex��type-set���Ƥ����
(setq dvi2-command "xdvi -rv -geometry 711x1006-0-0 -s 7")

;; reftex-mode��ư��ư��
(add-hook 'yatex-mode-hook
          '(lambda ()
              (reftex-mode 1)
              (define-key reftex-mode-map
                (concat YaTeX-prefix ">") 'YaTeX-comment-region)
              (define-key reftex-mode-map
                (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))
(setq reftex-default-bibliography '("/lib/tex/main.bib"))

;;;; svn + cvs �����Ϣ
;; psvn�򥪥�
(require 'psvn)
;; psvn�⡼�ɤؤΥ��硼�ȥ��åȤ����ꡥ
(global-set-key "\M-s" 'svn-status)  ;;M-s = svn-status 

;; pcl-cvs�⡼�ɤؤΥ��硼�ȥ��åȤ��ɲ�
(global-set-key "\M-c" 'cvs-status)  ;;M-c = cvs-status
(global-set-key "\C-cv" 'cvs-update) ;pcl-cvs-update

;; pcl-cvs�⡼���ѥեå�
(add-hook 'yatex-mode-hook
          '(lambda ()
             (local-set-key "\C-cv" 'cvs-update)
             )
	  )

;; text�⡼�ɻ���pcl-cvs�⡼���ѥեå�
(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key "\M-s" 'svn-status)
             )
          )


;;�ե���Ȥ˿����դ��ޤ��礦
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;;Mew
(setq mew-use-overlay-keymap nil)
(autoload 'mew "mew" nil t);
(autoload 'mew-send "mew" nil t)
;;�Ŀ�����ѹ���
(setq mew-name "Toru Yoshihara") ;; (user-full-name)

(setq mew-mail-domain "ice.uec.ac.jp") ;; (domain-name)
(setq mew-pop-server  "pop.ice.uec.ac.jp") ;; if not localhost
(setq mew-smtp-server "smtp.ice.uec.ac.jp") ;; if not localhost
(setq mew-icon-directory "/usr/local/share/emacs/etc/mew3")

;;Mew�Ǥμ����������� 0 ��̵���� (* x y)���� x*y [Byte]�ˤʤ롥 
(setq mew-pop-size 0) 	

;;APOP�ѥ���ɤ򥭥�å�����ݴɡ��ݴɻ��֤� (* 60 12)=(720min)��
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

; ���ޥ�˴�����������Ф������п�����Ĺ�����ơ��ʤ�٤��������ޤ�褦�ˤ��롥
(defun mew-scan-form-youbi ()
  (let ((s (MEW-DATE)))
    (if (>= (length s) 3) (setq s (substring s 0 3)))
    (cond 
     ((string= s "Mon") "��")
     ((string= s "Tue") "��")
     ((string= s "Wed") "��")
     ((string= s "Thu") "��")
     ((string= s "Fri") "��")
     ((string= s "Sat") "��")
     ((string= s "Sun") "��")
     (t "??"))))
  
(setq mew-scan-form
      '(type (5 date) "(" (2 youbi) ")[" (-4 time) "] " 
	     (18 from) " " t (0 subj)))

;(setq mew-scan-form
;      '(type (4 year) " " (5 date) " " (5 time) " " (14 from) " " t (0 subj))
;      )

;;Emacs�Υǥ����ץ쥤������
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


;;��������С��򱦤�
;;(set-scroll-bar-mode 'right)
(scroll-bar-mode nil)
;;(toggle-scroll-bar nil)
;;�����ɽ��
(setq display-time-day-and-date t)

;;���ֹ� on
(line-number-mode t)

;;���ֹ� on
(column-number-mode t)

;;Tool bar Icon ���
(tool-bar-mode nil) 

;;Menu bar Icon ���
(menu-bar-mode nil)

;;���޻��Ѵ���§����
;;ɬ�פ���ʬ�򥳥��ȥ����Ȥ��뤳�Ȥ�ͭ����
(defun my-customize-romaji-tamago4-hira ()
		(interactive)
		(define-its-state-machine-append
		  its-hira-map
		  (its-defrule "la" "��" nil t)
		  (its-defrule "li" "��" nil t)
		  (its-defrule "lu" "��" nil t)
		  (its-defrule "le" "��" nil t)
		  (its-defrule "lo" "��" nil t)
		  (its-defrule "ltu" "��" nil t)
		  (its-defrule "lya" "��" nil t)
		  (its-defrule "lyu" "��" nil t)
		  (its-defrule "lyo" "��" nil t)
		  (its-defrule "dhi" "�Ǥ�" nil t)
		  (its-defrule "dhu" "�Ǥ�" nil t)
		  )
		)
(eval-after-load "its/hira" '(my-customize-romaji-tamago4-hira))

;;  Lookup ������

(autoload 'lookup "lookup" nil t)
(autoload 'lookup-region "lookup" nil t)
(autoload 'lookup-pattern "lookup" nil t)

(define-key ctl-x-map "l" 'lookup)              ;C-x l -lookup
(define-key ctl-x-map "y" 'lookup-region)       ;C-x y -lookup-region
(define-key ctl-x-map "\C-y" 'lookup-pattern)   ;C-x C-y -lookup-pattern

(setq lookup-search-agents '((ndtp "oki" :port 2010)))

;; conf�ե�������Խ��������ĥ⡼��
; DSP,conffile������
;;; load-path ������
(setq load-path
      (append
       (list
	(expand-file-name "~/.emacs.d")
	) ; list end
       load-path))

;;;  conf* --> asm mode (04.07.12)
(setq auto-mode-alist (append (list (cons "[/]conf.*$" 'asm-mode)) ;������[/]���㤤�����
                              auto-mode-alist))

(add-hook 'asm-mode-hook ; asm �⡼�ɿ����դ���
	  '(lambda () (require 'asm-hilit)))

;;(add-hook 'auto-complete-mode-hook ; asm �⡼�ɿ����դ���
;;	  '(lambda () (require 'auto-complete-mode)))

;;----------------------------------
;; 2005.12.09 itagaki��Mew����ʸ��������ˡ��ߤĤ���
;; /homes/avsf/bin/README�� mg �ΤȤ���򸫤补�ʲ��ϡ�����˴ؤ����ɲ�
      ;; C-u? �ǻ��Ѥ��륳�ޥ�ɤ����
      (setq mew-prog-grep "mg")
      (setq mew-prog-grep-opts '("--euc" "-j" "jis" "-l" "-e" "-x" "&mime"))
      ;; C-u/ �ǻ��Ѥ��륳�ޥ�ɤ����
      (setq mew-prog-vgrep mew-prog-grep)
      (setq mew-prog-vgrep-opts mew-prog-grep-opts)
;;----------------------------------
;;2006.07.04���ĳ��Υᥤ���ꡥ
;;psvn�ǥ��򸫤�Ȥ������κǽ��1�Ԥο��������������ʤ뤳�Ȥ�itagaki��
;;������Emacs�ǵ����äƤ��ޤ������⤷���������ʤäƤ������ϡ�
;;�Ȥꤢ����(require 'psvn)��������ˡ��ʲ��ε��Ҥ�ä���ФȤꤢ������褷�ޤ���
;;���޽���Ū�ʤΤǤʤ�Ȥ�����Ǥ������Ȥꤢ�����Ȥ������Ȥǡ� 
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
;; 2006.4.11 tom��Subversion�Ҳ��ع֤�ľ���tom����, 
;; ���Τ���4/11��waka-s�Υᥤ�롥psvn�򥪥�
(require 'psvn)
;; psvn�⡼�ɤؤΥ��硼�ȥ��åȤ����ꡥ
(global-set-key "\M-m" 'svn-status)  ;;M-s = svn-status 
;; text�⡼�ɻ���pcl-svn�⡼���ѥեå�
(add-hook 'text-mode-hook
          '(lambda ()
             (local-set-key "\M-m" 'svn-status)
             )
          )
;;----------------------------------
;; ���ܸ�������ˤ⡤¨�¤�quit�Ǥ��롥
;; 2006/10/28 tom�������Ƥ���롥
 (add-hook 'egg-mode-hook
	  (lambda () (define-key its-mode-map "\C-g" 
		       (lambda ()
			 (interactive)
			 (its-cancel-input)
			 (keyboard-quit)))))

;; by tom �Ȥ������ʤä��饳���ȥ����Ȥ��Ƥ�

;; �Хå����åץե��������ʤ�
(setq backup-inhibited t) ;; *~
(setq auto-save-default nil) ;; #*

;; �����ե������ɽ��
;;(auto-image-file-mode)

;;Shift��������ǥ�����ɥ��ְ�ư��
;;(windmove-default-keybindings)

;;C-x C-b��buffer-menu��	
(global-set-key "\C-x\C-b" 'buffer-menu)

;;C-x b��buffers�����ֻ�����
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

;; ������ץ���¸����chmod
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

;; ������⡼���Ѥ����ܸ������ + C-p C-n �ǥҥ��ȥ�
;;(add-hook 'shell-mode-hook
;;          (function
;;           (lambda ()
;;             (set-buffer-process-coding-system 'euc-jp 'euc-jp)
;;	     (local-set-key "\C-p" 'comint-previous-input)	     
;;	     (local-set-key "\C-n" 'comint-next-input)	     
;;	     )
;;	   )
;;)

;; itagaki �������ꤷ��̩�ε���
;; Emacs���svn�β����򸫤�
(require 'svn-update-log)
(global-set-key "\M-u" 'svn-update-log)
(global-set-key "\M-n" 'svn-view-log-this-file)

;; enlarge-window-10
;;                  by itagaki

(defun enlarge-window-10 ()
  "enlarge-window��Ȥäƥ�����ɥ��򹭤���"
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
;; ���å�����ͭ���ˤ���
(setq w3m-use-cookies t)


;; itagaki ���� ��ʸ����������ȡ���
;; M-+ �ǵ�ư������
;; word-count-mode
(autoload 'word-count-mode "word-count"
	  "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;; M-q���ޤ��֤�ʸ����
(setq default-fill-column 80)	; (�ǥե������ : 70)
;;(setq fill-column 80)

;; ������ɥ��ΰ�ư����
(global-set-key "\M-h" 'windmove-left)
(global-set-key "\M-j" 'windmove-down)
(global-set-key "\M-k" 'windmove-up)
(global-set-key "\M-l" 'windmove-right)

;; Latex �ǥ����ȥ����� C-c C-c
(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map "\C-c\C-c" 'comment-region)))

;;;; ================================================================================
;; �ǥåɥ饤�� �ҥ�åۡ�����������
(require 'display-deadline)
(display-deadline "������ݡ��ȡ��ڡ�����%d��%h����%mʬ" (encode-time 00 00 21 6 6 2008))

;;;; ================================================================================
;; �᥸�㡼�⡼�ɤ��ɲá�

(require 'masm-mode)	; masm-mode��(DSP56300���Խ�����᥸�㡼�⡼�ɡ�)
(require 'mconf-mode)	; mconf-mode��(conf�ե�������Խ�����᥸�㡼�⡼�ɡ�)
(require 'cook-mode)	; cook-mode���ʤ��Ƥ⤤����������Ƥ�������
(setq auto-mode-alist (append '(("\\.asm$"	   . masm-mode))
			      '((".*/dsp/.*/conf.*$" . mconf-mode))
			      auto-mode-alist))

;;;; ================================================================================
;; �פäײ����Ĥ餵�ʤ�����ν���

(setq visible-bell t)

;;;; ================================================================================
;; ��ư���˺Ƕᳫ�����ե����������ɽ����
(recentf-mode t)	; recentf-mode��ON��
;; recentf-open-files��¹Ԥ����Ȥ��ˡ�������֤�2�Բ����롥
(defadvice recentf-open-files (after hl-line-recentf-open-files activate)
  (switch-to-buffer "*Open Recent*")
  (hl-line-mode)
  (forward-line 2))
(recentf-open-files)	; ������̤�recentf�ˤ��롥
(define-key ctl-x-map "\C-r" 'recentf-open-files)
(setq recentf-max-saved-items 2000)


;; �ܤ������뤰�롥by itagaki 2008.01.25
;(require 'twiddle)
;(setq twiddle-rotate-chars '(?- ?�� ?�� ?�� ?�� ?�� ?��))
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
(setq yahtml-www-browser "sese-firefox");; yatex �� html �⡼�ɤǵ�ư����ӥ塼��

;; ���顼����ץ����̾��ɽ��
(autoload 'list-hexadecimal-colors-display "color-selection"
  "Display hexadecimal color codes, and show what they look like." t)

;; ������emacs��ɽ��
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

;; �ե졼���������ӥե졼�����Υ����Х���ɤ��ɲ�
(global-set-key "\C-xj" 'make-frame-command)
(global-set-key "\C-xh" 'delete-frame)
(global-set-key "\C-t" 'enlarge-window)

;; ��¦��ɽ����ưŪ���ޤ��֤�            by sugimoto 2008.05.11
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
  "enlarge-window��Ȥäƥ�����ɥ��򹭤���"
  (interactive)
  (while (> (- (screen-height) (window-height)) 10)
    (enlarge-window 1)))

(global-set-key "\C-x/" 'enlarge-window-10)

;; �����Х����̵��
(global-set-key "\C-x\C-t" 'undefined)
(global-set-key "\C-x\C-z" 'undefined)

;; ��ư���˺Ƕᳫ�����ե����������ɽ����
(recentf-mode t)	; recentf-mode��ON��

;; recentf-open-files��¹Ԥ����Ȥ��ˡ�������֤�2�Բ����롥
(defadvice recentf-open-files (after hl-line-recentf-open-files activate)
  (switch-to-buffer "*Open Recent*")
  (hl-line-mode)
  (forward-line 2))
(recentf-open-files)	; ������̤�recentf�ˤ��롥
(define-key ctl-x-map "\C-r" 'recentf-open-files)
(setq recentf-max-saved-items 2000)

;; reftex-mode �μ�ư��ư
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
;; ��ư��gtags-mode�˰ܹ�
(add-hook 'c-mode-common-hook
          #'(lambda()
             (gtags-mode 1)
             (gtags-make-complete-list)
             ))

;; printf �� fprintf �� �ƥ�ץ����
(defun ty_printf ()
  (interactive)
  (insert "printf(\"\\n\")\;"))
(global-set-key "\C-cp" 'ty_printf)

(defun ty_fprintf ()
  (interactive)
  (insert "fprintf(stderr, \"\\n\")\;"))
(global-set-key "\C-cf" 'ty_fprintf)

;; ��ĥ�Ҥ˱����ƥƥ�ץ졼�Ȥ�����
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

;; compile �� M-c �˥Х����
(setq compile-command "gmake install")
(global-set-key "\M-c" 'compile)

;; ����������ǤϤʤ�Ⱦ���������
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

;------------����ʬ��ε���  �Ϥ���
;;http://www.bookshelf.jp/soft/meadow_30.html#SEC404
;; �����Х���ɤ���¸
;;�ǥե���Ȥϡ�C-c C-w
;; �ѹ����ʤ����ϰʲ��Σ��Ԥ������롥
;;(setq win:switch-prefix "\C-z")
;;(define-key global-map win:switch-prefix nil)
;;(define-key global-map "\C-z1" 'win-switch-to-window)
(require 'windows)
;; �����˥ե졼�����ʤ�
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)
(global-set-key "\M-r" 'win-resume-menu)
;------------����ʬ��ε���  �����

;; wnn+egg���������
;; �Ѵ������ɽ������ޤǤβ������ꤹ������
(setq egg-conversion-auto-candidate-menu 1)
;; ����ե��٥åȤ����ϳ���
(setq menudiag-select-without-return t)
;; ��Ƭ�����
(setq egg-conversion-wrap-select t)

;; ����åץܡ��ɤ˴ؤ�������
(global-set-key "\M-w" 'clipboard-kill-ring-save)  ; ����åץܡ��ɤ˥��ԡ�
(global-set-key "\C-w" 'clipboard-kill-region)     ; �ڤ��äƥ���åץܡ��ɤ�

;; ����ѥ���˴ؤ�������
(setq compilation-window-height 10) ;�Կ������� by kfuru

;; �ʲ��� navi2ch �˴ؤ�������
;; ɬ��������
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
;; ��λ����ˬ�ͤʤ�
(setq navi2ch-ask-when-exit nil)
;; ����Υǥե����̾��Ȥ�
(setq navi2ch-message-user-name "")
;; ���ܡ��󤬤��ä��������Υե��������¸���ʤ�
(setq navi2ch-net-save-old-file-when-aborn nil)
;; ��������ˬ�ͤʤ�
(setq navi2ch-message-ask-before-send nil)
;; kill ����Ȥ���ˬ�ͤʤ�
(setq navi2ch-message-ask-before-kill nil)
;; �Хåե��� 5 �Ĥޤ�
(setq navi2ch-article-max-buffers 5)
;; navi2ch-article-max-buffers ��Ķ������Ť��Хåե��Ͼä�
(setq navi2ch-article-auto-expunge t)
;; Board �⡼�ɤΥ쥹����˥쥹�����ÿ���ɽ�����롣
(setq navi2ch-board-insert-subject-with-diff t)
;; Board �⡼�ɤΥ쥹����˥쥹��̤�ɿ���ɽ�����롣
(setq navi2ch-board-insert-subject-with-unread t)
;; ���ɥ���Ϥ��٤�ɽ��
(setq navi2ch-article-exist-message-range '(1 . 1000))
;; ̤�ɥ���⤹�٤�ɽ��
(setq navi2ch-article-new-message-range '(1000 . 1))
;; 3 �ڥ���⡼�ɤǤߤ�
;;(setq navi2ch-list-stay-list-window t)
;; C-c 2 �ǵ�ư
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

;; C-b �ǲ���˥Хåե�������
(iswitchb-mode 1)
(add-hook 'iswitchb-define-mode-map-hook
          'iswitchb-my-keys)

(defun iswitchb-my-keys ()
  "Add my keybindings for iswitchb."
  (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
  (define-key iswitchb-mode-map " " 'iswitchb-next-match)
  (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
  )


;; �ݥåץ��åפ���֤���
(require 'auto-complete)
;; M-/ ����ֳ��Ϥˤ���
(global-auto-complete-mode t)
;;(global-set-key "\M-/" 'ac-start)

;; �����񤯤ȡ�ʣ���ΥХåե������Ƥ���֤Ǥ���褦�ˤʤ롩��
(setq-default ac-sources '(ac-source-abbrev ac-source-words-in-all-buffer))

;; ��ֳ���ʸ�����λ���
(setq ac-auto-start 2)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; Maybe default-enable-multibyte-characters is t by default
;; (setq default-enable-multibyte-characters t) ;; ���å�

;; kill ring ���Ψ�褯�Ȥ�����
(require 'browse-kill-ring)
(global-set-key "\M-y" 'browse-kill-ring)

;; kill-ring ���Ԥ�ɽ��
(setq browse-kill-ring-display-style 'one-line)
;; browse-kill-ring ��λ���˥Хåե��� kill ����
(setq browse-kill-ring-quit-action 'kill-and-delete-window)
;; ɬ�פ˱����� browse-kill-ring �Υ�����ɥ����礭�����ѹ�����
(setq browse-kill-ring-resize-window t)
;; kill-ring �����Ƥ�ɽ������ݤζ��ڤ����ꤹ��
(setq browse-kill-ring-separator "-------")
;; ����������� kill-ring �Υϥ��饤�Ȥ���
(setq browse-kill-ring-highlight-current-entry t)
;; ���ڤ�ʸ���Υե���������ꤹ��
(setq browse-kill-ring-separator-face 'region)
;; ������ɽ������ʸ��������ꤹ�롥 nil �ʤ餹�٤�ɽ������롥
(setq browse-kill-ring-maximum-display-length 100)

;;; GDB ��Ϣ
;;; ͭ�ѤʥХåե��򳫤��⡼��
(setq gdb-many-windows t)

;;; �ѿ��ξ�˥ޥ�������������֤����ͤ�ɽ��
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

; ��ư���Υ�å�������ɽ��
(setq inhibit-startup-message t)



;; === howm ������ basic ===
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
(mapc
 (lambda (f)
   (autoload f
     "howm" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))

;; === howm ������ custermize ===
;; ��󥯤� TAB ��é��
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; �ֺǶ�Υ��װ������˥����ȥ�ɽ��
(setq howm-list-recent-title t)
;; �����������˥����ȥ�ɽ��
(setq howm-list-all-title t)
;; ��˥塼�� 2 ���֥���å���
(setq howm-menu-expiry-hours 2)

;; howm �λ��� auto-fill ��
(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET �ǥե�����򳫤���, �����Хåե���ä�
;; C-u RET �ʤ�Ĥ�
(setq howm-view-summary-persistent nil)

;; ��˥塼��ͽ��ɽ��ɽ���ϰ�
;; 10 ��������
(setq howm-menu-schedule-days-before 10)
;; 3 ����ޤ�
(setq howm-menu-schedule-days 3)

;; howm �Υե�����̾
;; �ʲ��Υ�������Τ����ɤ줫������Ǥ�������
;; �ǡ����פʹԤϺ�����Ƥ�������
;; 1 ��� 1 �ե����� (�ǥե����)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 �� 1 �ե�����Ǥ����
(setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")

(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; �������ʤ��ե����������ɽ��
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; ���������ä��Τ����ݤʤΤ�
;; ���Ƥ� 0 �ʤ�ե����뤴�Ⱥ������
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
;; C-cC-c ����¸���ƥХåե��򥭥뤹��
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

;; ��˥塼��ư�������ʤ�
(setq howm-menu-refresh-after-save nil)
;; ���������ľ���ʤ�
(setq howm-refresh-after-save nil)

(require 'git-emacs)
