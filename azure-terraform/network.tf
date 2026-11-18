# 2. VNet (10.0.0.0/16)
resource "azurerm_virtual_network" "vnet" {
  name = "vnet_${var.project_suffix}"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 3. Subnet (10.0.0.0/24) & NSG
resource "azurerm_subnet" "subnet" {
  name = "subnet_${var.project_suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.0.0/24"]
}

# 4. NAT Gateway
resource "azurerm_public_ip" "nat_pip" {
  name = "pip-natgw"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_nat_gateway" "nat_gw" {
  name = "nat-gw"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_assoc" {
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
  public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "nat_subnet_assoc" {
  subnet_id = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
