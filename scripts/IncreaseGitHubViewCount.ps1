# Prompt for the GitHub username
$Username = Read-Host "Enter the Username"

# Prompt for the number of iterations (Leave blank for unlimited)
$CountInput = Read-Host "Enter the count (Leave blank for unlimited)"

# Validate if the username is provided
if ([string]::IsNullOrEmpty($Username)) {
    Write-Host "Username is null or empty"
    return
}

# Set the URL
$Url = "https://github.com/$Username"

# Define headers with a randomized User-Agent to avoid being detected as a bot
$Headers = @{
    "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}

# If the count is not specified, loop indefinitely
if ([string]::IsNullOrEmpty($CountInput)) {
    $i = 1
    while ($true) {
        # Send a GET request with headers (User-Agent)
        $Response = Invoke-WebRequest -Uri $Url -Method GET -Headers $Headers
        Write-Host "Response Status Code: $($Response.StatusCode)"

        # Clear the current line and print the new count
        Write-Host -NoNewline "`rIncreased view count: $i"

        # Increment the count
        $i++

        # Randomize the delay (between 1 and 5 seconds)
        Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 5)
    }
}
elseif ([int]::TryParse($CountInput, [ref]$Count)) {
    # If the count is a valid number, use it to limit iterations
    for ($i = 1; $i -le $Count; $i++) {
        # Send a GET request with headers (User-Agent)
        $Response = Invoke-WebRequest -Uri $Url -Method GET -Headers $Headers

        # Clear the current line and print the new count
        Write-Host -NoNewline "`rIncreased view count: $i"

        # Randomize the delay (between 1 and 5 seconds)
        Start-Sleep -Seconds (Get-Random -Minimum 1 -Maximum 5)
    }
}
else {
    Write-Host "Invalid count. Please enter a valid number."
}
