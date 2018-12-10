//Command to get the Settings and import certificates

Get-AzurePublishSettingsFile

Import-AzurePublishSettingsFile 'D:\AzureDeploy\Visual Studio Enterprise-4-22-2016-credentials.publishsettings'

//Get the Cuurent Logined Subscription

Get-AzureSubscription 

//Selecting a perticular Resource Group

Select-AzureSubscription -SubscriptionName "Visual Studio Enterprise"

//Switch From Service Group to ResourceManager Group

Switch-AzureMode AzureResourceManager

//Adding a Azure Account with current Logged in

Add-AzureAccount 

//Login to an Account
Login-AzureRmAccount

//Create a New Resource Group

$LocName = "West US"
$rgName = "ResourceGroupName"
New-AzureRmResourceGroup -Name $rgName -Location $LocName

//test Local Defeneder Deployment

$LocName = "West US"
$rgName = "ResourceGroup"
$deploymentName = "deployment"
$templatePath = "C:\Work\Template.json"
$templateParamFile = "C:\Work\Parameters-Test.json"

New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $rgName -TemplateFile $templatePath -TemplateParameterFile $templateParamFile

//Monitor Template

$LocName = "West US"
$rgName = "ResourceGroup"
$deploymentName = "deployment"
$templatePath = "C:\Work\Monitor-Template.json"
$templateParamFile = "C:\Work\Parameters-Monitor-Test.json"

New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $rgName -TemplateFile $templatePath -TemplateParameterFile $templateParamFile


//Delete and remove entire resourecGroup
Remove-AzureRmResourceGroup -Name daresourcegroup

//Get a ResourceGroup

Get-AzureRmResourceGroup -Name TestResourceGroup

$rgName = "webapp-Test"

Get-AzureRMResource -ResourceGroupName "webapp-Test"

Get-AzureRmResource -ResourceType "microsoft.web/sites" -ResourceGroupName "webapp-Test" -ResourceName "ContosoWebsite"


//Adding Autoscale in ServerFarm

$Rule1 = New-AzureRmAutoscaleRule -MetricName "Requests" -MetricResourceId "/subscriptions/######/resourceGroups/Default-EastUS/providers/microsoft.web/sites/mywebsite" -Operator GreaterThan -MetricStatistic Average -Threshold 10 -TimeGrain 00:01:00 -ScaleActionCooldown 00:05:00 -ScaleActionDirection Increase -ScaleActionScaleType ChangeCount -ScaleActionValue "1" 
$Rule2 = New-AzureRmAutoscaleRule -MetricName "Requests" -MetricResourceId "/subscriptions/######/resourceGroups/Default-EastUS/providers/microsoft.web/sites/mywebsite" -Operator GreaterThan -MetricStatistic Average -Threshold 10 -TimeGrain 00:01:00 -ScaleActionCooldown 00:10:00 -ScaleActionDirection Increase -ScaleActionScaleType ChangeCount -ScaleActionValue "2"

$Profile1 = New-AzureRmAutoscaleProfile -DefaultCapacity "1" -MaximumCapacity "10" -MinimumCapacity "1" -StartTimeWindow 2015-03-05T14:00:00 -EndTimeWindow 2015-03-05T14:30:00 -TimeWindowTimeZone GMT -Rules $Rule1, $Rule2 -Name "adios"
$Profile2 = New-AzureRmAutoscaleProfile -DefaultCapacity "1" -MaximumCapacity "10" -MinimumCapacity "1" -Rules $Rule1, $Rule2 -Name "SecondProfileName" -RecurrenceFrequency Minute -ScheduleDays "1", "2", "3" -ScheduleHours 5, 10, 15 -ScheduleMinutes 15, 30, 45 -ScheduleTimeZone GMT

Add-AzureRmAutoscaleSetting -Location "East US" -Name "MySetting" -ResourceGroup "Default-EastUS" -TargetResourceId "/subscriptions/######/resourceGroups/Default-EastUS/providers/microsoft.web/serverFarms/DefaultServerFarm" -AutoscaleProfiles $Profile1, $Profile2

Set-AzureStorageServiceMetricsProperty