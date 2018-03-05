#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
# 概要
エンコードします。

# 準備
srcフォルダに動画をぶち込んでおく。

# 使い方
$ python encode.py

"""

import os


def get_in_file_filepath_in_directory(dir="src"):
    full_name_list = [os.path.join(dir, name) for name in os.listdir(dir)]

    return full_name_list


def get_out_file_filepath_in_directory(src="src", dst="dst"):
    name_list = []
    for name in os.listdir(src):
        name_ext = os.path.splitext(name)[0] + ".mp4"
        name_list.append(os.path.join(dst, name_ext))

    return name_list


def endode(src="src", dst="dst"):
    in_name_list = get_in_file_filepath_in_directory(dir=src)
    out_name_list = get_out_file_filepath_in_directory(src="src", dst="dst")
    for in_name, out_name in zip(in_name_list, out_name_list):
        base_str = 'ffmpeg -i "{}" -c:v libx264 -crf 19 -c:a libmp3lame -ab 192k "{}"'
        # print(base_str.format(in_name, out_name))
        os.system(base_str.format(in_name, out_name))


if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    # get_in_file_filepath_in_directory()
    # get_out_file_filepath_in_directory()
    endode()
