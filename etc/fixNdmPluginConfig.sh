rm -rfv ./src/process_extractleds
rm -rfv ./src/process_ncs2dat
rm -rfv ./src/process_nvt2spots


echo 'removing -fpascal-string option'
for file in $(grep -rl '\-fpascal\-strings'  ./)
do
    echo "  in $file"
    sed -e 's/\-fpascal\-strings .//g' $file > tempfile.tmp
    mv tempfile.tmp $file
    rm -f tempfile.tmp
done

echo 'replacing strdupa'
for file in $(grep -rl 'strdupa'  ./src/)
do
    echo "  in $file"
    sed -e 's;strdupa;strdup;' $file > tempfile.tmp
    mv tempfile.tmp $file
    rm  -f  tempfile.tmp 
done

echo 'including stdlib and cstdlib'
#makes sure that stdlib (for C code) and cstdlib (for C++ code) libraries are included for files which need them (i.e. files that call exit, malloc or calloc)

#C and STDLIB:
matchedFiles=$(egrep -rl 'exit|malloc|calloc'  --include '*.c' ./)
needsLib=$(egrep -L 'stdlib' $matchedFiles)
for ifile in $needsLib
do
    awk '/#include/ && !done { print "#include\<stdlib.h\>"; done=1;}; 1;' $ifile > tempfile.tmp
    mv tempfile.tmp $ifile
    rm -f tempfile.tmp
done

#C++ and CSTDLIB:
matchedFiles=$(egrep -rl 'exit|malloc|calloc'  --include '*.cpp' ./)
needsLib=$(egrep -L 'stdlib' $matchedFiles)
for ifile in $needsLib
do
    awk '/#include/ && !done { print "#include\<cstdlib\>"; done=1;}; 1;' $ifile > tempfile.tmp
    mv tempfile.tmp $ifile
    rm -f tempfile.tmp
done


