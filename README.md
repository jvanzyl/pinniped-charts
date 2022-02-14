# Pinniped Helm Charts

A very nascent version of [Pinniped][1] Helm charts for Concierge, Supervisor and the Local User Authenticator. 

Process to generate the charts:

1. Ytt uber manifest is generated from ytt files + Ytt values.
2. Ytt manifests are generated by kubectl-splice'ing the Ytt uber manifest.
3. Helm templates are generated by mutating the Ytt manifests. A limited number of variables are injected right now.
4. Helm manifests are generating using `helm template` + Helm `values.yaml`.
5. Dyff of Ytt manifests vs Helm manifests is performed where each Ytt/Helm manifest pair needs to be canonically identical.

To be sure, if you look at the shell script to produce the charts you will cry. As noted in the script, I'm not sure if the script will continue to be used once verified to be working. But long term it may be better to always mechanically create the charts. Not sure.

## Todo

1. Run the local Pinniped integration test. In theory this should work given the manifests produced by the two paths are identical (save for one).
2. Figure out why the remaining single manifest does not register as canonically identical (may need raise and issue or PR for Dyff)
3. Determine the structure of the Helm `values.yaml` files for each chart. This definitely needs work, I just plugged in values to achieve parity in the comparison.

## Assumptions for Helm chart generation

The generated charts are checked in right now, so you don't have to generate the charts to try them, but if you want to generate the charts yourself then the following is assumed:

- The [pinniped repository][3] is cloned in a sibling directory named `pinniped`.
- You have `ytt` on your path: https://carvel.dev/ytt
- You have `kubectl-splice` on your path: https://github.com/patrickdappollonio/kubectl-slice
- You have `yq` on your path: https://github.com/mikefarah/yq
- You have `dyff` on your path: https://github.com/homeport/dyff

[1]: https://pinniped.dev
[2]: https://github.com/vmware-tanzu/pinniped/tree/main/deploy
[3]: https://github.com/vmware-tanzu/pinniped.git