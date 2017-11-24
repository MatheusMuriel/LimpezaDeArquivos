#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileSelectFolder, Pasta
Pasta := RegExReplace(Pasta, "\\$")  ; Seleciona o local

FileList=
Loop, %Pasta%\*.pdf, , 1
	FileList = %FileList%%A_LoopFileTimeModified%`t%A_LoopFileName%`n
Sort, FileList, R  ; Ordenar por data

Hoje := A_Now
FormatTime, DataAtual, %Hoje%, dd-MM-yyyy

D30 := -30
EnvAdd, Hoje, D30, Days
FormatTime, DataLimite, %Hoje%, dd-MM-yyyy

MsgBox,Hoje é: %DataAtual% `n 30 dias atras é: %DataLimite%


Loop, parse, FileList, `n
{
	if A_LoopField = 
		continue
	StringSplit, FileItem, A_LoopField, %A_Tab%  ; Quebra em 2 partes 
	FormatTime, OutputDat, %FileItem1%, dd-MM-yyyy
	
	VarLocalArq = %Pasta%\%FileItem2%
	VarDataArq = %OutputDat%
	VarDataMax = %DataLimite%
	
	if(VarDataArq < VarDataMax)
	MsgBox, 3,, O arquivo %FileItem2% (%OutputDat%) é antigo... Deseja apagar?
	IfMsgBox, Yes 
	{
		FileDelete, %VarLocalArq%
		MsgBox, Arquivo %FileItem2% Deletado
	}
	IfMsgBox,Cancel
		Break
	
	
}