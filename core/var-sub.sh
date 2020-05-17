echo "variable substitution - START"

suffix="$env_config_suffix"
targetFile="$env_config_file_relative_path"

for env_var in $(env)
do
  env_var_suffix=$( echo "$env_var" | cut -d_ -f1) # get the text before the first '_'
  env_var_suffix="${env_var_suffix}_" # add in the '_' suffix
  if [ "$env_var_suffix" = "$suffix" ] # test if the variable matches what to look for $suffix
  then
    echo "valid $suffix variable: $env_var" 
    kv=$(echo "$env_var" | sed "s/$suffix//") #replace the suffix so we get the key and the value
    k=$(echo "$kv" | cut -d= -f1 | tr _ .) # get the key and replacing '_' with '.'
    v=$(echo "$kv" | cut -d= -f2) # get the value
    nv=$(echo "$k=$v") #join the new key value
    lineInFile=$(grep -m 1 "$k"= "$targetFile") # check if the line exists in the targetfile
    if [ -z "$lineInFile" ]
    then
      echo "No line in target file for: $k. Will append to file"
      echo "$nv" >> "$targetFile" # append
    else
      echo "Found line in target file. will substitute"
      sed -i "s|$lineInFile|$nv|" "$targetFile" # replace
    fi
  fi
done

echo "variable substitution - END"
