resource "azurerm_cosmosdb_sql_container" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  database_name       = var.database_name
  partition_key_paths = [var.partition_key_path]
  throughput          = var.throughput

  dynamic "autoscale_settings" {
    for_each = var.autoscale_settings != null ? [var.autoscale_settings] : []
    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }

  dynamic "unique_key" {
    for_each = var.unique_key
    content {
      paths = [unique_key.value]
    }
  }

  dynamic "indexing_policy" {
    for_each = var.indexing_policy != null ? [var.indexing_policy] : []
    content {
      indexing_mode = indexing_policy.value.indexing_mode

      dynamic "included_path" {
        for_each = indexing_policy.value.included_paths
        content {
          path = included_path.value
        }
      }

      dynamic "excluded_path" {
        for_each = indexing_policy.value.excluded_paths
        content {
          path = excluded_path.value
        }
      }
    }
  }
}



