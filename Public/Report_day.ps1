$Id = 150486 # Przyk³adowe ID zg³oszenia
$Hours = 1
$Owner = "wlasciciel"
$Message = "test"

# Pêtla przez ka¿dy dzieñ od 4 do 8 grudnia
foreach ($day in 4..8) {
    $date = Get-Date "2023-12-$day"
    $StartTime = $date.AddHours(9) # Rozpoczêcie o 9:00
    $EndTime = $date.AddHours(12) # Zakoñczenie o 12:00

    Add-ServiceDeskWorklogs -Id $Id -Hours $Hours -Owner $Owner -StartTime $StartTime -EndTime $EndTime -Message $Message
}
