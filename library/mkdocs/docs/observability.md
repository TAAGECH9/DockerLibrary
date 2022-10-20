# Observability

## Readiness Probes

You can find the conditions under the condition sections when executing `kubectl describe pod`.
To define if an application is ready or not, you could define a `Readiness Probes`

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: simple-webapp
    labels:
        name: simple-webapp
spec:
    containers:
    - name: simple-webapp
      image: simple-webapp
      ports:
        - containerPort: 8080
      readinessProbe:
        httpGet:
          path: /api/ready
          port: 8080
        initialDelaySeconds: 10
        periodSeconds: 5
        failureThreshold: 8
```

Other readinessProbe options would be:
TCP

```yaml
readinessProbe:
    tcpSocket:
        port: 3306
```

```yaml
readinessProbe:
    exec:
        command:
            - cat
            - /app/is_ready
```

## Liveness Probes

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: simple-webapp
    labels:
        name: simple-webapp
spec:
    containers:
    - name: simple-webapp
      image: simple-webapp
      ports:
        - containerPort: 8080
    - livenessProbe:
        httpGet:
            path: /api/healthy
            ports: 8080
        initialDelaySeconds: 10
        periodSeconds: 5
        failureThreshold: 8
```

## Container Logging

When you have a multi pod deployment and you want to logg, you have to specify from which pod you want to have the logging.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: event-simulator-pod
spec:
    containers:
    - name: event-simulator
      image: kodekloud/event-simulator
    - name: image-processor
      image: some-image-processor
```

Getting the logs from event-simulator by executing `kubectl logs -f event-simulator-pod event-simulator`

## Monitoring and Debugging Applications
