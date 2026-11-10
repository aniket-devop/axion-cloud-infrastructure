$dev = Get-Content k8s/overlays/dev/kustomization.yaml -Raw
$rx = '(?m)^\s*-\s*name:\s*(\S+)\s*\r?\n(?:\s*newName:\s*\S+\s*\r?\n)?\s*newTag:\s*(\S+)'
$m = [regex]::Matches($dev, $rx)
if ($m.Count -ne 4) { throw "dev mein 4 images chahiye, mile $($m.Count)" }
$out = @("apiVersion: kustomize.config.k8s.io/v1beta1","kind: Kustomization","namespace: axion-prod","resources:","- ../../base","images:")
foreach ($x in $m) {
  $tag = $x.Groups[2].Value
  if ($tag -eq 'initial') { throw "$($x.Groups[1].Value) ka tag abhi 'initial' hai, pehle uska build chalao" }
  $out += "- name: $($x.Groups[1].Value)"
  $out += "  newTag: $tag"
}
$out += @("patches:","- patch: |-","    - op: add","      path: /spec/template/spec/imagePullSecrets","      value:","        - name: acr-secret","  target:","    kind: Deployment")
[System.IO.File]::WriteAllText((Join-Path (Get-Location) "k8s/overlays/prod/kustomization.yaml"), (($out -join "`n") + "`n"), (New-Object System.Text.UTF8Encoding($false)))
"prod overlay updated"