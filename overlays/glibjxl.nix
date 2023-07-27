[
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
        gnome-control-center = prev'.gnome-control-center.overrideAttrs (old: {
          postInstall = ''
            export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
              extraLoaders = with prev; [
                librsvg
                webp-pixbuf-loader
                libjxl-with-plugin
              ];
            }}"
          '';
        });
        gnome-shell = prev'.gnome-shell.overrideAttrs (old: {
          postInstall = ''
            export GDK_PIXBUF_MODULE_FILE="${prev'._gdkPixbufCacheBuilder_DO_NOT_USE {
              extraLoaders = with prev; [
                librsvg
                webp-pixbuf-loader
                libjxl-with-plugin
              ];
            }}"
          '';
        });
      });
  })
  (final: prev: {
    xdg-desktop-portal-gnome = prev.xdg-desktop-portal-gnome.overrideAttrs (old: {
      postInstall = ''
        export GDK_PIXBUF_MODULE_FILE="${prev.gnome._gdkPixbufCacheBuilder_DO_NOT_USE {
          extraLoaders = with prev;[
            librsvg
            webp-pixbuf-loader
            libjxl-with-plugin
          ];
        }}"
      '';
    });
  })
]
