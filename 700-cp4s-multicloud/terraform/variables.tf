variable "gitops-cp-catalogs_namespace" {
  type = string
  description = "The namespace where the application should be deployed"
  default = "openshift-marketplace"
}
variable "entitlement_key" {
  type = string
  description = "The entitlement key used to access the CP4I images in the container registry. Visit https://myibm.ibm.com/products-services/containerlibrary to get the key"
}
variable "gitops-cp4s_channel" {
  type = string
  description = "The version of channel"
  default = "v1.9"
}
variable "rwo_storage_class" {
  type = string
  description = "The provisioned block or file storage class for all the PVCs required by Cloud Pak for Security. When it is not specified, the default storage class is used."
  default = ""
}
variable "gitops-cp4s_roks_auth" {
  type = string
  description = "Whether ROKS authentication need to be enabled"
  default = "false"
}
variable "gitops-cp4s_admin_user" {
  type = string
  description = "Short name or email-id of the user to be given administrator privileges in the default account. Mandatory value while creating cp4s-threat-management-instance"
}
variable "gitops-cp4s_catalog_namespace" {
  type = string
  description = "The namespace where the catalog has been deployed"
  default = "openshift-marketplace"
}
variable "gitops-cp4s_backup_storage_size" {
  type = string
  description = "The storage size for the backup and restore PVC. Must be 500Gi or higher. If not specified, by default 500Gi is reserved."
  default = ""
}
variable "gitops-cp4s_domain" {
  type = string
  description = "The fully qualified domain name (FQDN) created for Cloud Pak for Security. If you don't specify an FQDN, it is generated as cp4s.<cluster_ingress_subdomain>."
  default = ""
}
variable "cp4s-namespace_name" {
  type = string
  description = "The value that should be used for the namespace"
  default = "cp4s"
}
variable "cp4s-namespace_ci" {
  type = bool
  description = "Flag indicating that this namespace will be used for development (e.g. configmaps and secrets)"
  default = false
}
variable "cp4s-namespace_create_operator_group" {
  type = bool
  description = "Flag indicating that an operator group should be created in the namespace"
  default = true
}
variable "cp4s-namespace_argocd_namespace" {
  type = string
  description = "The namespace where argocd has been deployed"
  default = "openshift-gitops"
}
variable "gitops_repo_host" {
  type = string
  description = "The host for the git repository. The git host used can be a GitHub, GitHub Enterprise, Gitlab, Bitbucket, Gitea or Azure DevOps server. If the host is null assumes in-cluster Gitea instance will be used."
  default = ""
}
variable "gitops_repo_type" {
  type = string
  description = "[Deprecated] The type of the hosted git repository."
  default = ""
}
variable "gitops_repo_org" {
  type = string
  description = "The org/group where the git repository exists/will be provisioned. If the value is left blank then the username org will be used."
  default = ""
}
variable "gitops_repo_project" {
  type = string
  description = "The project that will be used for the git repo. (Primarily used for Azure DevOps repos)"
  default = ""
}
variable "gitops_repo_username" {
  type = string
  description = "The username of the user with access to the repository"
  default = ""
}
variable "gitops_repo_token" {
  type = string
  description = "The personal access token used to access the repository"
  default = ""
}
variable "gitops_repo_gitea_host" {
  type = string
  description = "The host for the default gitea repository."
  default = ""
}
variable "gitops_repo_gitea_org" {
  type = string
  description = "The org/group for the default gitea repository. If not provided, the value will default to the username org"
  default = ""
}
variable "gitops_repo_gitea_username" {
  type = string
  description = "The username of the default gitea repository"
  default = ""
}
variable "gitops_repo_gitea_token" {
  type = string
  description = "The personal access token used to access the repository"
  default = ""
}
variable "gitops_repo_repo" {
  type = string
  description = "The short name of the repository (i.e. the part after the org/group name)"
}
variable "gitops_repo_branch" {
  type = string
  description = "The name of the branch that will be used. If the repo already exists (provision=false) then it is assumed this branch already exists as well"
  default = "main"
}
variable "gitops_repo_public" {
  type = bool
  description = "Flag indicating that the repo should be public or private"
  default = false
}
variable "gitops_repo_gitops_namespace" {
  type = string
  description = "The namespace where ArgoCD is running in the cluster"
  default = "openshift-gitops"
}
variable "gitops_repo_server_name" {
  type = string
  description = "The name of the cluster that will be configured via gitops. This is used to separate the config by cluster"
  default = "default"
}
variable "gitops_repo_sealed_secrets_cert" {
  type = string
  description = "The certificate/public key used to encrypt the sealed secrets"
  default = ""
}
variable "gitops_repo_strict" {
  type = bool
  description = "Flag indicating that an error should be thrown if the repo already exists"
  default = false
}
variable "debug" {
  type = bool
  description = "Flag indicating that debug loggging should be enabled"
  default = false
}
variable "util-clis_bin_dir" {
  type = string
  description = "The directory where the clis should be downloaded. If not provided will default to ./bin"
  default = ""
}
variable "util-clis_clis" {
  type = string
  description = "The list of clis that should be made available in the bin directory. Supported values are yq, jq, igc, helm, argocd, rosa, gh, glab, and kubeseal. (If not provided the list will default to yq, jq, and igc)"
  default = "[\"yq\",\"jq\",\"igc\"]"
}
