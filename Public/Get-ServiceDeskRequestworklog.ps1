function Get-ServiceDeskWorklogs {
    param (
        # ID of the ServiceDesk Plus request
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [int[]]
        $Id,

        # Base URI of the ServiceDesk Plus server, i.e. https://sdp.example.com
        [Parameter(Mandatory)]
        $Uri,

        # ServiceDesk Plus API key
        [Parameter(Mandatory)]
        $ApiKey
    )

    process {
        foreach ($RequestId in $Id) {
            try {
                $Parameters = @{
                    Body = @{
                        TECHNICIAN_KEY = $ApiKey
                    }
                    Method = "Get"
                    Uri = "$Uri/api/v3/requests/$RequestId/worklogs"
                }

                $Response = Invoke-RestMethod @Parameters

                foreach ($Work in $Response.worklogs) {
                    [PSCustomObject] @{
                        Id = $Id
                        WorkId = $Work.id
                        Owner = $Work.Owner.name
                        time_spent = $Work.time_spent.hours
                        start_time = $Work.start_time.display_value
                        description = $Work.description 
                    }
                }
            } catch {
                Write-Error "Error occured while getting worklogs for request with ID $RequestId. Error message: $_"
            }
        }
    }
}