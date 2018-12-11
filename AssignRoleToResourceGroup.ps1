param (
  [string] $ResourceGroupName,
  [string] $RoleType,
  [string] $ObjectId
)

# Check whether we have the Azure RM cmdlets
if(Get-Module -Name "AzureRM*" -ListAvailable)
{
    Write-Verbose -Verbose "Using Azure RM cmdlets..."

    # Check whether this role has already been assigned.
    if (!(Get-AzureRmRoleAssignment -ObjectId $ObjectId | Where-Object {$_.Scope -like "*/" + $ResourceGroupName -and $_.RoleDefinitionName -eq $RoleType}))
    {
        Write-Verbose -Verbose "Assigning $RoleType role to $ResourceGroupName..."        
        New-AzureRmRoleAssignment -ResourceGroupName $ResourceGroupName -RoleDefinitionName $RoleType -ObjectId $ObjectId
    }
    else
    {
        Write-Verbose -Verbose "Role already assigned."
    }
}
else
{
    Write-Verbose -Verbose "Using legacy cmdlets..."
    Switch-AzureMode -Name AzureResourceManager

    # Check whether this role has already been assigned.
    if (!(Get-AzureRoleAssignment -ResourceGroupName $ResourceGroupName -RoleDefinitionName $RoleType -ObjectId $ObjectId))
    {
        Write-Verbose -Verbose "Assigning $RoleType role to $ResourceGroupName..."        
        New-AzureRoleAssignment -ResourceGroupName $ResourceGroupName -RoleDefinitionName $RoleType -ObjectId $ObjectId
    }
    else
    {
        Write-Verbose -Verbose "Role already assigned."
    }
}