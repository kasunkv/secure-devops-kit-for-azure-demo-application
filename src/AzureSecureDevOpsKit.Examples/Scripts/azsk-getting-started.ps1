# ==================================================
#             Install the AzSK Module
# ==================================================

# Install AzSK
Install-Module AzSK -Scope CurrentUser -AllowClobber -Force

# Set the Execution Policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Import the AzSK module
Import-Module AzSK

# Reset the Execution Policy
Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser

# Inspect available commands
Get-Command -Module AzSK


# ==================================================
#                     Analyze
# ==================================================

$subscriptionId = "<subscription-id>"
$tenantId = "<tenant-id>"
$rgName = "AzSK-RG"

# Login to Subscription

Connect-AzAccount
# Get-AzSubscription
Set-AzContext -Subscription $subscriptionId -Tenant $tenantId

Get-AzContext


# Analyze Azure Subscription
Get-AzSKSubscriptionSecurityStatus -SubscriptionId $subscriptionId

# Analyze Resource Group
Get-AzSKAzureServicesSecurityStatus -SubscriptionId $subscriptionId -ResourceGroupNames $rgName


# ==================================================
#                     Monitor
# ==================================================
$LAWSId = '<log-analytics-workspace-id>'
$LAWSKey = '<log-analytics-workspace-key>'
$LAWSRg = "AzSK-RG"
$subscriptionId = "<subscription-id>"

# Set Log Analytics Workspace Settings Locally (You need to close existing powershell sessions and restart)
Set-AzSKMonitoringSettings -LAWSId $LAWSId -LAWSSharedKey $LAWSKey


# Install Monitoring Dashboard on Log Analytics
Install-AzSKMonitoringSolution -LAWSSubscriptionId $subscriptionId -LAWSResourceGroup $LAWSRg -LAWSId $LAWSId -ViewName "AzSK Monitoring Dashboard" 


# ==================================================
#             Continuous Assurance
# ==================================================

$automationAccountName = "azskautomation"
$automationAccountRg = "AzSK-RG"
$automationAccountLocation = "southeastasia"
$subscriptionId = "<subscription-id>"
$LAWSId = '<log-analytics-workspace-id>'
$LAWSKey = '<log-analytics-workspace-key>'

# Install and Configure Azure Automation Runbook
Install-AzSKContinuousAssurance -SubscriptionId $subscriptionId `
                                -AutomationAccountName $automationAccountName `
                                -AutomationAccountRGName $automationAccountRg `
                                -AutomationAccountLocation $automationAccountLocation `
                                -ResourceGroupNames "*" `
                                -LAWSId $LAWSId `
                                -LAWSSharedKey $LAWSKey 