# Configuration

## Commands in Docker

1. Can you explain the difference between `CMD` and `ENTRYPOINT`

## Define Environment Elements

```yaml
env:
    - name: APP_COLOR
      value: pink
```

## Config Maps

- Key Value Pair for configurations
- Phases => Create config map

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_COLOR: blue
  APP_MODE: prod
```

This config map can be used in a pod definition as follows:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      envFrom:
        - configMapRef:
              name: app-config
```

## Secrets

Used to store secred configuration. Secrets are stored in an hashed version.

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_Host: bXlzcWw=
  DB_User: cm9vdA==
  DB_Password: cGFzc3dvcmQ=
```

Inject in a pod by:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      envFrom:
        - secretRef:
              name: app-config
```

## Docker Security

`docker run ubuntu sleep 3600`

- Docker runs container per default as `root`, if you want to change that you have to run the container with the user option
- Docker separates processes by using namespaces
- To prevent privilege escalation Docker uses `Linux Capabilities`
- Capabilities can be added or removed ex.
  - `docker run --cap-add MAC_ADMIN ubuntu`
  - `docker run --cap-drop KILL ubuntu`
  - `docker run --privileged ubuntu` -> All privileges are enabled

## Security Context

- In Kubernetes you can configure the container security aswell.
- Settings on container level will overwritte pod level

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: web-pod
spec:
  containers:
    - name: ubuntu
      image: ubuntu
      command: ["sleep","3600"]
      securityContext:
        runAsUser: 1000
        capabilities:
          add: ["MAC_ADMIN"]
```

## Service Accounts

Type of accounts existing: `User Account` and `Service Account`.

- kubectl create serviceaccount dashboard-sa
- kubectl get serviceaccount
- kubectl describe serviceaccount dashboard-sa # Token is stored for the service account in a secret object
- Each default namespace has a `default service account`. But this is very much restricted

## Resource requirements

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      resources:
        requests:
          memory: "1Gi"
          cpu: 1
        limits:
          memory: "2Gi"
          cpu: 2
```

## Taints and Tolerations

- By default pods have NO tolerations! As soon as a node is tainted

Define toleration on pod definition file

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
  - name: nginx-container
    image: nginx

  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"
```

## Node Selectors

To be able to configure the nodeSelector, you have to set the corresponding labels on the node.

```yaml
apiVersion: v1
kind: Pod
metadata:
  - name: myapp-prod
spec:
  containers:
  - name: data-processor
    image: data-processor
  nodeSelector:
    size: Large
```

## Node Affinity

```yaml
apiVersion: v1
kind: Pod
metadata:
  - name: myapp-prod
spec:
  containers:
  - name: data-processor
    image: data-processor

  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - Large
            - Medium
```
