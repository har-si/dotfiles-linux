#!/usr/bin/env bash

# Define default applications
# Search the .desktop file at /usr/share/applications
# Specify the correct paths or names for the desktop files
DEFAULT_EDITOR="helix.desktop"
DEFAULT_BROWSER="brave-browser.desktop"
DEFAULT_IMAGE="org.gnome.Loupe.desktop"
DEFAULT_VIDEO="mpv.desktop"
DEFAULT_AUDIO="org.gnome.Rhythmbox3.desktop"
DEFAULT_PDF="org.pwmt.zathura.desktop"
DEFAULT_FILE="org.kde.okular.desktop"

# Function to update default applications
update_default_app() {
    MIME_TYPE=$1
    DEFAULT_APP=$2

    # Check if the desktop file exists
    CHECK_DEFAULT=$(fd -H -t f "$DEFAULT_APP" / 2>/dev/null) 
    if [ -n "$CHECK_DEFAULT" ] ; then
        # Check the current default application
        CURRENT_DEFAULT=$(xdg-mime query default $MIME_TYPE)

        # Set a new default application only if it's different
        if [ "$CURRENT_DEFAULT" != "$DEFAULT_APP" ]; then
            xdg-mime default $DEFAULT_APP $MIME_TYPE
            echo "Default application for $MIME_TYPE updated to $DEFAULT_APP"
        else
            echo "Default application for $MIME_TYPE is already set to $DEFAULT_APP"
        fi
    else
        echo "Error: Desktop file '$DEFAULT_APP' not found."
    fi
}

# Print the default applications to be set
echo "  Set the default application to:"
echo "  Editor            $DEFAULT_EDITOR"
echo "  Browser           $DEFAULT_BROWSER"
echo "  Image Viewer      $DEFAULT_IMAGE"
echo "  Video Player      $DEFAULT_VIDEO"
echo "  Audio Player      $DEFAULT_AUDIO"
echo "  PDF Viewer        $DEFAULT_PDF"
echo "  File Viewer       $DEFAULT_FILE"
echo 

# Prompt user for confirmation
read -p "Do you want to continue? (y/n): " choice
if [ "$choice" = "y" ]; then

    # Insert a blank line before performing the function
    echo 

    # Update default applications for each file type
    update_default_app text/plain $DEFAULT_EDITOR
    update_default_app text/markdown $DEFAULT_EDITOR
    update_default_app text/css $DEFAULT_EDITOR
    update_default_app application/json $DEFAULT_EDITOR
    update_default_app application/x-yaml $DEFAULT_EDITOR
    update_default_app text/html $DEFAULT_BROWSER
    update_default_app text/xml $DEFAULT_BROWSER
    update_default_app image/jpeg $DEFAULT_IMAGE
    update_default_app image/gif $DEFAULT_IMAGE
    update_default_app image/bmp $DEFAULT_IMAGE
    update_default_app image/png $DEFAULT_IMAGE
    update_default_app image/tiff $DEFAULT_IMAGE
    update_default_app image/webp $DEFAULT_IMAGE
    update_default_app image/svg+xml $DEFAULT_IMAGE
    update_default_app video/mp4 $DEFAULT_VIDEO
    update_default_app video/mpeg $DEFAULT_VIDEO
    update_default_app video/x-msvideo $DEFAULT_VIDEO
    update_default_app video/quicktime $DEFAULT_VIDEO
    update_default_app video/x-ms-wmv $DEFAULT_VIDEO
    update_default_app video/x-flv $DEFAULT_VIDEO
    update_default_app audio/mpeg $DEFAULT_AUDIO
    update_default_app audio/aac $DEFAULT_AUDIO
    update_default_app audio/wav $DEFAULT_AUDIO
    update_default_app audio/x-ms-wma $DEFAULT_AUDIO
    update_default_app audio/ogg $DEFAULT_AUDIO
    update_default_app application/pdf $DEFAULT_PDF
    update_default_app application/epub+zip $DEFAULT_FILE
    update_default_app application/vnd.amazon.ebook $DEFAULT_FILE

    # Text to indicate operation is complete
    echo
    echo "Complete!"
else
    echo 
    echo "Skipped updating default applications."
fi


# To include additional mime file type, just append the new file type inside the function with this syntax
#     update_default_app file/type $DEFAULT_APP_VARIABLE
# You may also add additional Default App Variable if necessary
