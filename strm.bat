@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: 设置基础路径
set "basePath=G:\strm"
set "urlBase=http://192.168.3.120:5244/d/115网盘/媒体库"

:: 检查路径是否存在
if not exist "%basePath%" (
    echo 错误：路径不存在 "%basePath%"
    pause
    exit /b
)

:: 递归遍历所有媒体文件（支持 18 种格式，可自行添加）
for /r "%basePath%" %%f in (
    *.mkv, *.iso, *.ts, *.mp4, *.avi, *.rmvb, *.wmv,*.m4a,*.flac,*.ape,*.wma,*.dsf
    *.m2ts, *.mpg, *.flv, *.rm, *.mov, *.mp3
) do (
    :: 获取文件完整路径
    set "fullPath=%%f"
    
    :: 提取相对路径（移除基础路径，替换斜杠）
    set "relativePath=!fullPath:%basePath%\=!"
    set "relativePath=!relativePath:\=/!"

    :: 构建完整 URL
    set "mediaUrl=!urlBase!/!relativePath!"

    :: 生成 .strm 文件
    echo !mediaUrl! > "%%~dpnf.strm"
    echo 已创建: %%~dpnf.strm
)

echo 处理完成!
pause