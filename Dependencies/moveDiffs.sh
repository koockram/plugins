# moveDiffs.sh
#
# by Scoo
################################
# Creates a new repo structure wilt the differences src
#
# moveDiffs.sh repositories_new repositories_old diffs_new_old
#
# New repository is an updated dump of Artifactory, old is a previous export.
# diff_new_old will contain anything in new but not in old with the same structure.
#
################################

SRC=$1
DEST=$2
DIFF=$3

find $SRC -type f | while read n
do
  BASE=`echo $n |  sed "s/^$SRC//"`
  DESTF="$DEST$BASE"
  if [[ -f "$DESTF" || "$DESTF" = *-sources.jar ]]; then
    if [[ "$DESTF" = *-sources.jar ]]; then
      echo "$BASE is sources"
    else
      echo "$BASE exists"
    fi
  else
    echo "copying $BASE"
    DIR=`dirname "$BASE"`
    NEWDIR="$DIFF$DIR"
    if [[ ! -d "$NEWDIR" ]]; then
      mkdir -p "$NEWDIR"
    fi
    cp $n $NEWDIR
  fi
done

