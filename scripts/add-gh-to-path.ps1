# 把 GitHub CLI 追加到用户 PATH（若已存在则跳过）
$userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
$ghDir = 'C:\Program Files\GitHub CLI'
if ($userPath -notlike "*$ghDir*") {
    $newPath = $userPath.TrimEnd(';') + ';' + $ghDir
    [Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
    Write-Output "已追加: $ghDir"
} else {
    Write-Output "已在 PATH 中，跳过"
}
