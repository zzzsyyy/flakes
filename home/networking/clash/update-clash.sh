#!@shell@

update="@updateClashUrl@"

case "$1" in

    "g")
        $update $(cat "@gUrl@")
        ;;

    "x")
        $update $(cat "@xUrl@")
        ;;

    "y")
        $update $(cat "@yUrl@")
        ;;

    "https://*" | "http://*")
        $update "$1"
        ;;
esac
