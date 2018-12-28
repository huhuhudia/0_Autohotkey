
#SingleInstance force
path_str := Explorer_GetPath()

IfNotExist, % path_str
{
    ToolTip, 当前窗口不在可创建文件位置, 1
    sleep 800
    ExitApp
}

;~ 编辑器文件路径
editorpath_str = C:\Program Files\AutoHotkey\SciTE\SciTE.exe
;~ inputbox高度
inpuheight_str := 139
;~ 文件头
Ecoding_str := "UTF-8"
line1_str = #NoEnv
line2_str = #SingleInstance force

line3_str = #Persistent
line4_str := "SetWorkingDir %A_ScriptDir%"
Text_str :=
loop 4
	Text_str := % Text_str line%A_Index%_str "`r`n"

InputBox, newAHKFileName_str, ,Please input a new file name to ahk. `n esc or close than script will do nothing and exit., , , %inpuheight_str%
if newAHKFileName_str {
	
	newfile_obj := FileOpen(path_str "\" newAHKFileName_str ".ahk", "w", "UTF-8")
	newfile_obj.Encoding := Ecoding_str	;~ 设定文件编码
	newfile_obj.Write(Text_str)			;~ 写入内容
	newfile_obj.Close()
	
	Loop {
		sleep 10
		if fileexist(path_str "\" newAHKFileName_str ".ahk")
			break
		if (a_index > 100)
			break
	}

	;~ 释放对象
	newfile_obj := 
	;~ 用编辑器打开ahk文件
	run, % editorpath_str " " path_str "\" newAHKFileName_str ".ahk"
}
ExitApp

    Explorer_GetPath(hwnd="")  
    {  
        if !(window := Explorer_GetWindow(hwnd))  
            return ErrorLevel := "ERROR"  
        if (window="desktop")  
            return A_Desktop  
        path := window.LocationURL  
        path := RegExReplace(path, "ftp://.*@","ftp://")  
        StringReplace, path, path, file:///  
        StringReplace, path, path, /, \, All   
        ; thanks to polyethene  
        Loop  
            If RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", hex)  
                StringReplace, path, path, `%%hex%, % Chr("0x" . hex), All  
            Else Break  
        return path  
    }  
      
    Explorer_GetAll(hwnd="")  
    {  
        return Explorer_Get(hwnd)  
    }  
      
    Explorer_GetSelected(hwnd="")  
    {  
        return Explorer_Get(hwnd,true)  
    }  
      
    Explorer_GetWindow(hwnd="")  
    {  
        ; thanks to jethrow for some pointers here  
        WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")  
        WinGetClass class, ahk_id %hwnd%  
      
        if (process!="explorer.exe")  
            return  
        if (class ~= "(Cabinet|Explore)WClass")  
        {  
            for window in ComObjCreate("Shell.Application").Windows  
                if (window.hwnd==hwnd)  
                    return window  
        }  
        else if (class ~= "Progman|WorkerW")   
            return "desktop" ; desktop found  
    }  
      
    Explorer_Get(hwnd="",selection=false)  
    {  
        if !(window := Explorer_GetWindow(hwnd))  
            return ErrorLevel := "ERROR"  
        if (window="desktop")  
        {  
            ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman  
            if !hwWindow ; #D mode  
                ControlGet, hwWindow, HWND,, SysListView321, A  
            ControlGet, files, List, % ( selection ? "Selected":"") "Col1",,ahk_id %hwWindow%  
            base := SubStr(A_Desktop,0,1)=="\" ? SubStr(A_Desktop,1,-1) : A_Desktop  
            Loop, Parse, files, `n, `r  
            {  
                path := base "\" A_LoopField  
                IfExist %path% ; ignore special icons like Computer (at least for now)  
                    ret .= path "`n"  
            }  
        }  
        else  
        {  
            if selection  
                collection := window.document.SelectedItems  
            else  
                collection := window.document.Folder.Items  
            for item in collection  
                ret .= item.path "`n"  
        }  
        return Trim(ret,"`n")  
    }  