# One2N-SREbootcamp

## Milestone 7: Deploy REST API & its dependent services in Kubernetes

This repository contains Kubernetes manifests for deploying a Student API application along with its dependent services (MySQL database, Vault, and External Secrets Operator) in a Kubernetes cluster.

## Architecture Overview

The deployment follows this architecture:
- Student API Flask application deployed in the `student-apis` namespace
- MySQL database deployed in the `student-apis` namespace
- Hashicorp Vault deployed in the `vault` namespace
- External Secrets Operator (ESO) deployed in the `external-secrets` namespace

## Repository Structure

```
milestone7/
├── manifests/
│   ├── application.yaml     # Student API deployment manifests
│   ├── database.yaml        # MySQL deployment manifests
│   ├── dependent_services.yaml  # ESO configuration
│   ├── vault.yaml           # Vault deployment manifests
├── README.md                #this file 

```


## Prerequisites

- Kubernetes cluster (Minikube with labelled nodes, refer milestone6 for more information)
- kubectl CLI configured to work with your cluster
- Helm (v3+) installed

## Installation Steps

### 1. Clone the Repository

```bash
git clone clone https://github.com/flickerbot/One2N-SREbootcamp.git
cd milestone7
```

### 2. Deploy Vault

```bash
kubectl apply -f manifests/vault.yaml
```

### 4. Initialize and Unseal Vault

After deploying Vault, you need to initialize and unseal it. Run the following commands:


```bash
# Port-forward the Vault service
kubectl port-forward svc/vault -n vault 8200:8200 &

#After port forwarding you can also do it via UI just open http://127.0.0.1:8200 and follow the steps 
#Unseal the vault and note down the key as well as root token 
#From secrets create a secret at path secret/student-api/db
#Add secrtes with these values 
#   MYSQL_ROOT_PASSWORD="rootpassword" 
#   MYSQL_USER="admin" 
#   MYSQL_PASSWORD="password" 
#   DATABASE_URL="mysql+pymysql://admin:password@db:3306/student_db"


# Initialize Vault
export VAULT_ADDR='http://127.0.0.1:8200'
vault operator init -key-shares=1 -key-threshold=1

# Save the unseal key and root token from the output
# Unseal Vault
vault operator unseal <unseal-key>

# Login with the root token
vault login <root-token>
```

### 5. Enable Vault Secret Engine and Create Secrets

```bash
# Enable the KV version 2 secrets engine
vault secrets enable -version=2 -path=secret kv

# Create secrets for the Student API
vault kv put secret/student-api/db \
  MYSQL_ROOT_PASSWORD="rootpassword" \
  MYSQL_USER="admin" \
  MYSQL_PASSWORD="password" \
  DATABASE_URL="mysql+pymysql://admin:password@db:3306/student_db"
```

### 6. Deploy External Secrets Operator with Helm

```bash
# Add the External Secrets Helm repository
helm repo add external-secrets https://charts.external-secrets.io

# Update the repositories
helm repo update

# Install External Secrets Operator
helm install external-secrets \
  external-secrets/external-secrets \
  --namespace external-secrets \
  --create-namespace \
  --set installCRDs=true
```

### 7. Configure External Secrets Operator

Update the token in `dependent_services.yaml` with your Vault root token:

```bash
# Replace <root_token> with your actual Vault root token in the file
# Then apply the configuration
kubectl apply -f manifests/dependent_services.yaml
```

### 8. Deploy Database

```bash
kubectl apply -f manifests/database.yaml
```

### 9. Deploy Application

```bash
kubectl apply -f manifests/application.yaml
```

## How the Secret Management Works

1. **Vault Initialization**: 
   - When Vault is deployed, it starts in a sealed state
   - Admin initializes and unseals Vault, which generates a root token
   - The root token is used to authenticate with Vault

2. **Secret Storage**:
   - Secrets are stored in Vault's KV (Key-Value) v2 engine at path `secret/student-api/db`
   - These secrets include database credentials and connection strings

3. **External Secrets Operator (ESO)**:
   - ESO is deployed using Helm in the `external-secrets` namespace
   - A Kubernetes Secret `vault-token` is created containing the Vault root token

4. **ClusterSecretStore Configuration**:
   - A ClusterSecretStore resource named `vault-backend` is created
   - It configures how ESO should connect to Vault (server URL, auth method, etc.)
   - It references the `vault-token` Secret for authentication

5. **ExternalSecret Resource**:
   - An ExternalSecret resource `student-api-vault-secret` is created in the `student-apis` namespace
   - It defines which secrets to fetch from Vault and how to map them to a Kubernetes Secret

6. **Secret Synchronization**:
   - ESO watches the ExternalSecret resource
   - ESO connects to Vault using the token from `vault-token` Secret
   - ESO fetches the specified secrets from Vault's KV store
   - ESO creates/updates a Kubernetes Secret `student-api-secrets` with the fetched values

7. **Secret Consumption**:
   - The Student API and MySQL deployments reference the `student-api-secrets` Secret
   - Secrets are mounted as environment variables in the containers

## Secret Management Flow

```
┌─────────────────────┐     Initialize     ┌─────────────────────┐
│                     │     & Unseal       │                     │
│   Admin/Developer   ├──────────────────► │    Vault Server     │
│                     │                    │   (vault.yaml)      │
└─────────────────────┘                    └──────────┬──────────┘
                                                      │
                                                      │ Store Secrets
                                                      │ (KV v2 engine)
                                                      ▼
┌─────────────────────┐    Read Vault     ┌─────────────────────┐
│                     │      Token        │ Secret: vault-token │
│  External Secrets   │◄──────────────────┤  (Root Token)       │
│  Operator           │                   │                     │
│                     │                   └─────────────────────┘
└──────────┬──────────┘
           │
           │ Watch
           │                              ┌─────────────────────┐
           ▼                              │                     │
┌─────────────────────┐     Fetch         │    Vault Secret:    │
│  ClusterSecretStore ├──────────────────► secret/student-api/db│
│  (vault-backend)    │     Secrets       │                     │
└──────────┬──────────┘                   └─────────────────────┘
           │
           │ Define
           │ Source
           ▼
┌─────────────────────┐
│   ExternalSecret    │
│ student-api-vault-  │
│ secret              │
└──────────┬──────────┘
           │
           │ Create/Update
           │
           ▼
┌─────────────────────┐     Consume       ┌─────────────────────┐
│  K8s Secret:        │                   │                     │
│  student-api-       ├──────────────────►│ Student API & MySQL │
│  secrets            │     Secrets       │ Deployments         │
└─────────────────────┘                   └─────────────────────┘
```


## Verify Deployment

### Check All Pods are Running

```bash
# Check pods in student-apis namespace
kubectl get pods -n student-apis

# Check pods in vault namespace
kubectl get pods -n vault

# Check pods in external-secrets namespace
kubectl get pods -n external-secrets
```

### Access the Student API

The Student API is exposed via a NodePort service on port 30080:

```bash
# Get the Node IP (if using Minikube)
minikube ip

# Or get any node external IP
kubectl get nodes -o wide

# Access the API
curl http://<node-ip>:30080/api/students
```


## Troubleshooting

### Database Connection Issues

If the application cannot connect to the database:

1. Check if the database pod is running:
   ```bash
   kubectl get pods -n student-apis -l app=mysql
   ```

2. Check the logs of the database pod:
   ```bash
   kubectl logs -n student-apis <mysql-pod-name>
   ```

3. Check the logs of the application pod and init container:
   ```bash
   kubectl logs -n student-apis <student-api-pod-name>
   kubectl logs -n student-apis <student-api-pod-name> -c init-myservice
   ```

### External Secret Issues

If secrets are not being synced from Vault:

1. Check ESO controller logs:
   ```bash
   kubectl logs -n external-secrets -l app.kubernetes.io/name=external-secrets
   ```

2. Check the status of your ExternalSecret:
   ```bash
   kubectl describe externalsecret -n student-apis student-api-vault-secret
   ```

## Cleanup

To remove all deployed resources:

```bash
kubectl delete -f manifests/application.yaml
kubectl delete -f manifests/database.yaml
kubectl delete -f manifests/dependent_services.yaml
kubectl delete -f manifests/vault.yaml
helm uninstall external-secrets -n external-secrets
kubectl delete namespace student-apis vault external-secrets
```

## Further Reading
* [Kubernetes Services](https://kubernetes.io/docs/concepts/services-networking/service/)
* [External Secrets Operator](https://external-secrets.io/latest/)
* [Hashicorp Vault](https://www.vaultproject.io/docs)