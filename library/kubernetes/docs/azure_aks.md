# Working with the Azure AKS Service

For this you have to have the az cli installed.

```sh
az account set -s ''
az aks get-credentials --resource-group belh-prd-pcmsakshub-rg --name belh-prd-pcmsakshub01
kubectl config get-contexts

kubectl config use-context my-cluster-name
kubectl -n guacd describe deployments openssh-server
```
