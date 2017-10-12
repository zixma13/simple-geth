# in/out files
$configFile  = "myown.properties"
$vagrantOrig = "Vagrantfile.orig"
$vagrantOut  = "Vagrantfile"

# input file exist ?
if (((test-path $configFile) -and (test-path $vagrantOrig)) -eq $false) {
  echo "failed"
  exit 1
}

# read config file
$cfg = convertfrom-stringdata (get-content $configFile -raw)

# read vagrant file (original)
$tmp=(Get-Content $vagrantOrig)

# replace vagrant file with properties's configured
$cfg.GetEnumerator() | % { 
  $tmp = $tmp.replace($_.key, $_.value)
}

# write Vagrantfile
$tmp | set-content $vagrantOut

echo "success"

exit 0