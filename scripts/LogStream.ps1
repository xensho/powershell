$logFilePath = "C:\path\to\your\iislog.log"

# Define the time threshold (30 minutes ago)
$timeThreshold = (Get-Date).AddMinutes(-30)

# Regular expression to extract timestamp
# Assumes format: 2025-05-15 12:34:56.7890
$timestampRegex = '^\s*(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{4})'

# Open file using StreamReader
$reader = [System.IO.StreamReader]::new($logFilePath)

try {
    while (($line = $reader.ReadLine()) -ne $null) {
        if ($line -match $timestampRegex) {
            $timestampString = $matches[1]
            $timestamp = [datetime]::ParseExact($timestampString, 'yyyy-MM-dd HH:mm:ss.ffff', $null)

            if ($timestamp -ge $timeThreshold) {
                Write-Output $line
            }
        }
    }
}
finally {
    $reader.Close()
}
