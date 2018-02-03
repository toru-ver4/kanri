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
        base_str = 'ffmpeg -i "{}" -c:v libx264 -crf 18 -c:a libmp3lame -ab 192k "{}"'
        # print(base_str.format(in_name, out_name))
        os.system(base_str.format(in_name, out_name))


if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    # get_in_file_filepath_in_directory()
    # get_out_file_filepath_in_directory()
    endode()

"""
01_Make it!（らぁら＆みれぃVer.）_i☆Ris
02_ま～ぶるMake up a-ha-ha！_真中らぁら＆南みれぃ
03_太陽のflare sherbet（解放乙女ヴァルキュリア未完成Ver.）_北条そふぃ
04_Pretty Prism Paradise!!!_SoLaMi♡SMILE
05_No D&D code_DressingPafé
06_太陽のflare sherbet（解放乙女ヴァルキュリア完成Ver.）_北条そふぃ
07_HAPPYぱLUCKY_SoLaMi♡SMILE
08_CHANGE! MY WORLD_DressingPafé
09_Realize!_SoLaMiDressing
10_0-week-old（ゼロウィークオールド／ファルル）
11_君100％人生_北条コスモ
12_Love friend style_SoLaMiDressing
13_Love friend style_真中らぁら
14_Make it!_SoLaMiDressing & ファルル
15_ドリームパレード_真中らぁら
16_ドリームパレード_南みれぃ
17_でび＆えん☆Reversible- Ring_アロマゲドン
18_ラッキー!サプライズ☆バースデイ_そらマゲドン・み
19_コノウタトマレイヒ_緑風ふわり
20_純・アモーレ・愛_紫京院ひびき
"""