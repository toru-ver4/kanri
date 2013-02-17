xhost +
unset LC_ALL
export LANG="ja_JP.eucJP"
export LC_CTYPE="ja_JP.eucJP"
#export XMODIFIERS="@im=kinput2"
#export GTK_IM_MODULE="xim"
kinput2&
export XMODIFIERS="@im=SCIM"
export GTK_IM_MODULE="scim"
scim -d &
xrdb $HOME/.Xresources
(sleep 10; xrefresh ) &
xset fp+ /homes/kanri/mathfont6.0/Fonts/AFM
xset fp+ /homes/kanri/mathfont6.0/Fonts/BDF
xset fp+ /homes/kanri/mathfont6.0/Fonts/Type1
xset fp+ /homes/kanri/mathfont5.2/Fonts/AFM
xset fp+ /homes/kanri/mathfont5.2/Fonts/BDF
xset fp+ /homes/kanri/mathfont5.2/Fonts/Type1
#xset fp+ /homes/kanri/mathfont6.0/Fonts/TTF
xset fp rehash
# キーの反応速度を超高速化
xset r rate 250 75
# ビープ音をチェンジ
#xset b 5 500 500
#raw2sp ~/Ahhhhhh/vista.raw &
#sox ~/Ahhhhhh/winxp.wav -t ossdsp /dev/dsp
# 壁紙を設定．ちなみにwallpaperはシンボリックリンクである．
bsetbg -c $HOME/wallpaper
/usr/local/bin/xmodmap ~/.Xmodmap
exec fvwm2
#/mnt/hiya/home/yosihara/Ohhhhh/bin/fvwm

#compiz --replace --sm-disable --ignore-desktop-hints ccp &                     
#emerald --replace 
#exec jwm
#exec startxfce4
#exec afterstep
#exec fvwm95
#exec starte16
#exec twm
