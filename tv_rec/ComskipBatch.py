#!/usr/bin/env python3
#-*- coding: utf-8 -*-
 
"""
Matplotlib で xy色度図を書くぜ！
"""

import os
import sys
import time
import math
import subprocess
import struct
import re
import shutil
COMSKIP_EXE = "comskip.exe"
COMSKIP_INI = "comskip.ini"
FFMPEG_EXE = "ffmpeg.exe"

const_check_error_bit_mask = 0x80000000
const_re_duration_pattern = re.compile(r"Duration:.(.*?),")


def hms_str_to_sec_ms(time_str):
    """ convret 01:02:03.45 to 3723.45 """
    time_str_array = time_str.split(".")
    if len(time_str_array) != 2:
        "error! time_str format error\n"
        sys.exit(1)

    hms_str = time_str.split(".")[0]
    ms_str = time_str.split(".")[1]
    hms_str_array = hms_str.split(":")
    
    sec_ms = int(hms_str_array[0]) * 3600 + int(hms_str_array[1]) * 60 + int(hms_str_array[2])
    sec_ms = sec_ms + int(ms_str) / 100.

    return sec_ms


def sec_ms_to_hms_str(sec_ms):
    """ convert 3723.45 to 01:02:03.45 """
    h_str = "%02d" % (sec_ms // 3600)
    m_str = "%02d" % ((sec_ms % 3600) // 60)
    s_str = "%02d" % (sec_ms % 60)
    ms_str = str(int(round((sec_ms - int(sec_ms)) * 100, 0)))

    hms_str = h_str + ":" + m_str + ":" + s_str + "." + ms_str

    return hms_str


def remove_temp_files():
    for file_name in temp_file_list:
        try:
            os.remove(file_name)
        except OSError as e:
            print("error! {:s} is not removed.".format(e.filename))


def error_process(err_no=0):
    
    shutil.move(ts_file_name, ng_dir_path)

    remove_temp_files()
    
    if err_no >= 100:
        pass
    if err_no >= 200:
        pass
    if err_no >= 300:
        pass
    if err_no >= 400:
        pass
    if err_no >= 500:
        pass
    if err_no >= 600:
        pass
    if err_no >= 700:
        pass
    if err_no >= 800:
        pass

    sys.exit(1)


if __name__ == '__main__':
    
    # check arguments
    if len(sys.argv) == 1:
        print("error! please type filename\n")
        sys.exit(1)

    ts_file_name = sys.argv[1]

    # check file existence
    if os.path.exists(ts_file_name) == False:
        print("error! {:s} is not found.".format(ts_file_name))
        sys.exit(1)
    
    ts_file_basename, ext = os.path.splitext(ts_file_name)
    ts_file_path = os.path.dirname(ts_file_name)
    mp4_file_path = ts_file_basename + ".mp4"
    vdr_file_path = ts_file_basename + ".vdr"
    script_path = os.path.dirname(__file__)
    comskip_path = os.path.join(script_path, os.path.join("comskip",COMSKIP_EXE))
    comskip_ini_file_path = os.path.join(script_path, os.path.join("comskip",COMSKIP_INI))
    ffmpeg_path = os.path.join(script_path, os.path.join('ffmpeg', os.path.join('bin', FFMPEG_EXE)))
    ok_dir_path = os.path.join(script_path, "../cm_cut_ok")
    ng_dir_path = os.path.join(script_path, "../cm_cut_ng")
    temp_file_list = [ts_file_basename + "ts.err", ts_file_basename + ".ts.program.txt"]

    # コンテンツ時間の確認
    command_list = ffmpeg_path + " -i " + ts_file_name
    p = subprocess.Popen(command_list.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    outs, errs = p.communicate()
    errs_str = str(errs)
    re_obj = const_re_duration_pattern.search(errs_str)
    if re_obj:
        end_time = re_obj.group(1)
    else:
        print("error! input file format is invalid")
        error_process(100)

    # cm区間情報の抽出
    command_list = comskip_path + " " + "-t -d 255 -v 1 --ini=" + comskip_ini_file_path \
                   + " " + ts_file_name
    print(command_list)
    ret = subprocess.call(command_list.split(" "))
    temp_file_list.append(ts_file_basename + ".log")
    temp_file_list.append(ts_file_basename + ".txt")
    temp_file_list.append(vdr_file_path)

    # エラーの場合は戻り値が負なので、32bitの最上位bitが立っているかチェック
    if ret & const_check_error_bit_mask == 0x00000000:
        print("{:s} is succeeded.".format(COMSKIP_EXE))
    else:
        print("error! {:s} is failed.".format(COMSKIP_EXE))
        error_process(200)

    # get vrd file.
    try:
        with open(vdr_file_path, "r") as vdr_file:
            vdr_param = []
            for line in vdr_file.readlines():
                vdr_param.append(line.split(" ")[0])
    except OSError as e:
        print("error! {:s} is not found".format(e.filename))
        error_process(300)


    # check vrd file format
    if len(vdr_param) % 2 != 0:
        print("error! vdr file is invalid")
        error_process(400)
    
    print(vdr_param)

    # vdrファイルから本編区間の時間情報を抽出
    contents_time_pare_list = []
    # 以下の if文 はコンテンツ冒頭がCMから開始しない場合の特別処理
    if hms_str_to_sec_ms(vdr_param[0]) > 0:
        contents_time_pare_list.append(("0:00:00.00", vdr_param[0]))
    # vdrファイルを上から順に処理して本編区間情報を list に追加
    for roop_idx in range((len(vdr_param) // 2) - 1):
        st_time = hms_str_to_sec_ms(vdr_param[roop_idx*2 + 1])
        diff_time = hms_str_to_sec_ms(vdr_param[roop_idx*2 + 2]) - st_time
        contents_time_pare_list.append((vdr_param[roop_idx*2 + 1], sec_ms_to_hms_str(diff_time)))
    # 以下の if文 はコンテンツ末尾がCMで終わっていない場合の特別処理
    if hms_str_to_sec_ms(vdr_param[-1]) < hms_str_to_sec_ms(end_time):
        st_time = hms_str_to_sec_ms(vdr_param[-1])
        diff_time = hms_str_to_sec_ms(end_time) - st_time
        contents_time_pare_list.append((vdr_param[-1], sec_ms_to_hms_str(diff_time)))

    # CMカットの結果、本編のサイズが24分を割り込まないか調査
    min_contents_len = hms_str_to_sec_ms(end_time) * 0.79
    contents_len = 0
    for c_time in contents_time_pare_list:
        contents_len += hms_str_to_sec_ms(c_time[1])
    if contents_len < min_contents_len:
        print("error! CM is too long.")
        error_process(450)

    # vdrファイルの分析結果をもとに、コンテンツ本編のみを抜き出す。
    print(contents_time_pare_list)
    cut_file_list = []
    for idx, time_pare in enumerate(contents_time_pare_list):
        cut_file_name = "tmp_" + os.path.splitext(os.path.basename(ts_file_name))[0] \
                        + "_" + str(idx) + ".ts"
        cut_file_list.append(cut_file_name)
        temp_file_list.append(cut_file_name)
        st_time = time_pare[0]
        length_time = time_pare[1]
        command_list = ffmpeg_path + " -y -i " + ts_file_name + " -c copy -ss " \
                       + st_time + " -t " + length_time + " -sn " + cut_file_name
        print(command_list)

        try:
            subprocess.check_output(command_list.split(" "))
        except subprocess.CalledProcessError as e:
            print('error! "{:s}" is failed. ret = {}'.format(" ".join(e.cmd), e.returncode))
            error_process(500)

    # コンテンツ本編のみのファイルを結合する
    cm_cut_ts_file_name = os.path.splitext(os.path.basename(ts_file_name))[0] + "_cm_cut.mp4"
    temp_file_list.append(cm_cut_ts_file_name)
    command_list = ffmpeg_path + ' -y -i concat:' + "|".join(cut_file_list) + ' ' \
                   + "-c copy -bsf:a aac_adtstoasc " + cm_cut_ts_file_name
    print(command_list)

    try:
        subprocess.check_output(command_list.split(" "))
    except subprocess.CalledProcessError as e:
        print('error! "{:s}" is failed. ret = {}'.format(" ".join(e.cmd), e.returncode))
        error_process(600)

    # コンテンツをエンコード
    command_list = ffmpeg_path + ' -y -i ' + cm_cut_ts_file_name + \
                   " -f mp4 -c:v libx264 -preset veryslow -crf 24" + \
                   " -vf dejudder,fps=30000/1001,fieldmatch=mode=pcn_ub:combmatch=full,yadif,decimate,hqdn3d,unsharp=la=0.4" + \
                   " -tune animation -r 24000/1001 -s 1920x1080 -ac 2 -c:a ac3 -b:a 128k " + \
                   mp4_file_path
    try:
        subprocess.check_output(command_list.split(" "))
    except subprocess.CalledProcessError as e:
        print('error! "{:s}" is failed. ret = {}'.format(" ".join(e.cmd), e.returncode))
        error_process(700)


    # mp4ファイルをOKフォルダに移動
    try:
        shutil.move(mp4_file_path, ok_dir_path)
    except OSError as e:
        print("error! failed mp4 file copy.")
        error_process(800)

    # remove temporary files
    remove_temp_files()

    print("Windowsを閉じるには何かキーを入力して下さい")
    input_word = input('>>> ')
    sys.exit(1)

    
