mkdir build

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -E -e "s/PageRank/Proj/g" pagerank.gpr > proj.gpr
else
    sed -E -e "/package Linker is/,/end Linker;/d" -e "s/PageRank/Proj/g" pagerank.gpr > proj.gpr
fi

gprbuild -P proj.gpr -cargs -gnatef

rm proj.gpr

if [[ "$1" == "-run" ]]; then
    echo "========================="
    echo "Running the executable : "
    echo "-------------------------"

    sed -E -n -e '/for Main use \(\".*.adb\"\);/p' pagerank.gpr | sed -E -e 's/.*for Main use \(\"/.\/build\//' -e 's/.adb\"\);.*//' | bash

    echo "========================="
fi