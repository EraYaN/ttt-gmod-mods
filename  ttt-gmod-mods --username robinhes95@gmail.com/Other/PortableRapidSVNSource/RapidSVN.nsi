;Portable RapidSVN

;Copyright (C) 
;2007 Jonathan Durant

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with this program; if not, write to the Free Software
;Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA02110-1301, USA.

;---Definitions----

!define PROGRAMMER "Jonathan Durant"
!define LAUNCHERVERSION "1.0.0.0"
!define APPNAME "RapidSVN"
!define SNAME "PortableRapidSVN"
!define EXE "$EXEDIR\App\RapidSVN\rapidsvn.exe"
!define CURRENT "$EXEDIR\Data\Settings\Current.reg" ;Used to backup the local installation settings before running portable edition
!define REGFILE "$EXEDIR\Data\Settings\Settings.reg" ; Portable settings stored here
!define REGKEY "HKEY_CURRENT_USER\Software\RapidSVN" ;Registry program uses to stored settings
!define RAPAPPDATA "$APPDATA\Subversion" ;Folder where prog stores application settings
!define FOLDERBU "$EXEDIR\Data\FolderBU" ;Folder for application data backup before running portable settings, if needed. Portable settings are stored in the PAppData folder here. Folder APPDataLocal created if a local install is found and you choose to run the portable edition.

;----Includes----

!include "Registry.nsh"

;-----Runtime switches----
CRCCheck on
AutoCloseWindow True
SilentInstall silent
WindowIcon off
XPSTYLE on 

;-----Set basic information-----

Name "Portable ${APPNAME}"
Icon "icon.ico"
Caption "Portable ${APPNAME} -  ${LAUNCHERVERSION}"
OutFile "${SNAME}.exe"

;-----Variables----

;-----Version Information------

LoadLanguageFile "${NSISDIR}\Contrib\Language files\English.nlf"

VIProductVersion "${LAUNCHERVERSION}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "Portable ${APPNAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "© ${PROGRAMMER} 2006"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Allows portability of ${APPNAME}."
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${LAUNCHERVERSION}"

;Main program code

Section "Main"

;Check machine for local install and if found show a message box to choose what settings to use.
${registry::KeyExists} "${REGKEY}" $R0
StrCmp $R0 "0" 0 RunPortable
Messagebox::show "" "Local ${APPNAME} Installation Found..." "" "                         ${APPNAME} is currently Installed to the local machine.$\n                 Do you want to use your Portable Settings or the Local Settings?" "Portable Settings" "Local Settings" IDCANCEL 
pop $0
StrCmp $0 "1" BackupLocal
StrCmp $0 "2" RunLocal
StrCmp $0 "3" End

;Backup and Restore
BackupLocal:
	${Registry::SaveKey} "${REGKEY}" "${CURRENT}" "/G=1" $R0
	CopyFiles /SILENT ${RAPAPPDATA} "${FOLDERBU}\AppDataLOCAL"
	goto RunPortable
	
RunPortable:
	${Registry::RestoreKey} ${REGFILE} $R0
	CopyFiles /SILENT "${FOLDERBU}\PAppData\*.*" ${RAPAPPDATA}
	goto RunClean
	
RunLocal:
	Exec "${EXE}"
	goto End
	
RunClean:	
	ExecWait "${EXE}"
	goto Clean

Clean:
	Delete ${REGFILE}
	RMDir /r "${FOLDERBU}\PAppData"
	${registry::SaveKey} "${REGKEY}" "${REGFILE}" "/G=1" $R0
	${registry::DeleteKey} "${REGKEY}" $R0
	CopyFiles /SILENT ${RAPAPPDATA} "${FOLDERBU}\PAppData"
	Sleep 500
	RMDir /r ${RAPAPPDATA}
	IfFileExists "${CURRENT}" 0 End
	${Registry::RestoreKey} "${CURRENT}" $R0
	CopyFiles /SILENT "${FOLDERBU}\AppDataLOCAL" ${RAPAPPDATA}
	Sleep 500
	Delete ${CURRENT}
	RMDir /r "${FOLDERBU}\AppDataLOCAL"
	goto End

End:
${Registry::Unload}
SectionEnd