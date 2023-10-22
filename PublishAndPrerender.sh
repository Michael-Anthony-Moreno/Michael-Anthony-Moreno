#!/bin/bash
rm -rf Prerender/output
dotnet publish Client/CustomResumeBlazor.csproj -c Release -o Prerender/output --nologo
pushd Prerender
npx react-snap
find ./output -name "*.html" | while read htmlFile; do
    sed -i 's/<script>var Module; window.__wasmmodulecallback__(); delete window.__wasmmodulecallback__;<\/script><script src="_framework\/dotnet.6.0.21.7g581f789m.js" defer="" integrity="sha256-0OV6gibFzyVtG7NXEj8a6vG3u8Cbzv4l9kkEathZjQ8=" crossorigin="anonymous"><\/script>//g' $htmlFile
	sed -i 's/mud-drawer-close-persistent-left/mud-drawer-open-persistent-left/g' $htmlFile
	sed -i 's/mud-drawer--closed/mud-drawer--open/g' $htmlFile
done
popd