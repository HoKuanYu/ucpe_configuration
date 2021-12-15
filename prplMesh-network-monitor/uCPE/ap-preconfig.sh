# put this file in prplMesh/build

# replace the correct agent mac addr
declare -a arr=("b2:83:c4:0d:f0:28" "B2:83:C4:0D:F2:24" "B2:83:C4:0D:F1:C2" "b2:83:c4:0d:EF:DE")

for i in "${arr[@]}"
do
   echo "bml_set_wifi_credentials $i prplmesh" | $INSTALL_DIR/bin/beerocks_cli
done
