# Core Concepts

## Terms you should know

1. What is a Node?
2. What is a Cluster?
3. What types of nodes do exist? -> Master and slave

## Components of an kubernetes installation

- api-server -> Frontend kubernetes
- etc -> Key-value store for all the nodes in the cluster
- scheduler -> distributing work around node
- controller -> brain for the container
- container runtime -> Software to run
- kubelet -> Agent running on each node of the cluster.

## Pods

- Single instance of an application

## YAML

Basic yaml elements for each instane

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: myapp-pod
    labels:
        app: myapp
spec:
    containers:
        - name: nginx-container
          image: nginx
```

## Controllers (ReplicaSet)

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
    name: myapp-replicaset
    labels:
        app: myapp
        type: front-end
spec:
    template:
        metadata:
            name: myapp-pod
            labels:
                app:myapp
                type: frontend
        spec:
            containers:
                - name: nginx-conteinrer
                  image: nginx
    replicas: 3
    selector:
        matchLabels:
            type: frontend
```

- labels and selectors can be used to filter down elements

## Namespaces

```yaml
apiVersion: v1
kind: Namespace
metadata:
    name: dev
```

## Kubectl imperative commands

- Checkout the [Documentation](https://kubernetes.io/docs/reference/kubectl/conventions/)
