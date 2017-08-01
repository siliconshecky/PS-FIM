$files= get-childitem  (read-host -Prompt 'Directory (include *.* for all files in directory or more specifics if needed)') -ErrorAction stop #gets input from user as to directory to search
$output = read-host -prompt 'Output path and filname(csv file will be in c:\csv, please incluse .csv at end of filename)' -ErrorAction stop  #gets output file information

#loop to enumerate files in path
foreach ($file in $files){
   
    Get-FileHash -Algorithm md5 $file | Export-csv -path $output -append  -force #get the md5 hash of a file and write to output file
    Get-FileHash -Algorithm sha1 $file | Export-csv -path $output -append -force #get the sha1 hash of a file and write to output file
 
   }
 
