# Connects to the PIM PoSH module and verifies identity.
Connect-PimService –UserName {username}

# Once authenticated and identity is verified, this command isplays information surrounding PIM enrollment.
# Logging into the PIM service also shows the same details, so it is commented out for this script. 
# Show-PimServiceConnection

# Lists out eligible PIM roles
Get-PrivilegedRoleAssignment 

# Stores role assignment as a variable to plug into activation script. 
$roleAssignment = Get-PrivilegedRoleAssignment | Where {$_.RoleName -eq "Application Administrator"}

# PoSH cmdlet enables privileged role assignment for 1 hour and requires a reason.
Enable-PrivilegedRoleAssignment –Duration 1 –RoleAssignment $roleAssignment –Reason “Testing out.”

# Once enabled, run "Get-PrivilegedRoleAssignment" again and you should see something similar:
# PS C:\WINDOWS\system32> Get-PrivilegedRoleAssignment
#
# RoleId         : 9b895d92-2cd3-44c7-9d02-a6ac2d5ea5c3
# RoleName       : Application Administrator
# IsElevated     : True
# IsPermanent    : False
# ExpirationTime : 4/7/2019 9:47:45 PM +00:00
# ResultMessage  : 

# Disables PIM assignment.
Disable-PrivilegedRoleAssignment –RoleAssignment $roleAssignment

# Disconnects from PIM service
Disconnect-PimService
