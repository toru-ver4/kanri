# tcsh の設定ファイル



# 基本的な（？）環境変数の設定 -------------------------------------------------
set ignoreeof		# C-d でログアウトしない
set nobeep		# ビープ音を鳴らさない（ほんとか？）
set history=1000	# ヒストリに保存するコマンド数の設定
set savehist=(1000 merge) # ~/.historyに保存するコマンドを1000にする(マージする)

set color	# TAB補完時にカラー表示
# ls -G でのカラー設定
setenv LSCOLORS "GxDxFxBxCxegedabagacad"	
# TAB補完でのカラー設定
setenv LS_COLORS "di=01;36:ln=01;33:so=01;32:pi=33:ex=01;32:bd=46;34:cd=43;34"

setenv DOMAINNAME it.ice.uec.ac.jp	# ドメインネーム
setenv EDITOR /usr/bin/vi		# エディタ（どこで参照されるのだろう）
setenv PAGER lv				# ページャ（jman で使用？）
setenv XMODIFIERS @im=SCIM		# imput method の設定？よくわからん
setenv GTK_IM_MODULE "xim"		# imput method の設定？よくわからん
setenv LANG ja_JP.eucJP			# EUC日本語環境を設定
setenv XDG_CACHE_HOME /var/tmp/xdg.cache-$USER # FreeDesktop アプリのキャッシュフォルダ
setenv XDVIPRINTCMD /homes/avsf/bin/xdviprint	# xdvi の print の為
setenv PRINTER fujimono				# xdvi の print の為

umask 022	# ディレクトリ作成時のパーミッションの設定．この場合は755

limit coredumpsize 0			# こあだんぷさいず
limit filesize 2048M			# ファイルサイズの制限
# ------------------------------------------------------------------------------



# PATH の設定 ------------------------------------------------------------------
setenv OHHHHH /mnt/hiya/home/yosihara/Ohhhhh	# ローカル環境へのパス

# TEX関連のパス
setenv TEXINPUTS :$HOME/lib/tex
setenv BIBINPUTS :$HOME/lib/tex
setenv BSTINPUTS :$HOME/lib/tex

# kinput2用のパス
setenv CC_DEF_PATH :$HOME/lib/wnn/ccdef

# 設定する意味あるかよくわからん
setenv C_INCLUDE_PATH /homes/yosihara/lib/c/:/homes/avsf/include:$OHHHHH/include

# あまり設定したくないのだが……
setenv LD_LIBRARY_PATH /usr/local/lib/octave:$HOME/lib:$OHHHHH/wx/2.8/lib:$OHHHHH/lib:$OHHHHH/share
setenv PKG_CONFIG_PATH $OHHHHH/lib/pkgconfig

# set pythonpath
setenv PYTHONPATH $OHHHHH/src/wxPython-src-2.8.9.1/wxPython:$OHHHHH/src/wxPython-src-2.8.9.1/wxPython/wxversion:$OHHHHH/src/wxPython-src-2.8.9.1/wxPython/demo:/homes/yosihara/da/yosihara/python:$OHHHHH/lib/python2.5/site-packages

#Set XDVI Environment (You must keep this section)
setenv XDVIFONTS :/usr/local/tex/asciitex/fonts/tfm:/usr/local/tex/asciitex/pk:/usr/local/tex/tex82/fonts/pk300:

#Set Path
set comm_path=(/usr/ucb /usr/bin \
	       /usr/local/bin/mh \
               /usr/local/bin /etc /usr/etc /bin \
	       . )
		
set my_path=(/sbin \
	    /usr/sbin \
            /homes/avsf/bin \
            /homes/yosihara/da/bin \
            $HOME/bin \
            $HOME/bin/secret \
	    $OHHHHH/bin \
	    $HOME/da/yosihara/python \
	    $HOME/da/yosihara/wxPython \
	    /usr/local/intel_cc_80/bin \
            )

set path=($comm_path  $my_path)

# 引数無しの cd での移動先を設定
set cdpath=( ~)
# ------------------------------------------------------------------------------



# 怒涛のエイリアスラッシュ！ ---------------------------------------------------
alias ls   'ls -FG'	# カラーで表示
alias lh   'ls -lh'	# ファイルサイズを表示
alias ll   'ls -AlF'	
alias lls  'ls -AlF | less'
alias lll  'ls -AlFt'
alias llls 'ls -AlFt | less'
alias nn   'emacs'
alias nnn  'emacs -nw'
alias cp   'cp -i'
alias mv   'mv -i'
alias x    'xgraph'
alias xm   'xgraph -M'
alias g    'gnuplot'
alias dl   'dsp_launcher'
alias sss  '/homes/avsf/bin/looklog.sh da dsp ffmpeg cook kanri'
alias xxx  'chmod +x'
alias ftp  'sftp'				# ftp は危険なので使わない
alias pkill "pkill -U 4702"			# kill 対象のユーザを指定
alias fback 'cp \!^{,.bak.`date +%y%m%d_%H%M`}'	# バックアップファイルを作成
alias xinit 'exec xinit'			# 乗っ取り防止
alias screen 'screen -D -RR'	# -xRR の意味がよくわからなかったのでこれを使用
alias ssp "screen -X eval split 'select 1' focus 'select 2'"

# itagaki の .cshrc から引用．これは神
alias rmtex 'rm -f *.tex~ *.aux *.ps *.pdf *.log *.lok *.bbl *.blg'

# GTKを使った tfras を使用する時に必要？
alias gog 'env LD_LIBRARY_PATH=/usr/local/lib/gcc-4.2.4'

# 以下は ~kota/.cshrc からパクって改造を加えたやつ
alias h 'history -r 30 | cut -f 3 | cat -n'	
alias d "pwd | sed 's/.amd_mnt/mnt/g' | sed 's/\/host\//\//g'" # pwd を強化
alias pss 'ps -ux'
alias ttt "top -U`whoami`"
alias moji 'nkf --guess'
alias lpr '/usr/local/bin/lpr'		# /usr/bin/lpr  を使用しないように設定
alias lpq '/usr/local/bin/lpq'		# /usr/bin/lpq  を使用しないように設定
alias lprm '/usr/local/bin/lprm'	# /usr/bin/lprm を使用しないように設定
# ------------------------------------------------------------------------------



# プロンプトの設定 -------------------------------------------------------------
set prompt="`hostname -s`% "	# root は "#"．一般ユーザは "%"
set rprompt="[%~]"		# 右側プロンプトにカレントディレクトリを表示

# hiya 以外の計算機ではプロンプトの表示を変える
set REMOTEHOST = hiya.it.ice.uec.ac.jp
if (${HOST} != ${REMOTEHOST}) then
   set prompt="%{\e[01;33m%}`hostname -s`%{\e[00;37m%}% "
endif
# ------------------------------------------------------------------------------



# 補完の設定 -------------------------------------------------------------------
set autolist		# 補完に失敗したときに残りの選択肢を表示
set complete=enhance	# 大文字・小文字を区別せずに補完

# コマンド別の補完設定．特定の拡張子のみ補完するといった細かな設定が可能
complete	rmdir		'p/1/d/'
complete	acroread	'n/*/f:*.{pdf,PDF}/'
complete	setenv		'p/1/e/'
complete	lpr		'n/*/f:*.{ps,eps}/'
complete	dvips		'n/*/f:*.dvi/'
complete	dvipdfmx	'n/*/f:*.dvi/'
complete	printenv	'p/*/e/'			
complete	tgif		'p/*/f:*.obj/'
# ------------------------------------------------------------------------------



# 便利な検索コマンド -----------------------------------------------------------
bindkey ^R i-search-back 	    # [C-r]:パターン一致するコマンドを検索
bindkey ^S i-search-fwd 	    # [C-s]:パターン一致するコマンドを検索
bindkey ^P history-search-backward  # [C-p]:打ち込んだ部分まで同一なコマンドを検索
bindkey ^N history-search-forward   # [C-n]:同上、ただし順方向検索
bindkey ^V complete-word-fwd	    # [C-v]:補完候補を順に表示
bindkey ^U complete-word-back	    # [C-u]:補完候補を逆順に表示
# ------------------------------------------------------------------------------



# マシン名を打ち込めば rlogin が実行されるように alias を設定 ------------------
set h_zoku=(haya hiya huya heya hoya)
set r_zoku=(raku riku ruku reku roku rank)
set s_zoku=(sasa sese sui)
set g_zoku=(giri)
set kanri =(zen hon nana koro biya oki momo kuri san nen)
set it_machines=(${h_zoku} ${r_zoku} ${s_zoku} ${g_zoku} ${kanri})
# kfuru の .zshrc.mine からパクった
foreach mashin (${it_machines})
    alias ${mashin} "rlogin ${mashin}"
end
alias yamu 'cocot -t EUC-JP -p UTF-8 rlogin yamu'
# ------------------------------------------------------------------------------
