<#
    .SYNOPSIS
    Converts DOC and DOCX files to PDF format.

    .DESCRIPTION
    This script uses Microsoft Word to open each DOC or DOCX file and save it as a PDF.

    .PARAMETER FromPath
    The directory path or file path from where the script should process DOC(X) files.

    .PARAMETER ToPath
    The directory path or file path where the script should save the converted PDF files.

    .EXAMPLE
    Convert-WordToPdf -FromPath "C:\SourceDocuments" -ToPath "C:\ConvertedPDFs"
    This will convert all DOC(X) files in C:\SourceDocuments and its subdirectories to PDF and save them in C:\ConvertedPDFs with the same folder structure.

    .EXAMPLE
    Convert-WordToPdf -FromPath "C:\SourceDocuments\MyFile.docx" -ToPath "C:\ConvertedPDFs"
    This will convert the specified DOCX file to PDF and save it in the specified directory.

    .EXAMPLE
    Convert-WordToPdf -FromPath "C:\SourceDocuments\MyFile.docx" -ToPath "C:\ConvertedPDFs\MyOutput.pdf"
    This will convert the specified DOCX file to PDF and save it with the specified filename.
#>
function Convert-WordToPdf {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FromPath,

        [Parameter(Mandatory=$true)]
        [string]$ToPath
    )

    # Validate the provided paths
    $fromIsFile = Test-PathIsFile -Path $FromPath
    $fromIsDir = Test-PathIsDirectory -Path $FromPath
    $toIsFile = Test-PathIsFile -Path $ToPath
    $toIsDir = Test-PathIsDirectory -Path $ToPath

    if ($fromIsDir -and $toIsFile) {
        Write-Error "Invalid combination. When FromPath is a directory, ToPath should also be a directory."
        return
    }

    if ($fromIsFile -and ($FromPath -notlike '*.doc' -and $FromPath -notlike '*.docx')) {
        Write-Error "Invalid FromPath. When providing a file path for FromPath, it must have either a '.doc' or '.docx' extension."
        return
    }
    
    if ($toIsFile -and ($ToPath -notlike '*.pdf')) {
        Write-Error "Invalid ToPath. When providing a file path for ToPath, it must have a '.pdf' extension."
        return
    }

    # Initialize Word application
    try {
        $wordApp = New-Object -ComObject Word.Application -ErrorAction Stop
        $wordApp.Visible = $false
    } catch {
        Write-Error "Microsoft Word must be installed to run this script."
        return
    }

    # Define Word constants
    $wdFormatPDF = 17   # Output format = PDF
    $wdFormatDocx = 16  # Format for DOCX

    # Determine the list of Word files to process
    if ($fromIsDir) {
        $wordFiles = Get-ChildItem -Path $FromPath -Recurse -Include *.doc, *.docx
    } else {
        $wordFiles = @(Get-Item $FromPath)
    }

    try {
        # Process each Word file
        foreach ($wordFile in $wordFiles) {
            # Determine the PDF output path
            if (-not $toIsFile) {
                if ($fromIsDir) {
                    $relativePath = $wordFile.FullName.Substring($FromPath.Length)
                    $pdfFileName = Join-Path -Path $ToPath -ChildPath ($relativePath -replace '\.[^.]+$', '.pdf')
                } else {
                    $pdfFileName = Join-Path -Path $ToPath -ChildPath ($wordFile.BaseName + ".pdf")
                }
            } else {
                $pdfFileName = $ToPath
            }

            # Ensure directory for the PDF exists
            $pdfFileDirectory = Split-Path -Path $pdfFileName -Parent
            if (-not (Test-Path $pdfFileDirectory)) {
                New-Item -Path $pdfFileDirectory -ItemType Directory
            }

            # Open and convert the Word file to PDF
            $document = $wordApp.Documents.Open($wordFile.FullName)

            # If it's a .doc, convert in-memory to .docx
            if ($wordFile.Extension -eq ".doc") {
                $tempDocx = [System.IO.Path]::GetTempFileName() + ".docx"
                $document.SaveAs($tempDocx, $wdFormatDocx)
                $document.Close()
                $document = $wordApp.Documents.Open($tempDocx)
            }

            # Save as PDF
            try {
                $document.SaveAs($pdfFileName, $wdFormatPDF)
                Write-Output "Saved $pdfFileName"
            } finally {
                $document.Close()
                if ($wordFile.Extension -eq ".doc") {
                    Remove-Item -Path $tempDocx -Force
                }
            }
        }

    } finally {
        # Cleanup
        $wordApp.Quit()
    }
}
