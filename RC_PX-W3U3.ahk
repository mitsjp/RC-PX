;＜番組表サイト指定＞（オプション）
;番組表ボタンで開くサイトのＵＲＬを指定してください。（例：TVRock 番組表など）
;ブランクにすると、番組表ボタンは HSUS リモコンの EPG ボタンとして働きます。
;ProgramTableSite = http://127.0.0.1:8969/nobody/
ProgramTableSite =

;＜TVTest 起動コマンド指定＞（オプション）
;閉じるボタンで TVTest を起動したい場合は TVTest のインストール先ディレクトリと起動コマンドを指定してください。
;（すでに TVTest が起動しているときは、閉じるボタンは HDUS リモコンの電源ボタンとして働きます。）
;ブランクにすると、起動機能は無効になります。
TVTestDir = C:\DTV\TVTest
TVTestCmd = TVTest.exe /d BonDriver_Spinel_S0.dll /f

MediaLauncherDir = C:\Filer\afxw17
MediaLauncherCmd = AFXW.EXE -s -L"\\Videos\usbdisk1\Videos\" -*L"*.ts" -SL"T-"


;//ボタン対応表
;
;同名のボタンがあるばあいは原則そのまま対応させていますが、画面表示ボタンは HDUS の全画面表示に対応させました。
;
;PX-W3U3 リモコン ⇒ HDUS リモコン
;1 ⇒ 1
;2 ⇒ 2
;3 ⇒ 3
;4 ⇒ 4
;5 ⇒ 5
;6 ⇒ 6
;7 ⇒ 7
;8 ⇒ 8
;9 ⇒ 9
;* ⇒ 11
;0 ⇒ 0
;# ⇒ 12
;Power ⇒ 電源				※TVTest 未起動時は TVTest 起動
;Mute ⇒ 消音
;Infomation ⇒ メニュー
;FullScreen ⇒ 全画面表示
;SubTitle ⇒ 字幕
;Audio Change ⇒ 音声切替
;EPG ⇒ EPG				※番組表サイト指定時は指定サイトを開く
;Back ⇒ 戻る
;Record ⇒ 録画
;Rec list ⇒ メモ
;Stop ⇒ 停止
;Play ⇒ 再生
;Pause ⇒ 一時停止
;|<< ⇒ |<<
;<< ⇒ <<
;>> ⇒ >>
;>>| ⇒ >>|
;d ⇒ 画面表示
;Signal Source Change				※放送波切り換え
;TV ⇒ しおり
;DVD ⇒ ジャンプ
;音量＋ ⇒ 音量＋
;音量－ ⇒ 音量－
;チャンネル＋ ⇒ チャンネル↑
;チャンネル－ ⇒ チャンネル↓


;//以下ホットキー定義本体

;Power
<+F14::
	;すでにTVTest が起動している場合
	IfWinExist, ahk_class TVTest Window
	{
		WinActivate
		SendToTVTest("+{F14}")	;電源
		return
	}
	;TVTest が起動していない場合
	if (TVTestDir <> "" and TVTestCmd <> "") {
		Run, %TVTestDir%\%TVTestCmd%, %TVTestDir%	;TVTest 起動
        	SignalSource = B
	}
	return

;Player ON
<!<#Enter::
        if (MediaLauncherDir <> "" and MediaLauncherCmd <> "") {
                Run, %MediaLauncherDir%\%MediaLauncherCmd%, %MediaLauncherDir%
        }
	return

;Player OFF
;<!F4::


#IfWinActive ahk_class TAfxWForm
{
<!F4::
	WinActivate
	Send, "q"
	return
}
return


#IfWinActive ahk_class TVTest Window
{

;1::SendToTVTest("+{F17}")	;1 ⇒ 1
;2::SendToTVTest("+{F18}")	;2 ⇒ 2
;3::SendToTVTest("+{F19}")	;3 ⇒ 3
;4::SendToTVTest("+{F20}")	;4 ⇒ 4
;5::SendToTVTest("+{F21}")	;5 ⇒ 5
;6::SendToTVTest("+{F22}")	;6 ⇒ 6
;7::SendToTVTest("+{F23}")	;7 ⇒ 7
;8::SendToTVTest("+{F24}")	;8 ⇒ 8
;9::SendToTVTest("^{F13}")	;9 ⇒ 9
;*::SendToTVTest("+{F16}")	;* ⇒ 10
;0::SendToTVTest("^{F14}")	;0 ⇒ 11
;(::SendToTVTest("^{F15}")	;# ⇒ 12

*::SendToTVTest("^{F14}")	;* ⇒ 11
<+3::SendToTVTest("^{F15}")	;# ⇒ 12

F8::SendToTVTest("+{F15}")	;消音

<^D::SendToTVTest("^{F16}")	;メニュー

<!Enter::SendToTVTest("^{F17}")	;全画面表示

<^U::SendToTVTest("^{F18}")	;字幕

<^<+A::SendToTVTest("^{F19}")	;音声切替

<^G::
	if (ProgramTableSite <> "") {
		Run, %ProgramTableSite%	;番組表サイトを開く
	} else {
		SendToTVTest("^{F20}")	;EPG
	}
	return

Backspace::SendToTVTest("^{F20}")	;戻る

<^R::SendToTVTest("^{F22}")	;録画

<^O::SendToTVTest("^{F23}")	;メモ

<^<+S::SendToTVTest("^{F24}")	;停止

<^<+P::SendToTVTest("^+{F13}")	;再生

<^P::SendToTVTest("^+{F14}")	;一時停止

<^B::SendToTVTest("^+{F15}")	;|<<

<^<+B::SendToTVTest("^+{F16}")	;<<

<^<+F::SendToTVTest("^+{F17}")	;>>

<^F::SendToTVTest("^+{F18}")	;>>|

<^<!T::SendToTVTest("+{F13}")	;画面表示

;Signal Source Change
<^<!N::
        if (SignalSource = "C") {
                SendToTVTest("+^{T}") ;TVTestの「キー割り当て」で「チューニング空間1」に「Control+Shift+T」を割り当てる
                SignalSource = T
                return
        }
        if (SignalSource = "T") {
                SendToTVTest("+^{B}") ;TVTestの「キー割り当て」で「チューニング空間3」に「Control+Shift+B」を割り当てる
                SignalSource = B
                return
        }
        if (SignalSource = "B") {
                SendToTVTest("+^{C}") ;TVTestの「キー割り当て」で「チューニング空間4」に「Control+Shift+C」を割り当てる
                SignalSource = C
                return
        }
        SendToTVTest("+^{B}") ;TVTestの「キー割り当て」で「チューニング空間3」に「Control+Shift+B」を割り当てる
        SignalSource = B
	return

<^T::SendToTVTest("^+{F19}")	;しおり

<^<+M::SendToTVTest("^+{F20}")	;ジャンプ

F10::SendToTVTestWithControlSend("+{Up}")	;音量＋
F9::SendToTVTestWithControlSend("+{Down}")	;音量－

PgUp::SendToTVTestWithControlSend("^{Up}")	;チャンネル↑
PgDn::SendToTVTestWithControlSend("^{Down}")	;チャンネル↓

;Blue
<^<!B::SendToTVTest("^+{F21}")

;Red
<^<!R::SendToTVTest("^+{F22}")

;Green
<^<!G::SendToTVTest("^+{F23}")

;Yellow
<^<!Y::SendToTVTest("^+{F24}")

}
return


#IfWinActive ahk_class PowerDVD15
{

;*::*	;*
;<+3::#	;#

F8::SendToPDVD("Q")	;消音

<^D::SendToPDVD("M")	;メニュー

<!Enter::SendToPDVD("Z")	;全画面表示

<^U::SendToPDVD("^U")	;字幕

<^<+A::SendToPDVD("H")	;音声切替

<^G::SendToPDVD("J")	;EPG

Backspace::SendToPDVD("{Esc}")	;戻る

<^R::SendToPDVD("{Tab}")	;録画

<^O::SendToPDVD("J")	;Rec list

<^<+S::SendToPDVD("S")	;停止

<^<+P::SendToPDVD("{Space}")	;再生

<^P::SendToPDVD("{Space}")	;一時停止

<^B::SendToPDVD("P")	;|<<

<^<+B::SendToPDVD("B")	;<<

<^<+F::SendToPDVD("F")	;>>

<^F::SendToPDVD("N")	;>>|

<^<!T::SendToPDVD("^+C")	;d

;Signal Source Change
;<^<!N::

;<^T::	;TV

;<^<+M::	;DVD

F10::SendToPDVD("+")	;音量＋
F9::SendToPDVD("-")	;音量－

PgUp::SendToPDVD("^{Up}")	;チャンネル↑
PgDn::SendToPDVD("^{Down}")	;チャンネル↓

;Blue
<^<!B::SendToPDVD("{F12}")

;Red
<^<!R::SendToPDVD("{F9}")

;Green
<^<!G::SendToPDVD("{F10}")

;Yellow
<^<!Y::SendToPDVD("{F11}")

}
return


SendToPDVD(keysToSend) {
	IfWinExist, ahk_class PowerDVD15
	{
;		WinActivate
		Send, %keysToSend%
	}
}

SendToTVTest(keysToSend) {
	IfWinExist, ahk_class TVTest Window
	{
;		WinActivate
		Send, %keysToSend%
	}
}

SendToTVTestWithControlSend(keysToSend) {
	IfWinExist, ahk_class TVTest Window
	{
		ControlSend, ahk_parent, %keysToSend%
	}
}
