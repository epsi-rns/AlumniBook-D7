; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=AlumniBook
AppVerName=AlumniBook
DefaultDirName={pf}\CitraJaya\AlumniBook

DisableProgramGroupPage=yes
; ^ since no icons will be created in "{group}", we don't need the wizard
;   to ask for a group name.
;# DefaultGroupName=Iluni DB

UninstallDisplayIcon={app}\Alumni.exe
Compression=lzma
SolidCompression=yes

VersionInfoDescription=The Alumni Yellow Book Setup
; Uncomment the following line to disable the "Select Setup Language"
; dialog and have it rely solely on auto-detection.
ShowLanguageDialog=no

[Languages]
Name: id; MessagesFile: "compiler:Indonesian.isl"

[Files]
Source: "C:\Docs\IluniDB\Executable\Alumni.exe"; DestDir: "{app}"
Source: "C:\Docs\IluniDB\Executable\Alumni.css"; DestDir: "{app}"
Source: "C:\Docs\IluniDB\Executable\tables.my.sql"; DestDir: "{app}"
; Source: "C:\Program Files\Borland\Delphi7\Projects\Bpl\AboutPack.bpl"; DestDir: "{app}"
; Source: "C:\Program Files\Firebird\gds32.dll"; DestDir: "{app}"
Source: "C:\Windows\system32\rtl70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\dbrtl70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vcl70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vcldb70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vcljpg70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vclx70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vclactnband70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\vclsmp70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\ibxpress70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\tee70.bpl"; DestDir: "{sys}"
Source: "C:\Windows\system32\teedb70.bpl"; DestDir: "{sys}"
; Source: "C:\Windows\system32\Rave50VCLBE70.bpl"; DestDir: "{sys}"

;# Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme

[Icons]
;# Name: "{group}\AlumniBook"; Filename: "{app}\Alumni.exe"
Name: "{commonprograms}\AlumniBook"; Filename: "{app}\Alumni.exe"
Name: "{userdesktop}\AlumniBook"; Filename: "{app}\Alumni.exe"

[Registry]
; Start "Software\My Company\My Program" keys under HKEY_CURRENT_USER
; and HKEY_LOCAL_MACHINE. The flags tell it to always delete the
; "My Program" keys upon uninstall, and delete the "My Company" keys
; if there is nothing left in them.
Root: HKCU; Subkey: "Software\CitraJaya"; Flags: uninsdeletekeyifempty
;# Root: HKCU; Subkey: "Software\CitraJaya\AlumniBook"; Flags: uninsdeletekey

