output "id" {
  description = "The ID of the registry module."
  value       = tfe_registry_module.this.id
}

output "module_provider" {
  description = "The Terraform provider that this module is used for."
  value       = tfe_registry_module.this.module_provider
}

output "name" {
  description = "The name of registry module."
  value       = tfe_registry_module.this.name
}

output "organization" {
  description = "The name of the organization associated with the registry module."
  value       = tfe_registry_module.this.organization
}

output "namespace" {
  description = "The namespace of the module. For private modules this is the name of the organization that owns the module."
  value       = tfe_registry_module.this.namespace
}

output "registry_name" {
  description = "The registry name of the registry module depicting whether the registry module is private or public."
  value       = tfe_registry_module.this.registry_name
}

output "registry_module" {
  description = "Terraform Cloud's private module registry resource."
  value       = tfe_registry_module.this
}