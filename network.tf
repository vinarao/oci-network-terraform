// Copyright (c) 2018, 2019, Oracle and/or its affiliates. All rights reserved.

/* Network */

resource "oci_core_vcn" "vcn1" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name   = "vcn"
  dns_label      = "vcn"
}


resource "oci_core_subnet" "public_subnet1" {
  depends_on = ["oci_core_security_list.public-securitylist"]
  cidr_block        = "10.1.20.0/24"
  display_name      = "public_subnet1"
  dns_label         = "publicsubnet1"
  security_list_ids = ["${oci_core_security_list.public-securitylist.id}"]
  compartment_id    = "${var.compartment_ocid}"
  vcn_id            = "${oci_core_vcn.vcn1.id}"
  route_table_id    = "${oci_core_route_table.public_routetable1.id}"
  dhcp_options_id   = "${oci_core_vcn.vcn1.default_dhcp_options_id}"
}

resource "oci_core_subnet" "private_subnet1" {
  depends_on = ["oci_core_security_list.public-securitylist"]
  cidr_block        = "10.1.22.0/24"
  display_name      = "private_subnet1"
  dns_label         = "privatesubnet1"
  security_list_ids = ["${oci_core_security_list.private-securitylist.id}"]
  compartment_id    = "${var.compartment_ocid}"
  vcn_id            = "${oci_core_vcn.vcn1.id}"
  route_table_id    = "${oci_core_route_table.private_routetable1.id}"
  dhcp_options_id   = "${oci_core_vcn.vcn1.default_dhcp_options_id}"
}


resource "oci_core_internet_gateway" "internetgateway1" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "internetgateway1"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
}

resource "oci_core_nat_gateway" "natgateway1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "natgateway1"
}

resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = "${var.compartment_ocid}"

  services {
    service_id = "${lookup(data.oci_core_services.test_services.services[1], "id")}"
  }

  vcn_id = "${oci_core_vcn.vcn1.id}"
   route_table_id    = "${oci_core_route_table.sgw-route-table.id}"
}

resource "oci_core_drg" "drg" {
    compartment_id = "${var.compartment_ocid}"
    display_name   = "DRG1" 
}
resource "oci_core_drg_attachment" "drg_attachment" {
    drg_id = "${oci_core_drg.drg.id}"
    vcn_id = "${oci_core_vcn.vcn1.id}"
    display_name = "DRG1"
    route_table_id = "${oci_core_route_table.drg-route-table.id}"
}
resource "oci_core_route_table" "public_routetable1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "public_routetable1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.internetgateway1.id}"
  }
}

resource "oci_core_route_table" "private_routetable1" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "private_routetable1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_nat_gateway.natgateway1.id}"

  }
  route_rules {
    destination       = "${lookup(data.oci_core_services.test_services.services[1], "cidr_block")}"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = "${oci_core_service_gateway.service_gateway.id}"
  }
}

resource "oci_core_route_table" "sgw-route-table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "sgw-routetable"

  route_rules {
    destination       = "${var.customer_network}"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_drg.drg.id}"
  }
}
resource "oci_core_route_table" "drg-route-table" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_vcn.vcn1.id}"
  display_name   = "drg-routetable"
  route_rules {
    destination       = "${lookup(data.oci_core_services.test_services.services[1], "cidr_block")}"
    destination_type  = "SERVICE_CIDR_BLOCK"
    network_entity_id = "${oci_core_service_gateway.service_gateway.id}"
  }
}
