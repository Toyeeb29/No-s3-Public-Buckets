package s3policy

# This line is mandatory for OPA 1.0+ / Conftest 0.60+
import rego.v1

deny contains msg if {
    input.public == true
    msg := "Bucket should not be public"
}
