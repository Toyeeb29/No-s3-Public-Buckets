package s3policy

import rego.v1

deny contains msg if {
    input.public == true
    msg := "Bucket should not be public"
}
