# Default example

Deploys the environment with a jumpbox to enable access to environment. The username is `azureuser` and the password is generated and can be found in the tfstate file or it can be reset from the portal. 

An easy way to get a list of available VM sizes in a specific region and availability zone:

```sh
# The following is a simple command will list Standard_D VM sizes and have no restrictions in southcentralus region
az vm list-skus -l southcentralus --size Standard_D -o table | grep None
```
