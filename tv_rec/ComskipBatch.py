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
COMSKIP_EXE = "comskip.exe"
COMSKIP_INI = "comskip.ini"
FFMPEG_EXE = "ffmpeg.exe"

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

if __name__ == '__main__':
    
    if len(sys.argv) == 1:
        print("error! please type filename\n")
        sys.exit(1)
    else:
        ts_file_name = sys.argv[1]
        ts_file_basename, ext = os.path.splitext(ts_file_name)
        ts_file_path = os.path.dirname(ts_file_name)
        vdr_file_path = ts_file_basename + ".vdr"

    script_path = os.path.dirname(__file__)
    comskip_path = os.path.join(script_path, os.path.join("comskip",COMSKIP_EXE))
    comskip_ini_file_path = os.path.join(script_path, os.path.join("comskip",COMSKIP_INI))
    ffmpeg_path = os.path.join(script_path, os.path.join('ffmpeg', os.path.join('bin', FFMPEG_EXE)))
    print(comskip_path)
    command_list = comskip_path + " " + "-t -d 255 -v 1 --ini=" + comskip_ini_file_path \
                   + " " + ts_file_name
    print(command_list)
    # subprocess.call(command_list.split(" "))

    # get vrd file.
    print(vdr_file_path)
    with open(vdr_file_path, "r") as vdr_file:
        vdr_param = []
        for line in vdr_file.readlines():
            vdr_param.append(line.split(" ")[0])
            
    if len(vdr_param) % 2 != 0:
        "error! vdr file is invalid.\n"
        sys.exit(1)

    print(vdr_param)
    contents_time_pare_list = []
    for roop_idx in range((len(vdr_param) // 2) - 1):
        st_time = hms_str_to_sec_ms(vdr_param[roop_idx*2 + 1])
        diff_time = hms_str_to_sec_ms(vdr_param[roop_idx*2 + 2]) - st_time
        contents_time_pare_list.append((vdr_param[roop_idx*2 + 1], sec_ms_to_hms_str(diff_time)))

    print(contents_time_pare_list)
    cut_file_list = []
    for idx, time_pare in enumerate(contents_time_pare_list):
        cut_file_name = "tmp_" + os.path.splitext(os.path.basename(ts_file_name))[0] \
                        + "_" + str(idx) + ".ts"
        cut_file_list.append(cut_file_name)
        st_time = time_pare[0]
        length_time = time_pare[1]
        command_list = ffmpeg_path + " -y -i " + ts_file_name + " -c copy -ss " \
                       + st_time + " -t " + length_time + " -sn " + cut_file_name
        print(command_list)
        # subprocess.call(command_list.split(" "))

    command_list = ffmpeg_path + ' -i concat:' + "|".join(cut_file_list) + ' ' \
                   + "-c copy -bsf:a aac_adtstoasc " \
                   + os.path.splitext(os.path.basename(ts_file_name))[0] + "_cm_cut.mp4"
    print(command_list)
    subprocess.call(command_list.split(" "))
    

    
