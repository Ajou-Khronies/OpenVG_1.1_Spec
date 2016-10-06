for f in *.PNG; do 
mv -- "$f" "${f%.PNG}.png"
done