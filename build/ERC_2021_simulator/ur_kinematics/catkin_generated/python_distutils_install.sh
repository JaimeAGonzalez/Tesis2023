#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/diego/ERC_2021/src/ERC_2021_simulator/ur_kinematics"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/diego/ERC_2021/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/diego/ERC_2021/install/lib/python2.7/dist-packages:/home/diego/ERC_2021/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/diego/ERC_2021/build" \
    "/usr/bin/python2" \
    "/home/diego/ERC_2021/src/ERC_2021_simulator/ur_kinematics/setup.py" \
     \
    build --build-base "/home/diego/ERC_2021/build/ERC_2021_simulator/ur_kinematics" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/diego/ERC_2021/install" --install-scripts="/home/diego/ERC_2021/install/bin"