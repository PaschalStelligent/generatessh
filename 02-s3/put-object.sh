for filepath in $( ls . ); do aws s3api put-object --bucket stelligent-u-paschal.onor.labs --key private/$filepath --server-side-encryption AES256 --body ./$filepath;done

