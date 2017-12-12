@ECHO OFF
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%i:\sources\install.wim set CDROM=%%i:
if not defined CDROM goto :eof
echo Detected CDROM as drive %CDROM%
cd\

Title WINDOWS PUPPET SLAVE SETUP
Color F0

@echo  **********     Welcome     **********

IF EXIST "C:\Program Files\Puppet Labs\Puppet\bin\puppet.exe" (
	timeout 45
	puppet agent -tdv
) ELSE (
	msiexec /qn /norestart /i %CDROM%\setupfiles\puppet-3.8.7-x64.msi PUPPET_MASTER_SERVER=puppet.simosuominen.com
	cd "C:\Program Files\Puppet Labs\Puppet\bin"
	puppet agent -tdv
)

@echo  **********     Done     **********







