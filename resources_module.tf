# The following code block is used to create module resources in the private registry.

module "modules" {
  source = "./modules/module"

  for_each = local.modules

  module_provider = try(each.value.module_provider, null)
  name            = try(each.value.name, null)
  organization    = try(each.value.organization, null)
  namespace       = try(each.value.namespace, null)
  registry_name   = try(each.value.registry_name, null)
  vcs_repo        = try(each.value.vcs_repo, null)

}
