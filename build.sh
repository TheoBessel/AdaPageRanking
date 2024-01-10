echo "=======================[ Building the executable : ]======================="
echo ""

mkdir build

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -E -e "s/PageRank/Proj/g" pagerank.gpr > proj.gpr
else
    sed -E -e "/package Linker is/,/end Linker;/d" -e "s/PageRank/Proj/g" pagerank.gpr > proj.gpr
fi

for i in "$@"; do
    if [[ "$i" == "-test" ]]; then
        sed -E -i '' -e "s/for Main use \(\".*\"\);/for Main use \(\"testgraph.adb\", \"testiostream.adb\", \"testmatrix.adb\"\);/g" proj.gpr
    fi
done

gprbuild -P proj.gpr -cargs -gnatef

rm proj.gpr

echo ""
echo "==========================================================================="

for i in "$@"; do
    if [[ "$i" == "-run" ]]; then
        echo "\n\n"
        echo "=======================[ Running the executable : ]========================"
        echo ""
        echo "---------------------------------------------------------------------------"
        #sed -E -n -e '/for Main use \(\".*.adb\"\);/p' pagerank.gpr | sed -E -e 's/.*for Main use \(\"/.\/build\//' -e 's/.adb\"\);.*//' | bash
        time ./build/pagerank
        echo "---------------------------------------------------------------------------"
        echo ""
        echo "==========================================================================="
    elif [[ "$i" == "-test" ]]; then
        echo "\n\n"
        echo "=======================[ Running the executable : ]========================"
        echo ""
        echo "---------------------------------------------------------------------------"
        ./build/testgraph
        echo "---------------------------------------------------------------------------"
        ./build/testiostream
        echo "---------------------------------------------------------------------------"
        ./build/testmatrix
        echo "---------------------------------------------------------------------------"
        echo ""
        echo "==========================================================================="
    fi
done