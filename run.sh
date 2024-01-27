for param in ${PARAMETERS}; do
  # Splitting parameter into SHELL_VAR and PARAM using cut for simplicity
  SHELL_VAR=$(echo "$param" | cut -d ',' -f1)
  PARAM=$(echo "$param" | cut -d ',' -f2)

  # Using AWS CLI to get the parameter value with error checking
  if PASS=$(aws ssm get-parameter --name "$PARAM" --with-decryption --query "Parameter.Value" --output text 2>/dev/null); then
    echo "export $SHELL_VAR='$PASS'" >> /data/params
  else
    echo "Error retrieving parameter: $PARAM"
    # Consider whether to exit the script or continue based on your use case
    # exit 1
  fi
done

# Optional: Check the content of /data/params for debugging
cat /data/params
