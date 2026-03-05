variable "bucket" {
  description = "An object containing the bucket configuration"
  type = object({
    bucket_name = string
    tags        = map(string)
  })
}