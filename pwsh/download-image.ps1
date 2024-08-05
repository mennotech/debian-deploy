#https://medium.com/@maros.kukan/automating-debian-linux-installation-24d10c85f797

#Ask for debian version to download
$DefaultDebianVersion = "12.6.0"
if (!($DebianVersion = Read-Host "Please specify debian version number: [$DefaultDebianVersion]")) { $DebianVersion = $DefaultDebianVersion }


try {
# Download the installation media
  Invoke-WebRequest -Uri "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-$DebianVersion-amd64-netinst.iso" `
                  -OutFile "debian-$DebianVersion-amd64-netinst.iso"
}
catch {
  Write-Error "Failed to download https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-$DebianVersion-amd64-netinst.iso"
  Return $_
}

# Download the checksum file
Invoke-WebRequest -Uri "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS" `
                  -OutFile SHA512SUMS

# Display the expected SHA512 sum
$ExpectedHash = (Select-String -Pattern "debian-$DebianVersion" -Path SHA512SUMS -Raw).Split(" ")[0]
Write-Host "Expected SHA512 hash:"
Write-Host $ExpectedHash

# Calculate the actual SHA512 sum
Write-Host "Calculating SHA512 hash for debian-$DebianVersion-amd64-netinst.iso..."
$ISOHash = (Get-FileHash -Algorithm SHA512 -Path "debian-$DebianVersion-amd64-netinst.iso").Hash.ToLower()
Write-Host $ISOHash

if ($ExpectedHash -eq $ISOHash) {
  Write-Host "SHA512 hash matches"
} else {
  Write-Error "SHA512 hash missmatch!"
}
