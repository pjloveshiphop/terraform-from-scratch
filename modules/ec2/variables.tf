variable key_config {
    type = list(object({
        key_nm = string
        public_key_path = string
    }))
    description = "list of ec2 key configs"
}
