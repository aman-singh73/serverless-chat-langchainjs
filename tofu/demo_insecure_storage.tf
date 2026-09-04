# Infriqa IaC demo — intentional insecure storage (safe to delete after test).
# Expected Auto-Heal: CODE FIX / Create fix PR against this .tf file
# (set allow_blob_public_access = false, min_tls_version = TLS1_2).

resource "azurerm_storage_account" "infriqa_demo_insecure" {
  name                     = "infriqademoinsecure"
  resource_group_name      = "rg-infriqa-demo"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # RISK: public blob access enabled
  allow_blob_public_access = true

  # RISK: weak TLS
  min_tls_version = "TLS1_0"

  # RISK: HTTPS not forced
  enable_https_traffic_only = false

  tags = {
    purpose = "infriqa-iac-demo"
    delete  = "after-test"
  }
}
