Dodany został moduł dotyczący obsługi czasu pracy ( dodawania oraz raportowanie czasu pracy )  - Add TimeSheet module :) 

Dokumentacje dot ServiceDesku API możemy znaleźć tutaj 
https://www.manageengine.com/products/service-desk/sdpod-v3-api/requests/request.html#get-request


Przykładowe zapytania 

```powershell
1278, 1279, 1280 |Add-ServiceDeskWorklogs -Hours 1 -Owner rupiewicz # Dodaj godzine w zgłoszeniach 
```
```powershell
Get-ServiceDeskWorklogs -id 1278  |where  Owner  -Like  "*rupiewicz*"  |Sort-Object  -Property  start_time  |  select  start_time,owner,time_spent  #sprawdź godziny w zgłoszeniu 
```
```powershell
Get-ServiceDeskWorklogs -id 1278 |where Owner -Like "*rupiewicz*" | Measure-Object -Property time_spent -su #Przelicz godziny w zgłoszeniu  
```
# PowerShell Module: ServiceDeskPlus
PowerShell module focused on manipulating the ManageEngine ServiceDesk Plus API.

## Setup
Clone the module into your PowerShell modules directory:

```powershell
git clone "https://github.com/rupiewicz/powershell-sdp" "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\ServiceDeskPlus"
```

Alternatively, create a symlink:

```powershell
$ProjectPath = "$env:USERPROFILE\projects\powershell-sdp"
$InstallPath = "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\ServiceDeskPlus"

cmd /c mklink /d $InstallPath $ProjectPath
```

Add your [ServiceDesk Plus](https://www.manageengine.com/products/service-desk/) API key and server URI to your PowerShell profile as [default parameter values](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters_default_values?view=powershell-6):

```powershell
# Update default parameters hash with SDP API key and server URI
$PSDefaultParameterValues["*-ServiceDesk*:Uri"] = "https://sdp.example.com"
$PSDefaultParameterValues["*-ServiceDesk*:ApiKey"] = "B42550F3-006D-48EB-8011-F6C7D6323EE7"
```
