api_addr                = "https://127.0.0.1:8200"
cluster_addr            = "https://127.0.0.1:8201"
cluster_name            = "learn-vault-cluster"
disable_mlock           = true
ui                      = true

listener "tcp" {
address       = "127.0.0.1:8200"
tls_cert_file = "/opt/vault/vault-cert.pem"
tls_key_file  = "/opt/vault/vault-key.pem"
}

backend "raft" {
path    = "/opt/vault/vault-data"
node_id = "learn-vault-server"
}
