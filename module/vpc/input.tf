variable "vpc_cidr" {
  description = "vpc의 ipv4 cidr 값을 입력합니다."
  type        = string
  #   default     = "172.16.0.0/16"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.vpc_cidr))
    error_message = "유효하지 않는 cidr 값입니다."
  }


}
variable "vpc_name" {
  description = "vpc 이름입니다."
  type        = string
}

variable "public_subnet1_cidr" {
  description = "퍼블릭 서브넷1 의 cidr입니다."
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.public_subnet1_cidr))
    error_message = "유효하지 않는 cidr 값입니다."
  }
}
variable "public_subnet2_cidr" {
  description = "퍼블릭 서브넷2 의 cidr입니다."
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.public_subnet2_cidr))
    error_message = "유효하지 않는 cidr 값입니다."
  }
}
variable "private_subnet1_cidr" {
  description = "프라이빗 서브넷1 의 cidr입니다."
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.private_subnet1_cidr))
    error_message = "유효하지 않는 cidr 값입니다."
  }
}
variable "private_subnet2_cidr" {
  description = "프라이빗 서브넷2 의 cidr입니다."
  type        = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/([0-9]|[1-2][0-9]|3[0-2]))?$", var.private_subnet2_cidr))
    error_message = "유효하지 않는 cidr 값입니다."
  }
}

variable "use_nat_gateway" {
  description = "nat게이트웨이를 붙이는지 물어봅니다."
  type = bool
}
