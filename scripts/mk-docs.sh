#!/bin/bash

readonly PKG=$1

readonly DOCS=docs
readonly ODOC=$(which odoc)
readonly LIB=$2
readonly SRC=$3
readonly LIB_PATTERN=$4

if [[ ! `opam switch show` == "4.02.3+buckle-master" ]]; then
  echo "To generate the docs, you need to use the BuckleScript version of OCaml."
  echo "Create a new opam switch to use it: opam switch create 4.02.3+buckle-master"
  exit 1
fi

if [[ ! -f ${ODOC} ]]; then
  echo "It seems that odoc is not installed! You can get it by running: opam install odoc"
  exit 1
fi

# Gather the sources to compile .odoc files
readonly CMT_FILES=$(find ${LIB} -name "${LIB_PATTERN}")
readonly MLD_FILES=$(find ${SRC} -name "*.mld")

echo "info: 📚 Compiling documentation for package: ${PKG}"
echo "info: Looking for files matching ${LIB_PATTERN} in ${LIB}"
echo "info: Looking for files matching *.mld in ${SRC}"

echo "<< Compiling module docs..."
for file in ${CMT_FILES}; do
  ${ODOC} compile \
    -I ${LIB} \
    --pkg=${PKG} \
    ${file}
done
echo ">> Done!"

echo "<< Compiling page docs..."
for file in ${MLD_FILES}; do
  odoc_file=$( echo $(basename ${file}) | sed "s/mld/odoc/" | sed "s/^/page-/" )
  ${ODOC} compile \
    -I ${LIB} \
    --pkg=${PKG} \
    -o ${LIB}/${odoc_file} \
    ${file}
done
echo ">> Done!"

# Now we can look for the compiled .odoc files
readonly ODOC_FILES=$(find ${LIB} -name "*.odoc")

echo "<< Generating HTML..."
for file in ${ODOC_FILES}; do
  ${ODOC} html \
    -I ${LIB} \
    -o ${DOCS} \
    --syntax=re \
    --semantic-uris \
    ${file}
done
echo ">> Done!"
