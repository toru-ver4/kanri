#!/usr/bin/env python3
#-*- coding: utf-8 -*-
 
"""
Name : 
Function : 
Remarks : 
"""

import os
import sys
import time
import tempfile
import subprocess
import cv2
import re

# const_movie_list = ['fantomu.ts_24_vfast_la_0.0.mp4', 
#                     'fantomu.ts_24_vfast_la_0.3.mp4', 
#                     'fantomu.ts_24_vfast_la_0.5.mp4', 
#                     'fantomu.ts_24_vfast_la_0.7.mp4',
#                     'fantomu.ts_24_vfast_org.mp4']
const_movie_list = ['tmp_precure_03_0.ts_24_vfast_la_0.0.mp4',
                    'tmp_precure_03_0.ts_24_vfast_la_0.3.mp4',
                    'tmp_precure_03_0.ts_24_vfast_la_0.5.mp4',
                    'tmp_precure_03_0.ts_24_vfast_la_0.7.mp4',
                    'tmp_precure_03_0.ts_24_vfast_org.mp4'
                    ]
const_capture_start_time = 70
const_capture_x_start = 500
const_capture_x_end = 1400
const_capture_y_start = 540
const_capture_y_end = 930
re_param_str = re.compile(".*_(.*?).mp4")


FFMPEG_EXE = "ffmpeg.exe"

if __name__ == '__main__':
    script_path = os.path.dirname(__file__)
    ffmpeg_path = os.path.join(script_path, os.path.join('ffmpeg', os.path.join('bin', FFMPEG_EXE)))
    temp_path = tempfile.mkdtemp()

    img_list = []
    for img_idx, movie_name in enumerate(const_movie_list):
        input_name = movie_name
        out_name = os.path.splitext(os.path.basename(movie_name))[0] + ".png"
        command = ffmpeg_path + " -y -i " + input_name + " -ss " \
                  + str(const_capture_start_time) + " -t 1 -r 1 -f image2 " + out_name
        print(command)
        # subprocess.call(command.split(" "))
        img = cv2.imread(out_name)[const_capture_y_start:const_capture_y_end, const_capture_x_start:const_capture_x_end]
        strength = re_param_str.search(movie_name)
        if strength:
            strength_str = str(strength.group(1))
        cv2.putText(img, "la=" + strength_str, (20, 200), cv2.FONT_HERSHEY_SIMPLEX, 1.0, (0, 255, 255), 2)
        img_list.append(img.copy())

    img_h1 = cv2.hconcat([img_list[0], img_list[1]])
    img_h2 = cv2.hconcat([img_list[2], img_list[3]])
    img_h3 = cv2.hconcat([img_list[4], img_list[4]])
    img_all = cv2.vconcat([img_h1, img_h2])
    img_all = cv2.vconcat([img_all, img_h3])
    cv2.imshow('check', img_all)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

    print(temp_path)
    os.removedirs(temp_path)
