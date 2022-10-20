# Pod Design

## Labels, Selectors and Annotations

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: simple-webapp
    labels:
        app: App1
        function: Front-end
spec:
    containers:
    - name: simple-webapp
      image: simple-webapp
      ports:
        - containerPort: 8080
```

Annotations are used to add other details for informationaly purpose.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: simple-webapp
    labels:
        app: App1
        function: Front-end
    annotations:
        buildversion: 1.24
        email: my.email@web.com
spec:
    containers:
    - name: simple-webapp
      image: simple-webapp
      ports:
        - containerPort: 8080
```

## Deployments: Updates and Rollback

## Jobs

In comparison to all the other type of applications we had before a job is something, that is not running continuously.
Example in docker would be `docker run ubuntu expr 3 + 2`. The container would just compute the sum and then just die.

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: math-pod
spec:
    containers:
    - name: math-add
      image: ubuntu
      command: ['expr','3','+','2']
    restartPolicy: Never
```

By configuring `restartPolicy: Never` you can easily create a pod, that can just die.
Job definition file is organized as the following.

```yaml
apiVersion: batch/v1
kind: Job
metadata:
    name: math-add-job
spec:
    template:
        spec:
            containers:
            - name: math-add
              image: ubuntu
              command: ['expr','3','+','2']
            restartPolicy: Never
```

When you work with multiple jobs you can do it as following (sequential):

```yaml
apiVersion: batch/v1
kind: Job
metadata:
    name: math-add-job
spec:
    completions: 3
    template:
        spec:
            containers:
            - name: math-add
              image: ubuntu
              command: ['expr','3','+','2']
            restartPolicy: Never
```

If you want to add parallelism, you can do the following;

```yaml
apiVersion: batch/v1
kind: Job
metadata:
    name: math-add-job
spec:
    completions: 3
    parallelism: 3
    template:
        spec:
            containers:
            - name: math-add
              image: ubuntu
              command: ['expr','3','+','2']
            restartPolicy: Never
```

## Cron Jobs

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
    name: reporting-cron-job
spec:
    schedule: "*/1 * * * *"
    jobTemplate:
        spec:
            completions: 3
            parallelism: 3
            template:
                spec:
                    containers:
                    - name: math-add
                    image: ubuntu
                    command: ['expr','3','+','2']
                    restartPolicy: Never



```
