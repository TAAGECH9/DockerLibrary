# Kubectl

## Life Savers

```sh
kubectl explain <whatever you want> # Provides you the required documentation
kubectl api-resources # lists all the possible resources including the abbreviated version
kubectl get pod --show-labels # Shows you the labels related to a pod resource
kubectl get pod -l type=runner # Filter for all the pods labeled with type=runner
kubectl label pod -l type=worker protected=true  # Set label protected=true for all pods with the label type=worker
kubectl annotate pod -l protected=true protected="do not delete this pod" # annotate all the pods with the label protected=true with protected="do not delete this pod"
```

## Grep

```sh
# Case insensitive grep
grep -i

# Show next 10 lines after match
grep -A 10

# Show 10 lines before the match
grep -B 10
```

## Pods

```sh
# Downloads nginx from dockerhub and run the container
kubectl run nginx --image=nginx
kubectl run nginx --image=nginx

# Shows you the current pods
kubectl get pods

# Count amount of pods
kubectl get pods --no-headers | wc -l

# Create a new pod based on a yaml file
kubectl create -f pod-definition.yml

# describes the mentioned pod; you can filter for interesting elemnts like state, image, eventsection for errors etc...
kubectl describe pod <pod-name>

# get further infos about the pod
kubectl pods -o wide

# Delete Stuff
kubectl delete pod webapp

# Create a dryrun of the pod
kubectl run nginx --image=nginx --dry-run=client -o yaml > pod.yaml

# Apply a manifest
kubectl apply -f pod.yaml

# Edit running configuration
kubectl edit pod <podname>
```


## Logs

```sh
# Exec into the pod app in the namespace elastic-stack
kubectl -n elastic-stack exec -it app -- cat /log/app.log


```

## Config Maps

```sh
# Config maps - Imperative approach
kubectl create configmap
kubectl create configmap \
    app-config --from-literal=APP_COLOR=blue
               --from-literal=APP_MODE=prod
kubectl create configmap <config-name> --from-file=<path-to-file>

# Config maps - Declarative approach
kubectl create -f

# ConfigMaps
kubectl get configmaps
kubectl describe configmaps
```

## Secrets

```sh
# Secrets - Imperative declaration
kubectl create secret generic <secret-name> --from-literal=<key>=<value>
kubectl create secret generic <secret-name> --from-file=<path-to-file>

# Secrets - Declarative
kubectl create -f

# "Encoding": plain -> b64
echo -n 'psssst007-secret' | base64

# "Decode"
echo -n 'bXlzcWw=' | base64 --decode

# Get secrets
kubectl get secrets
kubectl describe secrets

# Get the secrets aswell -> Shows you hash values
kubectl get secret app-secret -o yaml
```

## SSH into pods

```sh
ssh podname
```

## Service accounts

```sh
# Create a service account
kubectl create serviceaccount dashboard-sa
kubectl get serviceaccount
kubectl describe serviceaccount dashboard-sa # Token is stored for the service account in a secret object

# Get service account secret by
kubectl describe secret dashboard-sa-token-kbbdm

# Using Service account token as a bearer token to make request to kubernetes api
curl https://192.168.56.70:6443/api -insecure --header "Authorization: Bearer eyJhbG..."

# Get endpoints
kubectl get endpoints # This object will basically track which pods are endpoints of the current service, is dynamically updated
```

## Replicasets

```sh
# Get replica sets
kubectl get replicasets

# Replacing a Replica set
kubectl replace -f replicaset-definition.yml

# Use scale to update replica set
kubectl scale --replicas=6 -f replicaset-definition.yml
kubectl scale --replicas=6 replicaset myapp-replicaset # Here syntax "type" "name" is used
```

## Deployments

```sh
# Get deployments
kubectl get deployments
kubectl create deployment httpd-frontend --image=httpd:2.4-alpine
kubectl scale deployment --replicas=3 http-frontend

# Create deployment with replicas set
kubectl create deployment blue --image=nginx --replicas=3

# Generate deployment file
kubectl create deployment --image=nginx nginx --dry-run -o yaml

```

## Namespaces

```sh
# List namespaces
kubectl get pods --namespace=kube-system
kubectl create -f pod-definition.yml --namespace=dev

# Get namespaces
kubectl get ns


# Create namespace
kubectl create namespace dev
kubectl create -f namespace-dev.yml

# Switch namespace
kubectl config set-context $(kubectl config current-context) --namespace=dev

# Get pods from all namespaces
kubectl get pods --all-namespaces

# Count the amount of pods in the "research" namespace
kubectl -n research get pods --no-headers

# Hacky stuff for the certification
# --
```

## Nodes

```sh
# Taint a node; possible taint effects are: NoSchedule, PreferNoSchedule, NoExecution
kubectl taint nodes node-name key=value:<taint-effect>

# Untaint a resource. Just add a "Minus" sign at the end
kubectl taint nodes node-name key=value:<taint-effect>-

# Example
kubectl taint nodes node1 app=blue:NoSchedule

# Add tolerations
kubectl taint nodes node1 app=blue:NoSchedule

# Interessting: Check what taint is configured on masternode
kubectl describe node kubemaster | grep Taint

# How to label a node
kubectl label nodes <node-name> <label-key>=<label-value>
```

## Basic Commands

```sh



# Formatting output
# Formats: -o json -> json; -o name -> Only resource names; -o wide -> output in plain text with additional infos; -o yaml -> output yaml formatted api object
kubectl [command][TYPE][NAME] -o <output_format>
kubectl create namespace test-123 --dry-run -o json

dry-run=client => Will not create the resource, instead, tell youweather the resource can be created and if your command is right



# Create service named redis-servicy of type ClusterIp to expose pod redis on port 6379
kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml

# Create a Service named nginx of type NodePort to expose pod nginx port 80 on port 30080 on the nodes
kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -o yaml

# Get performance metrics
kubectl top node
kubectl top pod

# Use Selectors
kubectl get pods --selector app=App1
kubectl get all --selector env=prod,unit=business,color=green  # Just concatenate those elements with a comma

# Get rollout status
kubectl rollout status deployment/myapp-deployment

# Get rollout history
kubectl rollout history deployment/myapp-deployment

# How to update application / trigger new rollout
kubectl apply -f deployment-definition.yml

# Other way; But will have another deploy definition file. Can be used to update the base image
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1

# Undo a deployment
kubectl rollout undo deployment/myapp-deployment

# Get deployments
kubectl get deployments

# Define a "CHANGE-CAUSE" in the revision history
kubectl create -f deployment-definition.yml --record

# Create a new job
kubectl create -f job-definition.yaml

# Get jobs
kubectl get jobs

# Delete job
kubectl delete job math-add-job

# Cron jobs
kubectl create -f cron-job-definition.yaml
kubectl get cronjob

# Services
kubectl get services
kubectl create -f service-definition.yml

# Get answer from your webserver via nodeport
curl http://192.168.1.2:30008


# Working with Ingress
kubectl describe ingress ingress-wear-watch

# Creating ingress imperatively
kubectl create ingress <ingress-name> --rule="host/path=service:port"

# Get persistent volumes
kubectl get persistentvolume

# Show persistent Volume claims
kubectl get persistentvolumeclaim

# Delete pvc
kubectl delete persistentvolumeclaim myclaim

ps aux

```
