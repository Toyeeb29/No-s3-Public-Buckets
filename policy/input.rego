package s3policy

deny contains msg if {
    input.public == true
    msg := "Bucket should not be public"
}
