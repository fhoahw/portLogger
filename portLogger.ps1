# Pfad zum Desktop und zur Logdatei
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$logFile = Join-Path -Path $desktopPath -ChildPath "portLogger.csv"

$interval = 5  # Intervall in Sekunden zwischen den Logs (hier 300 Sekunden = 5 Minuten)
$duration = 3600  # Gesamtdauer des Logs in Sekunden (hier 3600 Sekunden = 1 Stunde)

# Funktion, um die Port-Informationen zu sammeln und in die CSV-Datei zu schreiben
function Log-PortInformation {
    try {
        # Holen der aktiven TCP-Verbindungen und der zugehörigen Prozesse
        $connections = Get-NetTCPConnection | Where-Object { $_.State -eq "Established" }
        $logData = @()

        foreach ($conn in $connections) {
            $proc = Get-Process -Id $conn.OwningProcess -ErrorAction SilentlyContinue
            $logData += [PSCustomObject]@{
                Timestamp         = Get-Date
                LocalAddress      = $conn.LocalAddress
                LocalPort         = $conn.LocalPort
                RemoteAddress     = $conn.RemoteAddress
                RemotePort        = $conn.RemotePort
                State             = $conn.State
                ProcessName       = $proc.ProcessName
                ProcessId         = $conn.OwningProcess
            }
        }

        # Logdaten in die CSV-Datei schreiben
        if (Test-Path $logFile) {
            $logData | Export-Csv -Path $logFile -NoTypeInformation -Append -ErrorAction Stop
        } else {
            $logData | Export-Csv -Path $logFile -NoTypeInformation -ErrorAction Stop
        }

        Write-Host "$(Get-Date) - Logdaten erfolgreich in $logFile geschrieben."
    } catch {
        Write-Host "$(Get-Date) - Fehler beim Schreiben in die Logdatei: $_"
    }
}

# Hauptschleife zum periodischen Loggen
$endTime = (Get-Date).AddSeconds($duration)

while ((Get-Date) -lt $endTime) {
    Log-PortInformation
    Start-Sleep -Seconds $interval
}

Write-Host "$(Get-Date) - Port-Logging abgeschlossen. Datei gespeichert unter $logFile"
