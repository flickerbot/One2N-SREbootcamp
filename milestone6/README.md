# One2N-SREbootcamp

## Milestone6 - Setting Up a Three-Node Kubernetes Cluster with Minikube



Spinning up a three-node Kubernetes cluster using Minikube on our local machine.  

* **Node A**: Will be used by our application
* **Node B**: Will be used for running database services
* **Node C**: Will be used for running dependent services such as observability stack, vault for storing secrets, etc.



## Installation Steps

### 1. Install Minikube

```bash
# Download the latest Minikube binary
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64

# Install Minikube to /usr/local/bin
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
```

### 2. Install kubectl

```bash
# Download the latest kubectl release
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   
# Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

#Test to ensure the version you installed is up-to-date:
kubectl version --client
```

### 3. Create Multi-Node Minikube Cluster

```bash
# Start a 3-node Minikube cluster with the name 'multinode-one2n'
minikube start --nodes 3 -p multinode-one2n

```

### 4. Add Appropriate Node Labels

Label the nodes according to their designated purposes:

```bash
# Label Node A as application node
kubectl label node multinode-one2n type=application

# Label Node B as database node
kubectl label node multinode-one2n-m02 type=database

# Label Node C as dependent services node
kubectl label node multinode-one2n-m03 type=dependent_services
```

### 5. Verify Node Labels

```bash
# View nodes with their labels
kubectl get nodes -L type
```

## Expected Output

After running the verification command, you should see output similar to this:

```
NAME                  STATUS   ROLES           AGE    VERSION        TYPE
multinode-one2n       Ready    control-plane   10m    v1.26.3        application
multinode-one2n-m02   Ready    <none>          9m     v1.26.3        database
multinode-one2n-m03   Ready    <none>          8m     v1.26.3        dependent_services
```

## Validation

To confirm your setup is working correctly:

1. Check that all three nodes are in the Ready state:
   ```bash
   kubectl get nodes
   ```

2. Verify that the labels have been properly applied:
   ```bash
   kubectl get nodes --show-labels
   ```

## Troubleshooting

- If Minikube fails to start, ensure you have virtualization enabled in BIOS
- For resource issues, try increasing the allocated resources:
  ```bash
  minikube start --nodes 3 -p multinode-one2n --memory 2048 --cpus 2
  ```
- If node creation fails, check the Minikube logs:
  ```bash
  minikube logs -p multinode-one2n
 

## References

- [Minikube-Docs](https://minikube.sigs.k8s.io/docs/)
- [Kubernetes Concepts](https://container.training/kube-selfpaced.yml.html)
