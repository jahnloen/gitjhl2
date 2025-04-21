#denne fila brukes i forbindelse med midlertidige variabler 
#eller beregninger som krever input eller bruker andre variabler
#tags
#dynamiske ressurs navn, feks. storage accounts
#forenkling av logikk
#kombinere flere variabler
#environment (miljøvariabler)

locals {

  storage_account_names = ["jhl01", "jhl02", "jhl03"]
  location              = "West Europe"
  #storage_account_names = ["jhl01", "jhl02", "jhl03"]
  #project               = "MyProject"
  #environment           = ["dev", "test", "prod"]
  #environment = var.environment
  #resource_group_names  = [for env in local.environment : "${local.project}-${env}rg"]
  #resource_group_names = "${var.project}-${var.environment}rg"
  #number_of_storage_accounts = var.number_of_storage_accounts
  #storage_account_names = "${var.project}${var.environment}${count.index+1}sa"

  common_tags = {
    company      = var.company
    project      = "${var.project}${var.company}"
    billing_code = var.billing_code
    cost_center  = var.cost_center
    owner        = var.owner
    location     = "West Europe"
    #environment  = var.environment
    #resource_group_names = ["rg-jhl01"]["rg-jhl10"]
    #resource_group_names = ["rg-jhl01", "rg-jhl02", "rg-jhl03"]
    #resource_group_names = [for env in local.environment : "${local.project}-${env}-rg"]
    #storage_account_names = ["jhl01"]["jhl10"]
    #name = 
    #storage_account_names = 
    #name = "${local.project_name}"
    #project = local.project_name
    #environment = "Production"
    #cost center = "IT"
    #owner  = "JHL"
    #is_production = var.environment == "prod"
    #vm_size       = local.is_production ? "standard" : "Standard"
    #name = "LoenIT"
  }

}