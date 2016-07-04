(*
AWWW（White Window Workaround.plugin）インストーラー
WhiteWindowWorkaround.pluginをインストールします

20160704　初回作成

詳しくは
Wacom 社製タブレット使用時にメニューや投げ縄ツールなど一部の機能が使用できない（Mac OS 版 Photoshop）
https://helpx.adobe.com/jp/photoshop/kb/cq03060049.html

*)

----ログを表示
tell application "AppleScript Editor"
	activate
	try
		tell application "System Events" to keystroke "3" using {command down}
	end try
	try
		tell application "System Events" to keystroke "l" using {option down, command down}
	end try
end tell

---日付けと時間からテンポラリー用のフォルダ名を作成
set theNowTime to (my doDateAndTIme(current date)) as text
---テンポラリー用フォルダのパスを定義
set theTrashDir to ("/tmp/" & theNowTime) as text
-----テンポラリーフォルダを作成
try
	set theCommand to ("mkdir -pv " & theTrashDir) as text
	do shell script theCommand
	set theTmpPath to theTrashDir as text
	delay 1
on error
	return "テンポラリフォルダ作成でエラーが発生しました"
end try

-----ファイルをダウンロード
try
	set theCommand to ("curl -L -o '" & theTmpPath & "/WhiteWindowWorkaround.plugin1_0_6.zip' 'https://helpx.adobe.com/content/help/jp/photoshop/kb/cq03060049/_jcr_content/main-pars/procedure/proc_par/step_0/step_par/download/file.res/WhiteWindowWorkaround.plugin1_0_6.zip'") as text
	do shell script theCommand
	delay 1
on error
	return "ダウンロードでエラーが発生しました"
end try
-----ファイルを解凍
try
	set theCommand to ("unzip  '" & theTmpPath & "/WhiteWindowWorkaround.plugin1_0_6.zip' -d '" & theTmpPath & "'") as text
	do shell script theCommand
	delay 1
on error
	return "ファイルの解凍でエラーが発生しました"
end try

tell application "Finder"
	---アプリケーションフォルダのエリアスをテキストで取得
	set theApplicationDir to (path to applications folder from local domain) as text
	---解凍後のプラグインのエリアスをテキストで取得
	set thePluginFile to ("/private" & theTrashDir & "/WhiteWindowWorkaround.plugin") as text
end tell
---解凍後のプラグインをエイリアスで取得
set aliasPluginFile to (POSIX file thePluginFile) as alias
---CS6
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CS6:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CS6は未インストール又はプラグインインストール済み"
end try
---CC
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CC:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CCは未インストール又はプラグインインストール済み"
end try
---CC2014
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CC 2014:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CC 2014は未インストール又はプラグインインストール済み"
end try
---CC2015
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CC 2015:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CC 2015は未インストール又はプラグインインストール済み"
end try
---CC2015
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CC 2015:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CC 2015は未インストール又はプラグインインストール済み"
end try
---CC2015.3
try
	tell application "Finder"
		set aliasPsdDir to ""
		set aliasPsdDir to (theApplicationDir & "Adobe Photoshop CC 2015.5:Plug-ins") as alias
		duplicate aliasPluginFile to folder aliasPsdDir
	end tell
on error
	log "CC 2015.5は未インストール又はプラグインインストール済み"
end try
---終了メッセージ
return "AWWWのインストールを終了しましたPhotoshopを再起動（終了〜開始）してください"


--------------------------------------------------#ここからサブルーチン
to doDateAndTIme(theDate)
	set y to (year of theDate)
	set m to my monthNumStr(month of theDate)
	set d to day of theDate
	set hms to time of theDate
	set hh to h of sec2hms(hms)
	set mm to m of sec2hms(hms)
	set ss to s of sec2hms(hms)
	return (y as text) & my zero1(m) & my zero1(d) & "_" & zero1(hh) & zero1(mm) & zero1(ss)
	return (y as text) & my zero1(m) & my zero1(d)
end doDateAndTIme

------------------------------
to monthNumStr(theMonth)
	set monList to {January, February, March, April, May, June, July, August, September, October, November, December}
	repeat with i from 1 to 12
		if item i of monList is theMonth then exit repeat
	end repeat
	return i
end monthNumStr
------------------------------
to sec2hms(sec)
	set ret to {h:0, m:0, s:0}
	set h of ret to sec div hours
	set m of ret to (sec - (h of ret) * hours) div minutes
	set s of ret to sec mod minutes
	return ret
end sec2hms
------------------------------
to zero1(n)
	if n < 10 then
		return "0" & n
	else
		return n as text
	end if
end zero1

