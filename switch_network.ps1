# Windows Network Toggle Utility (Ethernet <-> Wi-Fi)
# Switches between physical Ethernet and Wi-Fi adapters.
param(
    [ValidateSet("toggle", "status")]
    [string]$Action = "toggle"
)

# 1. Detect physical network adapters
$adapters = Get-NetAdapter -Physical -ErrorAction SilentlyContinue

# Detect Wi-Fi adapter (802.11)
$wifiAdapter = $adapters | Where-Object {
    $_.PhysicalMediaType -like "*802.11*" -or 
    $_.MediaType -like "*802.11*" -or 
    $_.Name -like "*Wi-Fi*" -or 
    $_.InterfaceDescription -like "*Wireless*" -or 
    $_.InterfaceDescription -like "*Wi-Fi*"
} | Select-Object -First 1

# Detect Ethernet adapter (802.3)
$ethAdapter = $adapters | Where-Object {
    ($_.PhysicalMediaType -like "*802.3*" -or $_.MediaType -like "*802.3*") -and
    $_.InterfaceDescription -notlike "*Wireless*" -and
    $_.InterfaceDescription -notlike "*Wi-Fi*"
} | Select-Object -First 1

# Fallbacks by common interface names
if (-not $wifiAdapter) {
    $wifiAdapter = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Name -like "*Wi-Fi*" -or $_.Name -like "*Wireless*" } | Select-Object -First 1
}
if (-not $ethAdapter) {
    $ethAdapter = Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object { $_.Name -in @("Ethernet", "乙太網路") } | Select-Object -First 1
}

if (-not $wifiAdapter -or -not $ethAdapter) {
    if ($Action -eq "status") {
        Write-Warning "Unable to identify both Wi-Fi and Ethernet adapters."
        if ($wifiAdapter) { Write-Output "Wi-Fi   : $($wifiAdapter.Name)" } else { Write-Output "Wi-Fi   : Not found" }
        if ($ethAdapter)  { Write-Output "Ethernet: $($ethAdapter.Name)" } else { Write-Output "Ethernet: Not found" }
    }
    exit 1
}

$wifiName = $wifiAdapter.Name
$ethName  = $ethAdapter.Name

if ($Action -eq "toggle") {
    $wifiCurrent = (Get-NetAdapter -Name $wifiName -ErrorAction SilentlyContinue).Status

    if ($wifiCurrent -eq 'Up') {
        # Wi-Fi is currently connected -> Switch to Ethernet
        netsh interface set interface name="$wifiName" admin=disable
        netsh interface set interface name="$ethName" admin=enable
    } else {
        # Ethernet is connected (or Wi-Fi is down) -> Switch to Wi-Fi
        netsh interface set interface name="$ethName" admin=disable
        netsh interface set interface name="$wifiName" admin=enable
    }
} elseif ($Action -eq "status") {
    $wStatus = (Get-NetAdapter -Name $wifiName -ErrorAction SilentlyContinue).Status
    $eStatus = (Get-NetAdapter -Name $ethName -ErrorAction SilentlyContinue).Status
    Write-Output "Wi-Fi   [$wifiName]: $wStatus"
    Write-Output "Ethernet[$ethName] : $eStatus"
}
