[
  (final: prev: {
    # Until nixpkgs#215316 is resolved
    transmission = prev.transmission.overrideAttrs (old: {
      patches = [ ];
      nativeBuildInputs = old.nativeBuildInputs ++ [ prev.python3 ];
      src = prev.fetchFromGitHub {
        owner = "transmission";
        repo = "transmission";
        rev = "4.0.3";
        hash = "sha256-P7omd49xLmReo9Zrg0liO1msUVzCa5CxH7PGmH4oPzg=";
        fetchSubmodules = true;
      };
    });
  })
  (final: prev: {
    libjxl-with-plugin = final.callPackage ../pkgs/libjxl-with-plugin { };
  })
  (final: prev: {
    gnome = prev.gnome.overrideScope'
      (final': prev': {
        nautilus = prev'.nautilus.overrideAttrs (old: {
          preFixup = with prev; ''
            gappsWrapperArgs+=(
              # Thumbnailers
              --prefix XDG_DATA_DIRS : "${gdk-pixbuf}/share"
              --prefix XDG_DATA_DIRS : "${librsvg}/share"
              --prefix XDG_DATA_DIRS : "${webp-pixbuf-loader}/share"
              --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"
              --prefix XDG_DATA_DIRS : "${libjxl-with-plugin}/share"
            )
          '';
        });
        # gnome-control-center = prev'.gnome-control-center.overrideAttrs (old: {
        #   postInstall = ''
        #     export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
        #       extraLoaders = with prev; [
        #         librsvg
        #         webp-pixbuf-loader
        #         libjxl-with-plugin
        #       ];
        #     }}"
        #   '';
        # });
        #   gnome-shell = prev'.gnome-shell.overrideAttrs (old: {
        #     postInstall = ''
        #       export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
        #         extraLoaders = with prev; [
        #           librsvg
        #           webp-pixbuf-loader
        #           libjxl-with-plugin
        #         ];
        #       }}"
        #     '';
        #   });
      });
  })
  # (final: prev: {
  #   xdg-desktop-portal-gnome = prev.xdg-desktop-portal-gnome.overrideAttrs (old: {
  #     postInstall = ''
  #       export GDK_PIXBUF_MODULE_FILE="${prev.gnome._gdkPixbufCacheBuilder_DO_NOT_USE {
  #         extraLoaders = with prev;[
  #           librsvg
  #           webp-pixbuf-loader
  #           libjxl-with-plugin
  #         ];
  #       }}"
  #     '';
  #   });
  # })
  # (final: prev: {
  #   gnomeExtensions.paperwm = prev.gnomeExtensions.paperwm.overrideAttrs (old: {
  #     src = final.fetchFromGitHub {
  #       owner = "paperwm";
  #       repo = "PaperWM";
  #       rev = "v44.3.1";
  #       hash = "sha256-oGBnQGtx2ku4cfgZkZ3OdHlVuiYR8hy1eYDWDZP3fn4=";
  #     };
  #   });
  # })
]
