If(Test-Path .\Prerender\output)
{
    Remove-Item -Path .\Prerender\output -Recurse
}

dotnet publish .\Client\CustomResumeBlazor.csproj -c Release -o Prerender/output --nologo
Push-Location .\Prerender
npx react-snap
Get-ChildItem ".\output\wwwroot\*.html" -Recurse | ForEach-Object { 
    $HtmlFileContent = (Get-Content -Path $_.FullName -Raw);
    $HtmlFileContent = $HtmlFileContent.Replace('<script>var Module; window.__wasmmodulecallback__(); delete window.__wasmmodulecallback__;</script><script src="_framework/dotnet.6.0.24.t14qolxptp.js" defer="" integrity="sha256-0zvLbm2N57A5LNSoUWIIMXXq7ldIwes8W5WY9/G84GE=" crossorigin="anonymous"></script>','')
    Set-Content -Path $_.FullName -Value $HtmlFileContent
}
Pop-Location