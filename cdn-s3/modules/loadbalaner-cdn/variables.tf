variable "static_ip_name" {
  type        = string
  description = "Reserved ip name"

}

variable "static_website_http_proxy_name" {
  type        = string
  description = "name of the static_website_http_proxy_name"

}

variable "static_website_forwarding_rule_name" {
  type        = string
  description = "name of the static_website_forwarding_rule_name"

}

variable "port_range" {
  type        = string
  description = "port_number for http"

}

variable "url_map" {
  type        = string
  description = "url map for accessing through load balancer"

}
