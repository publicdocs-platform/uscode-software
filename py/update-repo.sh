
USC_SW_VER=$(git --git-dir=../uscode-software/.git rev-parse HEAD)



# for each title:


USCMDONLY=" "
for USCNUM in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60
do
  if [ -e assets/md/titles/usc$USCNUM/us ] || [ -e ../uscode-software/working/gen/titles/usc$USCNUM/us ] ; then
    git diff --exit-code --quiet --no-index assets/md/titles/usc$USCNUM/us ../uscode-software/working/gen/titles/usc$USCNUM/us
    if [ $? -eq 0 ] ; then
      echo P1 Skipping $USCNUM for now - no content difference.
      USCMDONLY="$USCMDONLY $USCNUM"
    else
      echo P1 Content difference for $USCNUM - committing.
      rm -rf assets/md/titles/usc$USCNUM
      mkdir assets/md/titles/usc$USCNUM
      cp -R ../uscode-software/working/gen/titles/usc$USCNUM assets/md/titles
      git add -A .
      git commit -m "Rel $USCRP1-$USCRP2 - USC $USCNUM

Generated with https://github.com/publicdocs/uscode-software/tree/$USC_SW_VER"
    fi
  else
    echo P1 No such title $USCNUM
  fi
done

for USCNUM in $USCMDONLY
do
  if [ -e assets/md/titles/usc$USCNUM/us ] || [ -e ../uscode-software/working/gen/titles/usc$USCNUM/us ] ; then
    echo P2 Metadata update $USCNUM
    rm -rf assets/md/titles/usc$USCNUM
    mkdir assets/md/titles/usc$USCNUM
    cp -R ../uscode-software/working/gen/titles/usc$USCNUM assets/md/titles
  else
    echo P2 No such title $USCNUM
  fi
done

git add -A .
git commit -m "Rel $USCRP1-$USCRP2 - USC titles with metadata update only: $USCMDONLY

Generated with https://github.com/publicdocs/uscode-software/tree/$USC_SW_VER"