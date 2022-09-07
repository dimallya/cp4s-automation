# CP4S Automation for AWS, Azure, and IBM Cloud

### Installing Cloud Pak for Security

The installation process will use a standard GitOps repository that has been built using the Modules to support Cloud Pak for Security (CP4S) installation. The automation is consistent across three cloud environments AWS, Azure, and IBM Cloud.

Steps:

1. First step is to clone the automation code to your local machine. Run this git command in your favorite command line shell.

     ```
     git clone https://github.com/dimallya/cp4s-automation
     ```
2. Navigate into the `cp4s-automation` folder using your command line. This document focuses on installing CP4S in an existing Red Hat OpenShift cluster.
3. Next you will need to set-up your credentials.properties file. This will enable a secure access to your cluster.

    ```
    cp credentials.template credentials.properties
    code credential.properties
    ```

    ```
    ## Add the values for the Credentials to access the OpenShift Environment
    ## Instructions to access this information can be found in the README.MD
    ## This is a template file and the ./launch.sh script looks for a file based on this template named credentials.properties
    
    ## gitops_repo_host: The host for the git repository
    TF_VAR_gitops_repo_host=github.com
    ## gitops_repo_username: The username of the user with access to the repository
    TF_VAR_gitops_repo_username=
    ## gitops_repo_token: The personal access token used to access the repository
    TF_VAR_gitops_repo_token=
    
    ## TF_VAR_server_url: The url for the OpenShift api server
    TF_VAR_server_url=
    ## TF_VAR_cluster_login_token: Token used for authentication to the api server
    TF_VAR_cluster_login_token=

    ```

4. You will need to populate these values. Add your Git Hub username and your Personal Access Token to `repo_username` and `repo_token`
5. From you OpenShift console click on top right menu and select Copy login command and click on Display Token
6. Copy the API Token value into the `login_token` value
7. Copy the Server URL into the `server_url` value, only the part starting with https
8. You need to make sure you are not running Docker Desktop as this is not allowed under their new terms and conditions for corporate use. You need to install **Colima** as an alternative

    ```
    brew install colima
    colima start
    ```

9. We are now ready to start installing CP4S, run the `launch.sh` command, make sure you are in the root of the cp4s-automation repository

   ```
   ./launch.sh
   Cleaning up old container: cli-tools-pb24K
   parsing credentials.properties...
   Initializing container cli-tools-pb24K from quay.io/cloudnativetoolkit/cli-tools:v1.2-v2.2.7
   e2a082b202f93c1832e2c7a7f080251d88caa13814126d4cd6f1c0ab75c9ac2f
   Attaching to running container...
   /terraform $
   ```

10. **launch.sh** will download a container image that contains all the command line tools to enable easy installation of the software. Once it has downloaded, it will mount the local file system and exec into the container for you to start running commands from within this custom container.

> we expect partners and clients will use their own specific **Continuous Integration** tools to support this the IBM team has focused on getting it installed in the least complicated way possible

11. Next step is to create a workspace to run the Terraform automation.
12. Run the command setup-workspace.sh you will need to provide the `-p` platform value which can be `azure` | `aws` or `ibm` then supply a prefix name

```
./setup-workspace.sh -p ibm -n demo
``` 

13. The default `terraform.tfvars` file is symbolically linked to the new `workspaces/current` folder so this enables you to edit the file in your native operating system using your editor of choice.
14. Edit the default `terraform.tfvars` file this will enable you to setup the GitOps parameters.

      ```
    ########################################################
	# Name: CP4S Terraform Variable File
	# Desc: Initial input variables to support installation of CP4S into the cloud provider of your choice
	########################################################

	## gitops-repo_host: The host for the git repository.
	gitops_repo_host="github.com"

	## gitops-repo_type: The type of the hosted git repository (github or gitlab).
	gitops_repo_type="github"

	## gitops-repo_org: The org/group where the git repository exists/will be provisioned.
	## your gitorg - if left blank the value will default to your username
	gitops_repo_org=""

	## gitops-repo_repo: The short name of the repository (i.e. the part after the org/group name)
	gitops_repo_repo="demo-cp4s-gitops"

	## gitops-cluster-config_banner_text: The text that will appear in the top banner in the cluster
	gitops-cluster-config_banner_text="Software Everywhere Cloud Pak for Security"

	## entitlement_key: The entitlement key used to access the CP4S images in the container registry. Visit https://myibm.ibm.com/products-services/containerlibrary to get the key
	entitlement_key=""

	## gitops-cp4s_admin_user: Short name or email-id of the user to be given administrator privileges in the default account. Mandatory value while creating cp4s-threat-management-instance
	gitops-cp4s_admin_user=""

	## The provisioned block or file storage class for all the PVCs required by Cloud Pak for Security.
	rwo_storage_class="ibmc-vpc-block-mzr"

	## The variable which need to be set to true, if ROKS authentication has to be enabled if platform in IBM Cloud.
	gitops-cp4s_roks_auth="false"
      ```

15. You will see that the `repo_type` and `repo_host` are set to GitHub you can change these to other Git Providers, like GitHub Enterprise or GitLab.
16. For the `repo_org` value set it to your default org name, or specific a custom org value. This is the organization where the GitOps Repository will be created in. Click on top right menu and select Your Profile to take you to your default organization.
17. Set the `repo_repo` value to a unique name that you will recognize as the place where the GitOps configuration is going to be placed before CP4S is installed into the cluster.
18. You can change the Banner text to something useful for your client project or demo.
19. Provide variable values for `entitlement_key` and `gitops-cp4s_admin_user` which is required for CP4S installation. You may also set `gitops-cp4s_roks_auth` to true if prefer to enable ROKS authentication while logging in as CP4s admin user on IBM Cloud platform. You may also change `rwo_storage_class` value if willing to use any other supproted storage class which is available on OCP cluster.
20. Save the `terraform.tfvars` file
21. Navigate into the `/workspaces/current` folder
22. Navigate into the `200` folder and run the following commands

      ```
      cd 200-openshift-gitops
      terraform init
      terraform apply --auto-approve
      ………
      Apply complete! Resources: 73 added, 0 changed, 0 destroyed.

      ```

23. This will kick off the automation for setting up the GitOps Operator into your cluster.

24. You can check the progress by looking at two places, first look in your github repository. You will see the git repository has been created based on the name you have provided. The CP4S install will populate this with information to let OpenShift GitOps install the software. The second place is to look at the OpenShift console, Click Workloads->Pods and you will see the GitOps operator being installed.

25. Now that the GitOps is installed in the cluster, and we have bound the git repository to OpenShift GitOps operator. We are now ready to populate this with some Software configuration that cause OpenShift GitOps to install the software into the cluster. Navigate into the `700` folder and run the following commands, this will install CP4S into the cluster.

     ```
     cd 700-cp4s-multicloud
     terraform init
     terraform apply --auto-approve
     ………
     Apply complete! Resources: 44 added, 0 changed, 0 destroyed.
     ```

26. Once the installation has finished you will see a message from Terraform defining the state of the environment.

27. You will see the first change as a purple banner describing what was installed 

28. The next step is to validate if everything has installed correctly. Open your git repository where your git ops configuration was defined.

29. Check if the payload folder has been created with the correct definitions for GitOps. Navigate to the `payload/2-services/namespace/cp4s` folder and look at the content of the installation YAML files. You should see the Operator CR definitions
29. Final Step is to Open up Argo CD (OpenShift GitOps) check it is correctly configured, click on the Application menu 3x3 Icon on the header and select **Cluster Argo CD** menu item.

30. Complete the authorization with OpenShift, and, then narrow the filters by selecting the **cp4s**.

31. This will show you the GitOps dashboard of the software you have installed using GitOps techniques
32. Click on **cp4s-ibm-cp4s-threatmgmt-instance** tile
33. You will see all the microservices that CP4S uses to install with their enablement state
