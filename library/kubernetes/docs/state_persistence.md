# State Persistence

Example of a volume

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: random-number-generator
spec:
    containers:
    - image: alpine
      name: alpine
      command: ["/bin/sh","-c"]
      args: ["shuf -i o-100 -n >> /opt/number.out;"]
      volumeMounts:
      - mountPath: /opt
        name: data-volume


    volumes:
    - name: data-volume
      hostPath:
        path: /data
        type: Directory
```

Example of using a pvc with volumes

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: random-number-generator
spec:
    containers:
    - image: alpine
      name: alpine
      command: ["/bin/sh","-c"]
      args: ["shuf -i o-100 -n >> /opt/number.out;"]
      volumeMounts:
      - mountPath: "/var/www/html"
        name: data-volume

    volumes:
    - name: data-volume
      persistentVolumeClaim:
        claimName: myClaim

```

Example of Persistent Volume:

```yaml
apiVersion: v1
kind: PersistentVolume
metadat:
    name: pv-voll
spec:
    accessModes:
        - ReadWriteOnce
    capacity:
        storage: 1Gi
    hostPath:
        path: /tmp/data
```

Example of Persistent Volume Claim:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
    name: myclaim
spec:
    accessModes:
        - ReadWriteOnce
    resources:
        requests:
            storage: 500Mi

```

## Storage Classes

Example of a Storage Class configuration

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
reclaimPolicy: Retain
allowVolumeExpansion: true
mountOptions:
  - debug
volumeBindingMode: Immediate
```
