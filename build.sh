SECRETENV_PATH="secretenv_release"
if [ $# -gt 0 ] && [ $1 = test ]; then
  SECRETENV_PATH="secretenv_test"
fi
cp $SECRETENV_PATH secretenv
docker build -t gecko655/4min-faith .
