function Add-ServiceDeskWorklogs {
    param (
        # ID of the ServiceDesk Plus request
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        # Hours spent on the worklog
        [Parameter(Mandatory)]
        [int]
        $Hours,

        # Owner of the worklog
        [Parameter(Mandatory)]
        [string]
        $Owner,

        # Base URI of the ServiceDesk Plus server, i.e. https://sdp.example.com
        [Parameter(Mandatory)]
        $Uri,

        # ServiceDesk Plus API key
        [Parameter(Mandatory)]
        $ApiKey
    )

    begin {
        $InputData = @{
            worklog = @{
                description = $Message
                time_spent = @{
                    hours = $Hours
                }
                owner = @{
                    name = $Owner
                }
            }
        }
    }

    process {
        foreach ($RequestId in $Id) {
            $Parameters = @{
                Body = @{
                    TECHNICIAN_KEY = $ApiKey
                    input_data = ($InputData | ConvertTo-Json -Depth 5 -Compress)
                }
                Method = "Post"
                Uri = "$Uri/api/v3/requests/$RequestId/worklogs"
            }

            $Response = Invoke-RestMethod @Parameters

            [PSCustomObject] @{
                Id = $Id
                Message = $Response.response_status.status
            }
        }
    }
}