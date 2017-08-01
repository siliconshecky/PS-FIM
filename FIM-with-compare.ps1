$dirinput = Read-Host -Prompt 'Do you want to read directories from a file (Y/N)?'
if ($dirinput -eq "Y") 
    {$path= read-host -prompt "File path and name (i.e. c:\test\test.txt)" 
    $files = get-content -path $path  -ErrorAction stop}
    Else 
    {$files= get-childitem  (read-host -Prompt 'Directory (include *.* for all files in directory or more specifics if needed)') -ErrorAction stop } #gets input from user as to directory to search
$output = read-host -prompt 'Output path and filname(csv file will be in c:\csv, please incluse .csv at end of filename)' -ErrorAction stop  #gets output file information

#loop to enumerate files in path
foreach ($file in $files){
   
    Get-FileHash -Algorithm md5 $file | Export-csv -path $output -append  -force #get the md5 hash of a file and write to output file
    Get-FileHash -Algorithm sha1 $file | Export-csv -path $output -append -force #get the sha1 hash of a file and write to output file
 
   }

$compare = read-host -Prompt 'Do you want to compare hashes with a baseline (Y/N)' -ErrorAction stop
if ($compare -eq "Y")
    {$baseline = Read-host -Prompt 'Path and name of baseline file'
    $basefile = Import-csv -path $baseline
    $newfile = Import-csv -path $output
    Compare-Object $basefile $newfile -Property Hash, Path, Algorithm
    }
write-host 'Have a nice day'