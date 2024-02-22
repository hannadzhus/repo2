variable "ami" {
  type = map(string)
  default = {
    us-east-1 = "ami-0e731c8a588258d0d"
    us-east-2 = "ami-0c20d88b0021158c6"
  
  }
}

variable "PRIVATE_KEY" {
  default = "mykey"
}

variable "PUBLIC_KEY" {
  default = "mykey.pub"
}

variable region {
  type        = string
  default     = "us-east-1"
  description = "aws env region"
}

variable instance_type {
  type        = string
  default     = "t2.micro"
  description = "default instance type"
}

variable desired_capacity {
  type        = number
    default     = "1"
  description = "desired capacity of ASG"
}

variable max_size {
  type        = number
  default     = "5"
  description = "max size for ASG"
}

variable min_size {
  type        = number
  default     = "1"
  description = "min size for ASG"
}


variable sg_name {
  type        = string
  default     = "as-name"
  description = "defualt sg name"
}

