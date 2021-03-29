@{

   RootModule        = 'zip.psm1'
   ModuleVersion     = '0.0.1'

   RequiredAssemblies = @(
     'System.IO.Compression',
     'System.IO.Compression.FileSystem'
   )

   RequiredModules   = @(
   )

   FunctionsToExport = @(
      'new-zipArchive'  ,
      'open-zipArchive' ,
      'add-zipEntry'    ,
      'close-zipArchive'
   )
   AliasesToExport   = @(
   )
}
