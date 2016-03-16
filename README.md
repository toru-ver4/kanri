# kanri

In this repository, the following items have been managed.

* Configuration files for editor, shell, and so on.
* How to install the tool.
* How to use the tool.

## skel directory

### ./skel/dot.emacs.d
A settings for emacs (>=24.0).

### ./skel/dot.screenrc
A settings for Gnu Screen.

### ./skel/dot.zshrc
A settings for zsh.

## script directory
### Linux Environment(Debian)
```bash:
$ sudo ./script/install.sh         # install softwares and make the initial setting of git.
$ sudo ./script/mkLinuxSymLink.sh  # make symbolic links.
```

### Windows Enviromnent
```bat:
> windows_init.bat
> cinst chocolatey.config -y
> python -m pip install -U pip  # see https://pip.pypa.io/en/latest/installing/
> pip install pyflakes pep8
> pip install matplotlib ... and what you need
```

## Markdown to PDF
### Windows Environment
Install markdown-pdf.

```bat:
> npm install -g markdown-pdf
```

Get the "Github.css" from the chrome extension named "Markdown Preview Plus". 
Search the "Github.css" in %APPDATA% directory.

How to Transform.
```bat:
> markdown-pdf -s Github.css input.md
> pandoc input.md -s --self-contained -c Github.css -o out.html
```

## Jupyter

### Install

```bat:
> pip install jupyter
``` 

### Initial Settings

make the config file.

```bat:
> jupyter notebook --generate-config
```

edit the config file($HOME/.jupyter/jupyter_notebook_config.py).<br>
change **c.FileContentsManager.root_dir** parameters.

```python:jupyter_notebook_config.py
c.FileContentsManager.root_dir = 'C:\home'
```

### convert from the jupyter file to the pdf.

0. install LuaTeX see [THIS PAGE](https://texwiki.texjp.org/?TeX%20Live).
1. first, save as .md file using Jupyter UI.
2. second, convert from .md to .pdf using pandoc. Commands to be used are as follows.

```bat:
pandoc test.md --latex-engine=lualatex -o test.pdf
```
