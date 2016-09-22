import os
import subprocess

const_src_dir = './src'
const_dst_dir = './dst'
const_enc_param = '-c:v libx264 -crf 19 -c:a ac3'


def main_func():
    in_file_name_list = os.listdir(const_src_dir)
    in_file_full_name_list = [os.path.join(const_src_dir, x)
                              for x in in_file_name_list]
    out_file_full_name_list = [os.path.join(const_dst_dir,
                               os.path.splitext(x)[0] + '.mp4')
                               for x in in_file_name_list]

    for src, dst in zip(in_file_full_name_list, out_file_full_name_list):
        cmd = 'ffmpeg -i "{}" {} "{}" -y'.format(src, const_enc_param, dst)
        print(cmd)
        subprocess.call(cmd)


if __name__ == '__main__':
    main_func()
