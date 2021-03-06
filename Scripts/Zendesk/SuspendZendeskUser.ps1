﻿$user = 'xyz@gmail.com'
$pass= '***'
$SamAccountName = args[0]
$pair = "$($user):$($pass)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

$basicAuthValue = "Basic $encodedCreds"

$Headers = @{
    Authorization = $basicAuthValue
}

$Result = Invoke-WebRequest -Uri ("https://{subdomain}.zendesk.com/api/v2/search.json?query=type:user "+ $SamAccountName + "" | echo) -Headers $Headers
$x = $Result.Content | ConvertFrom-Json
$id = $x.results.id

Invoke-WebRequest -Uri ("https://{subdomain}.zendesk.com/api/v2/users/" + $id + ".json" | echo) -body '{"user": {"suspended": true}}' -ContentType "application/json" -Headers $headers -Method PUT