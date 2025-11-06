<#
.SYNOPSIS
Securely creates a CLIXML file containing an encrypted PSCredential object.

.DESCRIPTION
This script prompts the user for a username and password via a secure dialog box,
creates a PSCredential object, and encrypts it to a file using Export-Clixml.
The file is encrypted using the current user's security context and can only be
decrypted by that same user account on the same machine.

.VERSION
1.0.0 - 2025-11-05
    - Initial creation for securing credentials.

.CHANGELOG
2025-11-05: Initial version for securing credentials using CLIXML.

.NOTES
Run this script once for each of your main credential pairs, changing the
-FilePath argument for each run (e.g., Cred1.xml, Cred2.xml, Cred3.xml).
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$FilePath
)

# Prompt for credentials securely
$Cred = Get-Credential -Message "Enter the username and password for this credential set (to be saved to $FilePath)"

# Encrypt and export the credential object to the specified path
try {
    $Cred | Export-Clixml -Path $FilePath -Force
    Write-Host "Success! Encrypted credential saved to: $FilePath" -ForegroundColor Green
}
catch {
    Write-Error "Failed to export credential: $($_.Exception.Message)"
}
