param([string]$repo="gsc", 
      [string]$remote="urbanit",
      [string]$upstream="RFAssurance",
      [string]$branch="dev")

$ElapsedTime = [System.Diagnostics.Stopwatch]::StartNew()
if (-Not ($repo)) 
{ 
	Throw "You must specify an repo name" 
}
Write-Host "Repo: $repo" -foregroundcolor "magenta"

$basePath = "c:\Projects\"
$path = $basePath + $repo + "\" + $remote

If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
      Write-Host "Path: $path created" -foregroundcolor "green"
}Else{
    Write-Host "Path: $path exist" -foregroundcolor "red"
}

Set-Location $path

git clone https://github.com/$remote/$repo.git 2>$null # in order to avoid stder
Write-Host "Repo: $repo cloned" -foregroundcolor "green"

Set-Location ($path + "\" + $repo)

git remote add upstream https://github.com/$upstream/$repo.git 2>$null
git fetch upstream 2>$null
git checkout $branch 2>$null
git merge upstream/$branch 2>$null

Write-Host "Repo: $repo synced" -foregroundcolor "green"

Write-Host $ElapsedTime.Elapsed.ToString()