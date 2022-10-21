# Upgrading a Kubernetes cluster

## Initial Informations

### Showcase

**Core**

- k8s_version: 1.22.4 => 1.23.8 -> 1.24.xx
- orchestrator_version: 1.22.4 -> 1.23.8 ->  1.24.xxx

**Inventory**
- akv2k8s_chart_version: 2.1.0 -> 2.2.0
- kured_chart_version: 2.11.2 -> 3.0.0
- reloader_chart_version: v0.0.104 -> v0.0.118

The following elements will note be tackled by this upgrade
- guacd_image_tag: 1.3.0 (no changes)
- guacd_openssh_image_tag: v1.0.3 -> v1.0.4
- filebeat_chart_version: 7.15.0 (no changes)
- metricbeat_chart_version: 7.15.0 (no changes)



## General note

- When doing an upgrade, you have to go through all the minor versions (you can't just jump one)
- invenory/prod/group_vars/aks.yaml file to update
- ansible-kuberntes-runtime repository -> shows you a list of available components ant the current versions; try to keep this up to date
- Manually uninstall the helm chart of kure


## Big Picture

**Update the Components**
1. **Update the runtime component versions**
2. Create PR's for that
3. Open Lens and  in the cluster
   1.  `helm -n kured list` ;
   2. `helm -n kured uninstall kured`
   3. `helm -n reloader get all`
   4. watch the pods and start the playbook `watch -n5 kubectl get pods -A`
4. Run the k8s runtime template
5. Check if the kured version was updated `k -n kured get pods -o yaml |grep -i Image:` -> Should be version 3.0.0

**Update the Kubernetes repository**
1. Open the customers-core repository
2. Update the following two variables
   1. k8s_version -> "1.23.8"
   2. orchestrator_version -> "1.23.8"


## Links


## Helpers

```sh
az aks get-versions --location westeurope --output table # Gives you the current versions of aks for your region
```
