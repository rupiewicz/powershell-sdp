$Id = 150486 # Przyk�adowe ID zg�oszenia
$Hours = 1
$Owner = "wlasciciel"
$Message = "test"

# P�tla przez ka�dy dzie� od 4 do 8 grudnia
foreach ($day in 4..8) {
    $date = Get-Date "2023-12-$day"
    $StartTime = $date.AddHours(9) # Rozpocz�cie o 9:00
    $EndTime = $date.AddHours(12) # Zako�czenie o 12:00

    Add-ServiceDeskWorklogs -Id $Id -Hours $Hours -Owner $Owner -StartTime $StartTime -EndTime $EndTime -Message $Message
}
