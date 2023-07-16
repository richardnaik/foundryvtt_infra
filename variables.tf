variable "project" {
  type = string
}

variable "public_ip" {
  type = string
  description = "IP to access instance over the internet"
}

variable "public_key" {
  type = string
  description = "public ssh key to add suring instance creation"
}

variable "private_key" {
  type = string
  description = "private ssh key for ansible to use"
}

variable "download_url" {
  type = string
  description = "temp url to get the foundry zip from, has to be generated on the website"
}