module "cp4s-namespace" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-namespace?ref=v1.12.1"

  argocd_namespace = var.cp4s-namespace_argocd_namespace
  ci = var.cp4s-namespace_ci
  create_operator_group = var.cp4s-namespace_create_operator_group
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  name = var.cp4s-namespace_name
  server_name = module.gitops_repo.server_name
}
module "gitops_repo" {
  source = "github.com/cloud-native-toolkit/terraform-tools-gitops?ref=v1.21.0"

  branch = var.gitops_repo_branch
  debug = var.debug
  gitea_host = var.gitops_repo_gitea_host
  gitea_org = var.gitops_repo_gitea_org
  gitea_token = var.gitops_repo_gitea_token
  gitea_username = var.gitops_repo_gitea_username
  gitops_namespace = var.gitops_repo_gitops_namespace
  host = var.gitops_repo_host
  org = var.gitops_repo_org
  project = var.gitops_repo_project
  public = var.gitops_repo_public
  repo = var.gitops_repo_repo
  sealed_secrets_cert = var.gitops_repo_sealed_secrets_cert
  server_name = var.gitops_repo_server_name
  strict = var.gitops_repo_strict
  token = var.gitops_repo_token
  type = var.gitops_repo_type
  username = var.gitops_repo_username
}
module "gitops-cp-catalogs" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs?ref=v1.2.4"

  entitlement_key = var.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  namespace = var.gitops-cp-catalogs_namespace
  server_name = module.gitops_repo.server_name
}
module "gitops-cp4s" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp4s?ref=v1.1.1"

  admin_user = var.gitops-cp4s_admin_user
  backup_storage_class = var.rwo_storage_class
  backup_storage_size = var.gitops-cp4s_backup_storage_size
  catalog = module.gitops-cp-catalogs.catalog_ibmoperators
  catalog_namespace = var.gitops-cp4s_catalog_namespace
  channel = var.gitops-cp4s_channel
  domain = var.gitops-cp4s_domain
  entitlement_key = module.gitops-cp-catalogs.entitlement_key
  git_credentials = module.gitops_repo.git_credentials
  gitops_config = module.gitops_repo.gitops_config
  kubeseal_cert = module.gitops_repo.sealed_secrets_cert
  namespace = module.cp4s-namespace.name
  roks_auth = var.gitops-cp4s_roks_auth
  server_name = module.gitops_repo.server_name
  storage_class = var.rwo_storage_class
}
