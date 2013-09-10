Config {
    font = "xft:Fixed-8",
    bgColor = "#000000",
    fgColor = "#ffffff",
    position = Static { xpos = 0, ypos = 884, width = 1599, height = 16 },
    lowerOnStart = True,
    commands = [
        Run Cpu ["-L","3","-H","50","--normal","#CEFFAC","--high","#FFB6B0"] 10,
        Run MultiCpu ["-t","Cpu: <total0><total1>","-L","3","-H","50","--normal","#CEFFAC","--high","#FFB6B0","-w","5"] 10,
        Run Memory ["-t","Mem: <usedratio>%"] 10,
        Run Swap [] 10,
	Run BatteryP ["BAT1"] ["-t","<acstatus><watts> (<left>%)","-L","10","-H","80","-p","3","--","-O","<fc=#CEFFAC>On</fc> - ","-L","15","-H","-5","-l","#FFB6B0","-h","#CEFFAC"] 10,
        Run Network "wlan0" ["-t","Net: <rx>, <tx>","-H","200","-L","10","-h","#FFB6B0","-l","#CEFFAC","-n","#FFFFCC"] 5,
        Run Date "%a %b %_d %H:%M" "date" 10,
        Run StdinReader
    ],
    sepChar = "%",
    alignSep = "}{",
    template = "%StdinReader% }{ %multicpu%   %memory%   %swap%   %battery%   %wlan0%   <fc=#FFFFCC>%date%</fc>"
}
