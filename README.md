# AWS ACM module

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain | The main domain of the environment. The api and api-internal subdomains will be registered as subdomains of this domain. | string | n/a | yes |
| environment | Environment of the project. Also used as a prefix in names of related resources. | string | n/a | yes |
| project | Project of the project. Also used as a prefix in names of related resources. | string | n/a | yes |
| r53\_hosted\_zone\_id | The zone_id of the hosted zone where the DNS record for validation needs to be added | string | `"null"` | no |
| tags | A mapping of tags to assign to all resources | map(string) | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_arn | The ARN of the certificate |
| certificate\_arn\_regional | The ARN of the regional certificate |
| certificate\_domain\_validation\_options | Validation options for the certificate |
| certificate\_regional\_validation\_options | Validation options for the regional certificate |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
