rem prerequisites 7z needs to be in windows path

echo "Save to B drive"

cd /d E:\

7z a -bd Management.zip Management\

xcopy "E:\Management.zip" B:\ /Y

del Management.zip

rem rd /s /q Content
rem call 7z a .\Content\Dropbox.zip "D:\Dropbox" -pPasswordHere

pause