# Shell 学习笔记--范例剖析1

## 范例展示

> 此范例来自 <a href="http://ucanaccess.sourceforge.net/site.html" title="an open-source Java JDBC driver implementation that allows Java developers and JDBC client programs (e.g., DBeaver, NetBeans, SQLeo, OpenOffice Base, LibreOffice Base, Squirrel SQL) to read/write Microsoft Access databases.">UCanAccess</a> 驱动程序，是驱动程序的控制台启动脚本。
>
> 特别说明，文中对英文内容的翻译非是因为英文阅读障碍，而是对内容的梳理，或是说对该部分内容的深度阅读。

```bash

UCANACCESS_HOME=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
echo $UCANACCESS_HOME

CLASSPATH="$UCANACCESS_HOME/lib/hsqldb-2.5.0.jar:$UCANACCESS_HOME/lib/jackcess-3.0.1.jar:$UCANACCESS_HOME/lib/commons-lang3-3.8.1.jar:$UCANACCESS_HOME/lib/commons-logging-1.2.jar:$UCANACCESS_HOME/ucanaccess-5.0.1.jar" 

if [ -d "$JAVA_HOME" -a -x "$JAVA_HOME/bin/java" ]; then
        JAVACMD="$JAVA_HOME/bin/java"
else
        JAVACMD=java
fi

"$JAVACMD"  -cp $CLASSPATH net.ucanaccess.console.Main
```

从上述范例出发，我们将学习/复习两个 `shell` 内建的命令： `cd` 和 `pwd`。  
范例中出现的这两个命令的位置是：  

```bash
cd -P -- "$(dirname --"$0")"  # $0 指代当前文件
```


```bash
pwd -P
```

<p style="background: #ffffa0; color:#023480;"><b style="color:#c33;">提示：</b>上述 cd 命令中的两个短横线表示选项结束，两个横线之后的部分是参数。</p>


## pwd 命令

考虑到这两个命令的难易程度和依赖关系，这里先学习 `pwd` ，后学习 `cd` 。

```bash
$ help pwd
pwd: pwd [-LP]
    Print the name of the current working directory.                                 
    
    Options:                                                                         
      -L        print the value of $PWD if it names the current working              
                directory                                                            
      -P        print the physical directory, without any symbolic links             
    
    By default, `pwd' behaves as if `-L' were specified.                             
    
    Exit Status:
    Returns 0 unless an invalid option is given or the current directory
    cannot be read.
```

以下为译文：

```
pwd: pwd [-LP]
    打印当前工作目录的名称。
    
    选项：
      -L		如果变量 PWD 命名了当前工作目录，打印该变量的值
      -P		打印物理目录，不带有符号链接
      
    选项缺省时，`pwd' 同指定 `-L' 选项一样。
    
    退出状态：
    如果不是给定非法选项或是当前路径不可访问，返回 0 。
```


## cd 命令

```bash
$ help cd
cd: cd [-L|[-P [-e]] [-@]] [dir]
    Change the shell working directory.
    
    Change the current directory to DIR.  The default DIR is the value of the
    HOME shell variable.
    
    The variable CDPATH defines the search path for the directory containing
    DIR.  Alternative directory names in CDPATH are separated by a colon (:).
    A null directory name is the same as the current directory.  If DIR begins
    with a slash (/), then CDPATH is not used.
    
    If the directory is not found, and the shell option `cdable_vars' is set,
    the word is assumed to be  a variable name.  If that variable has a value,
    its value is used for DIR.
    
    Options:
      -L        force symbolic links to be followed: resolve symbolic
                links in DIR after processing instances of `..'
      -P        use the physical directory structure without following
                symbolic links: resolve symbolic links in DIR before
                processing instances of `..'
      -e        if the -P option is supplied, and the current working
                directory cannot be determined successfully, exit with
                a non-zero status
      -@        on systems that support it, present a file with extended
                attributes as a directory containing the file attributes
    
    The default is to follow symbolic links, as if `-L' were specified.              
    `..' is processed by removing the immediately previous pathname component        
    back to a slash or the beginning of DIR.                                         
                                                                                     
    Exit Status:                                                                     
    Returns 0 if the directory is changed, and if $PWD is set successfully when      
    -P is used; non-zero otherwise. 
```

以下为译文：

```
cd: cd [-L|[-P [-e]] [-@]] [dir]
    更改 shell 的工作目录·「译者按：请参考 pwd 命令」
    
    更改当前目录到 dir。 dir 缺省时，使用 HOME 变量的值。
    
    变量 CDPATH 定义了 dir 的搜寻路径。CDPATH 中的多个目录名用冒号（:）分隔·「译者按：看范例中的 CLASSPATH 变量，多个路径之间也是冒号分隔」。（CDPATH 中）空的目录名等同于当前目录。如果 dir 以斜线开头，CDPATH 变量就用不上了。
    
    如果目录没有找到，且 shell 设置了 `cdable_vars' 选项，这个参数·「译者按： dir 」被假定为一个变量名。如果变量有值，该变量的值被用于 dir。
    
    选项：
      -L		强制跟踪符号链接： 在处理 `..' 实例后解析 dir 中的符号链接·「译者按：见后文“处理 `..'”部分」
      -P		使用不带有符号链接的物理目录结构： 在处理 `..' 实例前解析 dir 中的符号链接·「译者按：见后文“处理 `..'”部分」
      -e		如果使用了 -P 选项且当前工作目录未成功关闭，以一个非零状态退出
      -@		在支持该选项的系统中，展示带有扩展属性的文件（因为目录包含了文件属性）
    
    缺省的选项是跟随符号链接，同指定 -L 效果一样。
    处理 `..' 就是移除路径名前方直到遇到斜线或 dir 开头的部分
    
    退出状态：
    如果目录更改，且当使用 -P 时，$PWD 成功设置，返回 0；否则，返回非零值。
```

**补充：**

```
cd 命令的参数中可能会出现的特殊符号：

.		表示当前目录
		用法： cd ./xxx/
..		表示当前目录的上级目录
		用法： cd ../
~		当前用户的家目录，即 $HOME 的值
		用法： cd ~/
		cd ~/Desktop/
-		返回目录更换前的位置，该位置记录在 $OLDPWD 中，
		用法： cd -
!$		表示上一条命令的参数，可用 Escape + . 调出该参数（可连续使用）
		用法： cd !$
```
