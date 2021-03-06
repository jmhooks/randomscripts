Write-Host "Retrieving logs..."
$port = new-Object System.IO.Ports.SerialPort COM1,115200,None,8,one
$port.Open()
$port.WriteLine('root')
sleep(1)
$port.WriteLine('evertz')
Write-Host "..."
sleep(1)
$port.WriteLine('ifconfig eth0 | grep HW')
$port.WriteLine('cat /var/log/messages')
Write-Host "..."
sleep(1)
$str = $port.ReadExisting()
Write-Host "..."
sleep(1)
$port.WriteLine('exit')
$port.Close()
$date = Get-Date -f MM-dd-yyyy_HH_mm_ss
$str | Out-File $("C:\Users\centraleng\Desktop\VPDA\logs\vpdalog_" + $date +".log")
Write-Host "Done!"
sleep(1)