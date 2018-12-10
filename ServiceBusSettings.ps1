Param(
    [string]$ServiceBusNameSpace,
    [string]$ResourceGroupName,
    [string]$AzureSubscription,
    [string]$FunctionAppName,
    [string]$ServiceBusKeyName,
    [string]$KeyVaultName,
	[string]$DefaultPolicy,
	[string]$sbConnectionString,
	[string]$webApp,
	[string]$appSettings,
	[string]$newAppSettings,
	[string]$secretvalue,
	[string]$secretKeyValue,
	[string]$item
)

#Get the service bus namespace
Get-AzureRmServiceBusNamespace -ResourceGroup $ResourceGroupName -NamespaceName $ServiceBusNameSpace

$sbConnectionString = (Get-AzureRmServiceBusKey -ResourceGroup $ResourceGroupName -NamespaceName $ServiceBusNameSpace -Name $DefaultPolicy).PrimaryConnectionString

$sbConnectionString

#Get Function App
$webApp = Get-AzureRmWebApp -ResourceGroupName $ResourceGroupName -Name $FunctionAppName 

$webApp

#Get Function appsettings
$appSettings = $webapp.SiteConfig.AppSettings

$appSettings

#Get the app settings
$newAppSettings = @{} 

ForEach ($item in $appSettings) 
{
    $newAppSettings[$item.Name] = $item.Value
}

#Set the service bus connection string to variable "ServiceBusConnectionString"
$newAppSettings.ServiceBusConnectionString = $sbConnectionString 

#apply the new settings in function app
Set-AzureRmWebApp -AppSettings $newAppSettings -Name $FunctionAppName -ResourceGroupName $ResourceGroupName

#Convert to secure string
$secretvalue = ConvertTo-SecureString $sbConnectionString -AsPlainText -Force

#Set the keyvault with the secretvalue
$secretKeyValue = Set-AzureKeyVaultSecret -VaultName $KeyVaultName  -Name $ServiceBusKeyName  -SecretValue $secretvalue  

