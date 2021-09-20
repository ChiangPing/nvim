# install_ubuntu

## Windows10 安装问题

1.安装时没有了mbr，怎么办？
便捷式启动：mbr安装hdd++

2.安装时不支持gpt
```shell
shift+f10
diskpart
list disk
select disk number
clean
convert mbr
convert gpt
exit
```
## Ubuntu 安装的问题
### 中文字体安装

```shell
sudo mkdir /usr/share/fonts/winfonts
sudo cp /media/kdl/WINDOWS/Windows/Fonts/*.ttf /usr/share/fonts/winfonts
sudo cp /media/kdl/WINDOWS/Windows/Fonts/*.ttc /usr/share/fonts/winfonts
sudo cp /media/kdl/WINDOWS/Windows/Fonts/*.TTF /usr/share/fonts/winfonts

cd /usr/share/fonts/winfonts
sudo chmod -R 755 *
sudo mkfontscale #找不到命令的话需apt install xfonts-utils
sudo mkfontdir
sudo fc-cache -fv

#显示安装字体的命令 去掉：lang及其后边的内容则就是显示所有字体
fc-list :lang=zh
```

==注意==

发现还是缺少自己win上装的字体，原来在其它目录里也有字体：

win10系统字体
`/media/kdl/WINDOWS/Windows/Fonts/`
用户自定义字体
`/media/{ubuntu用户名}/WINDOWS/Users/{win用户名}/AppData/Local/Microsoft/Windows/Fonts/`

office字体(好像ubuntu用不了)
`/media/{ubuntu用户名}/WINDOWS/Program Files (x86)/Microsoft Office/root/VFS/Fonts/private`

### 中文文字显示半个

# [🔨Ubuntu Linux '门' '复' 显示不标准](https://www.cnblogs.com/CodeAndMoe/p/14279135.html)

原因：因为 Noto Sans CJK 中包含日文，而日文显示的优先级高于中文
解决：调高中文的显示优先级

[参考: 修正简体中文显示为异体（日文）字形](https://wiki.archlinux.org/index.php/Localization_(简体中文)/Simplified_Chinese_(简体中文)#修正简体中文显示为异体（日文）字形)

```shell
sudo vim /etc/fonts/conf.d/64-language-selector-prefer.conf
```

把带有 `JP` 和 `KR` 都移动到 `SC` 下面(或最后)

更新字体缓存

```shell
fc-cache -fv
```

执行以下命令检查，如果出现 `NotoSansCJK-Regular.ttc: "Noto Sans CJK SC" "Regular"` 则表示设置成功：

```shell
fc-match -s | grep 'Noto Sans CJK'
```

**notes**:如果输入法的字体没有改变，那就注销.

### GNOME插件

Gnome桌面环境有一些非常不错的扩展，这里推荐一些常用的

* Coverflow Alt-Tab 功能与AlternateTab相同，但提供了一个更酷炫的界面
* Caffeine 取消自动锁屏
* Clipboard Indicator 剪贴板管理
* Dash to Dock 不解释
* EasyScreenCast 屏幕录像，做演示时比较方便
* Screenshot Tool 屏幕截图工具，也具有一些简单的图片编辑功能
* Gnomodoro 简易番茄钟
* Pomodoro 增强的番茄钟，推荐使用。严格来说，它已经不是扩展了，作者现在将它做成了一个本地应用。对于Debian，新的安装方法如下

`$ sudo aptitude install gnome-shell-pomodoro1`

* Hide Top Bar 全屏时自动隐藏顶栏
* Lock Keys 顶栏显示Numlock和Capslock的状态
* NetSpeed 顶栏显示网速，喜欢简洁的Simple net speed也非常不错
* OpenWeather 顶栏显示天气情况，gnome自带的weather不支持顶栏显示，用起来不方便
* Places Status Indicator 为一些常用目录提供快速入口
* system-monitor 顶栏显示CPU、内存、网速、温度、电池电量等信息，安装前需要解决依赖，在Debian上方法如下

`$ sudo aptitude install gir1.2-gtop-2.0 gir1.2-networkmanager-1.01`

* Todo.txt GTD应用，顶栏显示比较醒目
* TopIcons Plus 顶栏显示应用图标，输入法切换的时候特别有用
* User Themes 从本地安装shell主题
* Workspace Indicator 在顶栏显示当前所处的工作空间
* Gsconnect 手机和电脑的连接工具，相当于苹果系统的airdrod工具
* proxy switcher代理切换工具

### 主题推荐

white macOS

### 软件推荐

截图工具： flameshot  配置快捷方式 flameshot gui

Albert工具，类似苹果的lanuch

pdf工具foixt

搜狗输入法

qv2ray

spotify

网易云音乐

goldendict词典可以放本地词典

chrome插件

rgrep

clangd

node

lazygit

### vim基础设置

# nvim的安装和设置
  需要额外安装nodejs和fzf的代码颜色的辅助插件还要安装和配置ctags 通过源码编译安装
  原文地址：https://www.cnblogs.com/zjutzz/p/9393397.html

```
sudo apt install autoconf
cd /tmp
git clone https://github.com/universal-ctags/ctags
cd ctags
./autogen.sh
./configure --prefix=/opt/software/universal-ctags  # 我的安装路径。你按自己的情况调整。
make -j8
sudo make install

# 如果你装了emacs-snapshot，那么现在的ctags命令实际上链接到了/usr/bin/ctags-snapshot，要先删除链接文件：
# sudo rm /usr/bin/ctags

# 然后，把新编译安装的universal-ctags链接过来：
sudo ln -s /opt/software/universal-ctags/bin/ctags /usr/bin/ctags

```

COC配置添加：


# zsh设置

主题为ys

插件 autojump，本地也要安装这个插件

hight等等

还有ssh快速登录问题：

alias 'ssh404_brighter'='ssh brighter@10.112.81.222 -p 2222'

然后在配置公钥私钥自动登录


# 改键盘映射设置1
安装dconf-editor

```shell
sudo apt install dconf-editor
dconf-editor
#找到以下路径
#org / gnome / desktop / input-sources / xkb-options
#在 Custom value 处输入：
#['caps:swapescape']
```

关闭退出即可，重启【reboot】生效！

原文链接：https://blog.csdn.net/weixin_41995541/article/details/100222437

# 改键盘映射设置2
原文地址：https://blog.csdn.net/new_delete_/article/details/90612773
1 查看keycode
使用以下命令可以查看要修改的键值keycode:
```
$ xev grep | keycode
```
以发现，Alt右键和Ctrl右键的keycode分别为108和105.

注意：对于Shift、Caps、Ctrl、Alt等修饰键，可以通过下面命令查看:
```
xmodmap -pm

cd ~ && vim .Xmodmap
```

```
clear lock
keycode 66 = Escape NoSymbol Escape
keycode 9 = Escape NoSymbol Escape
```
 或者：
```
clear mod1
add mod1 = Alt_L Meta_L
keycode 108 = Home

clear control
add control = Control_L
keycode 105 = End
```

注意：可以不用clear，而使用remove mod1 = Alt_R 移除该快捷键，但这种情况下该脚本只能执行一次，因为一次后就删除了该快捷键，再执行会报错。

```
xmodmap .Xmodmap
```
# 安装clangd的时候注意事项
要安装插件coc-json, coc-clangd
安装ccls sudo apt install ccls 配置相关文件

# 双系统时间同步
buntu18.04+win10解决办法：
安装ntpdate：

执行命令：# sudo apt-get install ntpdate
设置校正服务器：

执行命令：# 
sudo ntpdate time.windows.com
设置硬件时间为本地时间：

执行命令：# 
sudo hwclock --localtime --systohc
执行命令：# 
reboot

## 双系统时间同步2
## 更新ubuntu的系统时间
sudo apt-get update
sudo apt-get install ntpdate
sudo ntpdate time.windows.com
## 将时间更新到硬件上
sudo hwclock --localtime --systohc

让windows把计算机硬件时间当作UTC，在命令提示符（需要管理员权限）下输入：

Reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1

# deepin-wechat install

1.下载最新的deepin-wine，下载方式有两种

1）下载地址：http://packages.deepin.com/deepin/pool/non-free/d/deepin-wine/
sudo dpkg --add-architecture i386
echo '添加成功，准备刷新apt缓存信息...'
sudo apt update
echo '即将开始安装...'
sudo dpkg -i *.deb
echo '安装完成，正在自动安装依赖...'
sudo apt install -f

uinstall wechat
echo '正在准备卸载...'
sudo apt remove *deepin*wine* udis86
sudo apt autoremove
echo '卸载完成...'

微信无法发送图片：
sudo apt-get install libjpeg62:i386
