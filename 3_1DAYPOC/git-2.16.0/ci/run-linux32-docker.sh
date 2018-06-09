#!/bin/sh
#
# Download and run Docker image to build and test 32-bit Git
#

. ${0%/*}/lib-travisci.sh

docker pull daald/ubuntu32:xenial

# Use the following command to debug the docker build locally:
# $ docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash daald/ubuntu32:xenial
# root@container:/# /usr/src/git/ci/run-linux32-build.sh

docker run \
	--interactive \
	--env DEVELOPER \
	--env DEFAULT_TEST_TARGET \
	--env GIT_PROVE_OPTS \
	--env GIT_TEST_OPTS \
	--env GIT_TEST_CLONE_2GB \
	--volume "${PWD}:/usr/src/git" \
	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
	daald/ubuntu32:xenial \
	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)

check_unignored_build_artifacts

save_good_tree
