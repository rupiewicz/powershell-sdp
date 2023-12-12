function Add-ServiceDeskWorklogs {
    param (
        [Parameter(Mandatory)]
        [int]$Id,

        [Parameter(Mandatory)]
        [int]$Hours,

        [Parameter(Mandatory)]
        [string]$Owner,

        [Parameter(Mandatory)]
        [DateTime]$StartTime,

        [Parameter(Mandatory)]
        [DateTime]$EndTime,

        [Parameter(Mandatory)]
        [string]$Uri,

        [Parameter(Mandatory)]
        [string]$ApiKey,

        [Parameter(Mandatory)]
        [string]$Message
    )

    function ConvertTo-UnixTimeMillis($dateTime) {
        $epoch = [DateTime]::new(1970, 1, 1, 0, 0, 0, [DateTimeKind]::Utc)
        return [int64](($dateTime.ToUniversalTime() - $epoch).TotalMilliseconds)
    }

    $InputData = @{
        worklog = @{
            description = $Message
            time_spent = @{
                hours = $Hours
            }
            owner = @{
                name = $Owner
            }
            start_time = @{
                value = ConvertTo-UnixTimeMillis $StartTime
            }
            end_time = @{
                value = ConvertTo-UnixTimeMillis $EndTime
            }
        }
    }

    $Parameters = @{
        Body = @{
            TECHNICIAN_KEY = $ApiKey
            input_data = ($InputData | ConvertTo-Json -Depth 5 -Compress)
        }
        Method = "Post"
        Uri = "$Uri/api/v3/requests/$Id/worklogs"
    }

    $Response = Invoke-RestMethod @Parameters

    [PSCustomObject] @{
        Id = $Id
        Message = $Response.response_status.status
    }
}
