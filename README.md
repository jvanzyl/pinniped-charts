# Pinniped Helm Charts

A very nascent version of [Pinniped][1] Helm charts for Concierge, Supervisor and the Local User Authenticator. Please refer to the [main][2] branch if you're interested how these Helm charts are produced.

*Disclaimer: these are not part of the official Pinniped project. There is no official support for Pinniped Helm charts right now. Hopefully these can eventually become the official Helm charts, but as of today they are not.*

## Adding the Pinniped Helm Repo

```
helm repo add pinniped https://jvanzyl.github.io/pinniped-charts
```

There is not much in the way of documentation but there are examples:

- Example Local User Authenticator [values.yaml][3]

- Example Concierge [values.yaml][4]

- Example Supervisor [values.yaml][5]

[1]: https://pinniped.dev
[2]: https://github.com/jvanzyl/pinniped-charts
[3]: https://github.com/jvanzyl/pinniped-charts/blob/main/charts/pinniped-local-user-authenticator/values.yaml
[4]: https://github.com/jvanzyl/pinniped-charts/blob/main/charts/pinniped-concierge/values.yaml
[5]: https://github.com/jvanzyl/pinniped-charts/blob/main/charts/pinniped-supervisor/values.yaml
