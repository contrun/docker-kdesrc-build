export KF5=$(grep kdedir $HOME/.kdesrc-buildrc  | awk '{ print $2 }')
#OS Qt5 installation in most cases
#export QTDIR=$(grep qtdir $HOME/.kdesrc-buildrc | awk '{ print $2 }' )
export XDG_DATA_DIRS="$KF5/share:$XDG_DATA_DIRS:/usr/share"
export XDG_CONFIG_DIRS="$KF5/etc/xdg:$XDG_CONFIG_DIRS:/etc/xdg"
export PATH="$KF5/bin:$QTDIR/bin:$PATH"
export QT_PLUGIN_PATH="$KF5/lib/plugins:$KF5/lib64/plugins:$KF5/lib/x86_64-linux-gnu/plugins:$QTDIR/plugins:$QT_PLUGIN_PATH"
export QML2_IMPORT_PATH="$KF5/lib/qml:$KF5/lib64/qml:$KF5/lib/x86_64-linux-gnu/qml:$QTDIR/qml"
export QML_IMPORT_PATH="$QML2_IMPORT_PATH"
export KDE_SESSION_VERSION="5"
export KDE_FULL_SESSION="true"

function run_xvfb ()
{
    sudo Xvfb $DISPLAY +extension RANDR -screen 0 1024x780x24 &
}

function kill_xvfb () 
{ 
    sudo kill -9 $(pgrep Xvfb)
}

function re_xvfb () 
{ 
    kill_xvfb
    run_xvfb 
}

function run_vnc () 
{
    x11vnc -usepw -display $DISPLAY &
}

function kill_vnc () 
{
    sudo kill -9 $(pgrep x11vnc)
}

function re_vnc ()
{
    kill_vnc
    run_vnc
}

fix_permissions ()
{
    echo "Fixing permissions on /work"
    # ensure /work is accessible to kdedev user (1000:1000)
    sudo chown kdedev:kdedev /work
}

fix_permissions
