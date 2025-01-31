function Set-CIPPMailboxType {
    [CmdletBinding()]
    param (
        $ExecutingUser,
        $userid,
        $username,
        $TenantFilter,
        [Parameter()]
        [ValidateSet('shared', 'Regular', 'Room', 'Equipment')]$MailboxType
    )

    try {
        $Mailbox = New-ExoRequest -tenantid $TenantFilter -cmdlet "Set-mailbox" -cmdParams @{Identity = $userid; type = $MailboxType } -Anchor $username
        Write-LogMessage -user $ExecutingUser -API "Mailbox Conversion" -message "Converted $($username) to a $MailboxType mailbox" -Sev "Info" -tenant $TenantFilter
        return "Converted $($username) to a $MailboxType mailbox"
    }
    catch {
        Write-LogMessage -user $ExecutingUser -API "Mailbox Conversion" -message "Could not convert $username to $MailboxType mailbox" -Sev "Error" -tenant $TenantFilter
        return  "Could not convert $($username) to a $MailboxType mailbox. Error: $($_.Exception.Message)"
    }
}
