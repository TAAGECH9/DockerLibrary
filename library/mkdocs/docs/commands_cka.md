# Commands

This is just a dump of all the commands I found during the course. Refinement will be done later.

```sh
kubectl get pods -n kube-system

kubectl get replica-set

kubectl config set-context $(kubectl config current-context) --namespace=dev
kubectl scale deployment nginx --replicas==4

kubectl get pods --selector app=App1
kubectl taint nodes node-name key=value:taint-effect
kubectl label nodes <node-name> <label-key>=<label-value>
kubectl top node
kubectl logs -f event-simulator-pod
kubectl logs -f event-simulator-pod event-simulator # Do this when you have multiple containers in the pod
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1
kubectl get replicasets
kubectl rollout undo deployment/myapp-deployment


kube-controller-manager --pod-eviction-timeout=5m0s
kubectl drain node-1
kubectl uncordon node-1
kubectl cordon node-2 # simply marks a node as non schedulbale
kubectl get nodes
kubeadm upgrade plan
kubeadm upgrade apply

kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml # Backing up all configs

etcdctl snapshot save snapshot.db
service kube-apiserver stop
etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd-from-backup

export ETCDCTL_API=3


openssl genrsa -out ca.key 2048 # Generate Keys
openssl req -new -key ca.key -sub "/CN=KUBERNETES-CA" -out c # Certificate Signing Request
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt # Sign Certificcates

openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt

openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout # Shows you the certificate informatinos

journalctl -u etc.service -l # Checking for logs when having issues with certificates

## Using Certificates API

openssl genrsa -out jane.key 2048
openssl req -new -key jane.key -subj "/CN=jane" -out jane.csr
kubectl get csr # shows you all those certificate requests
kubectl certificate approve jane
kubectl get csr jane -o yaml

kubectl config view
kubectl config view --kubeconfig=my-custom-config

kubectl config use-context prod-user@production
kubectl config -h

curl https://kube-master:6443/version
curl https://kube-master:6443/api/v1/pods
curl http://localhost:6443 -k

kubectl get roles
kubectl get rolebindings
kubectl describe role developer
kubectl describe rolebinding devuser-developer-binding
kubectl auth can-i create deployments # Check if you have permission to do a certain action
kubectl auth can-i delete nodes
kubectl atuh can-i create deployments --as dev-user

kubectl api-resources --namespaced=false #Shows you list of elements that are not namespaced
kubectl api-resources --namespaced=true

kubectl create serviceaccount dashboard-sa
kubectl get serviceaccount
curl https://19.168.56.70:6443/api -insecure --header "Authorization: Bearar ej..."

docker login private-registry.io
docker run private-registry.io/apps/internal-app
kubectl create secret docker-registry regcred \
    --docker-server= \
    --docker-username = \
    --docker-password = \
    --docker-email=


## Networking
ip link # Shows network interfaces
ip addr 192.168.1.10/24 dev eth0
ping 192.168.1.11
route # shows you the routig table
ip route add 192.168.2.0/24 via 192.168.1.1 # Add entry to the route table
ip route add default via 192.168.2.1 # Set a default gateway
cat /proc/sys/net/ipv4/ip_forward # File contains 0 or 1. If 1 Packet forwarding is allowed if this pc is used as a proxy
cat /etc/sysctl.conf # This file would need to be changed to persist the change of packet forwarding

## DNS in Linux
cat >> /etc/hosts  # You have to write to this hosts file to enable dns
cat /etc/resolv.conf # This file directs to the dns server
cat /etc/nsswitch.conf # Defines order of the name resolution options
nslookup www.google.ch # Use this to check if dns resolution is working or not
dig www.google.ch

## Processes
ps aux

## Network namespaces
ip netns add red
ip netns
ip link
ip netns exec red ip link
arp
ip link add veth-red type veth peer name veth-blue
ip link set veth-red netns red
ip link set veth-blue netns blue

### Deleting a link cable
ip -n red link del veth-red

### Creating a bridge network
ip link add v-net-0 type bridge
ip link set dev v-net-0 up

### Connecting to the bridge network
ip link add veth-red type veth peer name veth-red-br

```
