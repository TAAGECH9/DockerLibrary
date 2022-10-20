# Core Concepts

## etcd

- default port is 2379
- Default etcd version 2 is used, but you can also explicitly tell to use version 3. Version 3 and version 2 are not compatible!.

```sh
etcdctl set key1 value1
etcdctl get key1
etcdctl cluster-health
etcdctl mk
etcdctl mkdir
etcdctl backup
kubectl exec etcd-master -n kube-system etcdctl get / --prefix -keys-only
```

## misc

- In generall you can download all the kubernetes componets and run it as a service on your computer


## ReplicaSet

- Replication Controller vs. Replica Set
  - Replica Set -> New recommended way on how to work. Other technology is deprecated
- Uses `lables` and `selectors` to monitor the corresponding applications

## Deployments
    - Not too much to say

## Services
    - Enable loose coupling
    - NodePort, ClusterIp and LoadBalancer$
    - ClusterIp is the default (internal Service)
    - Loadbalancher -> Servicetype LoadBalancer and you have to define a Cloud LoadBalancer

## Namespaces
    - 
