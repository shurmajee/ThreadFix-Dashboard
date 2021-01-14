#script to fetch number of issues reported in threadfix for all apps that fall under a given team. 

# TLS1.2 to be enforced as Powershell by default uses TLS1.0 and below 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$dashboard = @()

#This request will fetch the unique IDs for all applications under a team  https://denimgroup.atlassian.net/wiki/spaces/TDOC/pages/22910548/Get+Team+by+Name+-+API
$Request1 = 'https://{ThreadFix-Base-URL}/threadfix/rest/latest/teams/lookup?name={team_name}&apiKey={API-KEY for your Threadfix Environment}'
$TeamData = Invoke-WebRequest $Request1 -Method get | ConvertFrom-Json 
#Extracting the application IDs from the PS object containing team's information
$applicationID = $TeamData | select -expand object | select -expand applications | select -expand id

Foreach ($id in $applicationID)
{
#$id = $i | select -expand id

$request = "https://{ThreadFix-Base-URL}/threadfix/rest/latest/applications/"+$id+"?apiKey={API-KEY for your Threadfix Environment}"
$data = Invoke-WebRequest $request -Method get | ConvertFrom-Json 
$dashboard += $data.object | Select-Object -Property @{N='Application Name'; E={$_.name}}, @{N='Critical'; E={$_.criticalVulnCount}},@{N='High'; E={$_.highVulnCount}},@{N='Medium'; E={$_.mediumVulnCount}},@{N='Low'; E={$_.lowVulnCount}}
}

#total numbers
$request = 'https://{ThreadFix-Base-URL}/threadfix/rest/teams/lookup?name={team_name}&apiKey={API-KEY for your Threadfix Environment}' 
$total = Invoke-WebRequest $request -Method get | ConvertFrom-Json 
$total.object.name = "Total"

$dashboard += $total.object | Select-Object -Property @{N='Application Name'; E={$_.name}}, @{N='Critical'; E={$_.criticalVulnCount}},@{N='High'; E={$_.highVulnCount}},@{N='Medium'; E={$_.mediumVulnCount}},@{N='Low'; E={$_.lowVulnCount}}
  
$file = "$PSScriptRoot\output.html"
$table =$dashboard | Format-Table  
$dashboard | ConvertTo-Html > $file
