for param in ${PARAMETERS} ; do
    PASS=${aws ssm describe-parameters --name $param --with-decryption --query "Parameter.Value" --output text}
    echo PASS $param=$PASS >> params
done

cat params