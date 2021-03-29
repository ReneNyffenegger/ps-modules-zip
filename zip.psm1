set-strictMode -version latest

function new-zipArchive {
   param (
      [string]      $zipFilePath
   )

   $zipFilePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($zipFilePath)

   if (test-path $zipFilePath) {
      remove-item $zipFilePath
   }
   [System.IO.Compression.ZipArchive] $zip = [System.IO.Compression.ZipFile]::Open(
        "$zipFilePath",
       ([System.IO.Compression.ZipArchiveMode]::Create)
   )

   return $zip
}

function open-zipArchive {
 #
 # opens an (existing!) zip archive!
 #
   param (
      [string]      $zipFilePath
   )

   $zipFilePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($zipFilePath)

   if (-not (test-path $zipFilePath) ) {
      write-host "$zipFilePath does not exist"
      return
   }

   [System.IO.Compression.ZipArchive] $zip = [System.IO.Compression.ZipFile]::Open(
       $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($zipFilePath),
      ([System.IO.Compression.ZipArchiveMode]::Read)
   )

   return $zip
}

function add-zipEntry {
   param (
      [parameter(mandatory=$true) ]
      [string]                             $filePath     ,
       #
      [parameter(mandatory=$true )]
      [string]                             $entryName    , # = $filePath,
       #
      [parameter(mandatory=$true )]
      [System.IO.Compression.ZipArchive]   $zip            # = # $script:zip
   )

   $entryName = $entryName -replace '^\.[\\/]', ''
   $filePath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($filePath)


   try {
     $null = [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
             $zip,
             $filePath,
             $entryName
         )
   }
   catch {
      write-host "could not add $filePath"
   }
}

function close-zipArchive {
   param (
      [parameter(mandatory=$true)]
      [System.IO.Compression.ZipArchive]   $zip
   )

   $zip.Dispose()
}
