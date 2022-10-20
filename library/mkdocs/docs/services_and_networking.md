# Services and Networking

## Service Types

Existing service types are:

- NodePort
- ClusterIP

NodePort Example:

```yaml
apiVersion: v1
kind: Service
metadata:
    name: myapp-service
spec:
    type: NodePort
    ports:
        - targetPort: 80
          port: 80
          nodePort: 30008
    selector:
        app: myapp
        type: front-end
```

ClusterIP example:

```yaml
apiVersion: v1
kind: Service
metadata:
    name: back-end
spec:
    type: ClusterIp
    ports:
        - targetPort: 80
          port: 80
    selector:
        app: myapp
        type: front-end
```

## Ingress

1. Deploy supported solution (called: Ingress controller)
2. Configure (called: Ingress Resources)

### Ingress Controller
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: nginx-ingress-controller
spec:
    replicas: 1
    selector:
        matchLabels:
            name: nginx-ingress
    template:
        metadata:
            labels:
                name: nginx-ingress
        spec:
            containers:
                - name: nginx-ingress-controller
                  image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0
            args:
                - /nginx-ingress-controller
                - --configmap=$ (POD_NAMESPACE)/nginx-configuration
            env:
                - name: POD_NAME
                  valueFrom:
                    fieldRef:
                        fieldPath: metadata.namespace
            ports:
                - name: http
                  containerPort: 80
                - name: https
                  containerPort: 443
```

Furthermore you have to build a service, the config map, Service Account:

**Service**

```yaml
apiVersion: v1
kind: Service
metadata:
    name: nginx-ingress
spec:
    type: NodePort
    ports:
        - port: 80
          targetPort: 80
          protocol: TCP
          name: http
        - port: 443
          targetPort: 443
          protocol: TCP
          name: https
    selector:
        name: nginx-ingress
```

**ConfigMap**

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: nginx-configuration
```

**Service Account**
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
    name: nginx-ingress-serviceaccount
```

### Ingress Resource

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
    name: ingress-wear
spec:
    backend:
        serviceName: wear-service
        servicePort: 80
```

Splitting by patch

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
    name: ingress-wear-watch
spec:
    rules:
    - http:
        paths:
        - path: /wear
            serviceName: wear-service
            servicePort: 80

        - path: /watch
            serviceName: watch-service
            servicePort: 80
```

``` yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
    name: ingress-wear-watch
spec:
    rules:
    - hosts: wear.my-online-store.com
      http:
        paths:
            -backend:
                serviceName: wear-service
                servicePort: 80
    - hosts: watch.my-online-store.com
      http:
        paths:
            -backend:
                serviceName: watch-service
                servicePort: 80
```

## Network Policies

```yaml
apiversion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
    name: db-policy
spec:
    podSelector:
        matchLabels:
            role: db
    policyTypes:
    - Ingress
    ingress:
    - from:
        - podSelector:
            matchLabels:
                name: api-pod
          namespaceSelector:
            matchLabels:
                name: prod
        - ipBlock:
            cidr: 192.168.5.10/32
        ports:
        - protocol: TCP
          port: 3306
```
