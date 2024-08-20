# Port Logger PowerShell Script

Dieses PowerShell-Skript protokolliert alle offenen und genutzten Ports auf einem Windows-Computer inklusive der zugehörigen Prozesse. Die Ergebnisse werden in regelmäßigen Abständen in einer CSV-Datei auf dem Desktop des Benutzers gespeichert.

## Inhalt

- [Installation](#installation)
- [Verwendung](#verwendung)
- [Anpassungen](#anpassungen)
- [Fehlerbehebung](#fehlerbehebung)
- [Lizenz](#lizenz)

## Installation

1. **Speichern des Skripts**: Speichere das Skript in einer Datei mit der Endung `.ps1`, z.B. `portLogger.ps1`.

2. **PowerShell-Sicherheitsrichtlinien**: Stelle sicher, dass die Ausführung von Skripten in PowerShell erlaubt ist. Dies kannst du mit folgendem Befehl überprüfen und ggf. anpassen:

    ```powershell
    Get-ExecutionPolicy
    ```

    Um die Richtlinie zu ändern, führe folgenden Befehl in PowerShell als Administrator aus:

    ```powershell
    Set-ExecutionPolicy RemoteSigned
    ```

## Verwendung

1. **Ausführen des Skripts**: Öffne PowerShell, navigiere zu dem Verzeichnis, in dem sich das Skript befindet, und führe es mit folgendem Befehl aus:

    ```powershell
    .\portLogger.ps1
    ```

2. **Ergebnisse anzeigen**: Nach Ablauf des Skripts findest du die Logdatei `portLogger.csv` auf deinem Desktop. Diese Datei enthält die aufgezeichneten Ports und die zugehörigen Prozesse.

## Anpassungen

- **Intervall anpassen**: Standardmäßig protokolliert das Skript alle 5 Minuten (300 Sekunden). Um das Intervall anzupassen, ändere die Variable `$interval` im Skript.
  
    ```powershell
    $interval = 300  # Intervall in Sekunden
    ```

- **Dauer des Loggings anpassen**: Die Gesamtdauer des Loggings beträgt standardmäßig 1 Stunde (3600 Sekunden). Um diese Dauer anzupassen, ändere die Variable `$duration` im Skript.
  
    ```powershell
    $duration = 3600  # Gesamtdauer des Loggings in Sekunden
    ```

- **Logdatei Speicherort ändern**: Die Logdatei wird standardmäßig auf dem Desktop gespeichert. Um den Speicherort zu ändern, passe die Variable `$logFile` entsprechend an.

    ```powershell
    $logFile = "C:\Pfad\zu\deiner\logdatei.csv"
    ```

## Fehlerbehebung

- **Zugriffsfehler auf Logdatei**: Wenn beim Schreiben der CSV-Datei ein Fehler auftritt, überprüfe die Berechtigungen des Zielverzeichnisses und stelle sicher, dass die Datei nicht von einem anderen Programm geöffnet ist.

- **Keine Prozesse für einige Verbindungen**: Wenn für einige Verbindungen kein zugehöriger Prozessname angezeigt wird, könnte der Prozess bereits beendet sein oder es handelt sich um Systemprozesse, auf die PowerShell keinen Zugriff hat.

## Lizenz

Dieses Skript ist frei verfügbar und kann unter den Bedingungen der [MIT Lizenz](https://opensource.org/licenses/MIT) verwendet, verändert und weitergegeben werden.
