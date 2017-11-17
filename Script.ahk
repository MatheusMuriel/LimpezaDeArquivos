﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileSelectFolder, Pasta
Pasta := RegExReplace(Pasta, "\\$")  ; Remove a barra invertida posterior, se presente.

FileList=
Loop, %Pasta%\*.pdf, , 1
 FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileName%`n
Sort, FileList, R  ; Ordenar por data

Hoje := A_Now
FormatTime, DataAtual, %Hoje%, dd-MM-yyyy

D30 := -30
EnvAdd, Hoje, D30, Days
FormatTime, DatSomada, %Hoje%, dd-MM-yyyy

MsgBox,Hoje %DataAtual% `n 30 dias atras %DatSomada%


Loop, parse, FileList, `n
{
	if A_LoopField = 
		continue
		StringSplit, FileItem, A_LoopField, %A_Tab%  ; Quebra em 2 partes 
	FormatTime, OutputDat, %FileItem1% dddd MMMM d, dd/MM tt
    MsgBox, 4,, O arquivo mais recente (%OutputDat%) é:`n%FileItem2%`n`nProximo?
    IfMsgBox, No
        break
}