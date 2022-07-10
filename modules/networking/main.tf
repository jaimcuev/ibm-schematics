data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

resource "ibm_is_vpc" "vpc_vm" {
  name = "vpc-${var.project}-${var.environment}-001"
  resource_group = data.ibm_resource_group.resource_group.id
}

resource "ibm_is_public_gateway" "vpc_gateway" {
  count = length(var.zones)
  name = "gateway-${var.project}-${var.environment}-${format("%03s", count.index + 1)}"
  vpc  = ibm_is_vpc.vpc_vm.id
  zone = element(var.zones, count.index)
  resource_group = data.ibm_resource_group.resource_group.id
}