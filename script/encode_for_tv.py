import os
import subprocess
import time

"""
# 概要
Chromecast用に動画データをコンバートする

# 使い方
1. src, dst フォルダを作る
2. src フォルダに変換したい動画を入れる
3. 本スクリプトを実行(引数不要)

# 注意事項
srcフォルダにあるファイルは問答無用で変換するので、
動画ファイル以外があるとエラーになると思う。
  ⇒ってか、そのくらいチェックする機構を作れよという…
"""

const_src_dir = './src'
const_dst_dir = './dst'
const_enc_param = '-c:v libx264 -crf 19 -c:a ac3'
# const_enc_param = '-c:v h264_qsv -c:a ac3'


def main_func():
    in_file_name_list = os.listdir(const_src_dir)
    in_file_full_name_list = [os.path.join(const_src_dir, x)
                              for x in in_file_name_list]
    out_file_full_name_list = [os.path.join(const_dst_dir,
                               os.path.splitext(x)[0] + '.mp4')
                               for x in in_file_name_list]

    for src, dst in zip(in_file_full_name_list, out_file_full_name_list):
        cmd = 'ffmpeg.exe -i "{}" {} "{}" -y'.format(src, const_enc_param, dst)
        print(cmd)
        t0 = time.clock()
        subprocess.call(cmd)
        t1 = time.clock()
        print("dt="+str(t1-t0)+"[s]")


if __name__ == '__main__':
    main_func()
