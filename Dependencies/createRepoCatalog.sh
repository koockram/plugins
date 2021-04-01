REPO=$1
if [[ ! -d "$REPO" ]]; then
    echo "createRepoCatalog.sh <REPO DIR>"
    exit 255
fi

rm ${REPO}.txt ${REPO}.catalog 2>/dev/null
cd ${REPO}/
if [[ -d jcenter-cache ]]; then
    find jcenter-cache > ../${REPO}.txt
fi
if [[ -d gradle-plugins-cache ]]; then
    find gradle-plugins-cache >> ../${REPO}.txt 
fi
if [[ -d confluent-cache ]]; then
    find confluent-cache >> ../${REPO}.txt 
fi
cd ..
sort ${REPO}.txt > deps_catalog_${REPO}.txt
rm ${REPO}.txt
echo "Created deps_catalog_${REPO}.txt"
